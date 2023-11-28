//
//  MYByteBuf.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/6.
//

#import "MYByteBuf.h"
#import <MYUtils/MYUtils.h>

@interface MYByteBuf ()

@property (nonatomic, assign) unsigned long capacity;/**<  容量 */
@property (nonatomic, assign) int limit;/**<  写入限制 */
@property (nonatomic, assign) int position;/**<  读取位置 */
@property (nonatomic, strong) NSMutableData *data;/**<  放入的内容 */

@end

@implementation MYByteBuf

- (instancetype)initWithCapacity:(unsigned long)capacity {
    if (self = [super init]) {
        _capacity = capacity;
        _position = 0;
        _limit = 0;
        _data = [NSMutableData dataWithCapacity:capacity];
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data {
    if (self = [super init]) {
        _capacity = data.length;
        _position = 0;
        _limit = 0;
        _data = [NSMutableData dataWithCapacity:_capacity];
        [self.data appendData:data];
        _limit += data.length;
    }
    return self;
}

- (void)writeInt:(int)value {

    Byte byte[] = {0,0,0,0};

    byte[0] = (value >> 24) & 0xFF;// 0xFF000000;
    byte[1] = (value >> 16) & 0xFF;// 0x00FF0000;
    byte[2] = (value >> 8) & 0xFF;// 0x0000FF00;
    byte[3] = value & 0xFF;
    
    [self.data appendBytes:&byte length:sizeof(int)];
    _limit+=sizeof(int);
}

- (int)readInt {
    int value;
    [self.data getBytes:&value range:NSMakeRange(_position, sizeof(value))];
    
    Byte byte[] = {0,0,0,0};

    byte[0] = (value >> 24) & 0xFF;// 0xFF000000;
    byte[1] = (value >> 16) & 0xFF;// 0x00FF0000;
    byte[2] = (value >> 8) & 0xFF;// 0x0000FF00;
    byte[3] = value & 0xFF;
    

//
    int result;
    result = (int) ((byte[0] & 0xFF)
    | ((byte[1] & 0xFF)<<8)
    | ((byte[2] & 0xFF)<<16)
    | ((byte[3] & 0xFF)<<24));
    _position += sizeof(value);
    return result;
}

- (void)writeLong:(long)value {
    Byte byte[] = {0,0,0,0,0,0,0,0};

    byte[0] = (value >> 56) & 0xFF;
    byte[1] = (value >> 48) & 0xFF;
    byte[2] = (value >> 40) & 0xFF;
    byte[3] = (value >> 32) & 0xFF;
    byte[4] = (value >> 24) & 0xFF;
    byte[5] = (value >> 16) & 0xFF;
    byte[6] = (value >> 8) & 0xFF;
    byte[7] = value & 0xFF;
    
    [self.data appendBytes:&byte length:sizeof(long)];
    _limit+=sizeof(long);
}

- (long)readLong {
    long value;
    NSRange range = NSMakeRange(_position, sizeof(value));
    [self.data getBytes:&value range:range];
    Byte byte[] = {0,0,0,0,0,0,0,0};

    byte[0] = (value >> 56) & 0xFF;
    byte[1] = (value >> 48) & 0xFF;
    byte[2] = (value >> 40) & 0xFF;
    byte[3] = (value >> 32) & 0xFF;
    byte[4] = (value >> 24) & 0xFF;
    byte[5] = (value >> 16) & 0xFF;
    byte[6] = (value >> 8) & 0xFF;
    byte[7] = value & 0xFF;

    long result;
    result = (long) (
                    (byte[0] & 0xFF)
                    | ((byte[1] & 0xFF)<<8)
                    | ((byte[2] & 0xFF)<<16)
                    | ((byte[3] & 0xFF)<<24)
                    | ((byte[4] & 0xFF)<<32)
                    | ((byte[5] & 0xFF)<<40)
                    | ((byte[6] & 0xFF)<<48)
                    | ((byte[7] & 0xFF)<<56)
                    );
    _position += sizeof(value);
    return result;
}

- (void)writeByte:(Byte)value {
    [self.data appendBytes:&value length:sizeof(value)];
    _limit+=sizeof(value);
}

- (Byte)readByte {
    Byte value;
    [self.data getBytes:&value range:NSMakeRange(_position, sizeof(value))];
    _position += sizeof(value);
    return value;
}

- (void)writeBytes:(Byte *)value length:(NSUInteger)length {
    // 反着放
    for (int i = 0; i < length; i++ ) {
        char c = value[i];
        [self.data appendBytes:&c length:1];
    }
    _limit+=length;
}

- (void)writeData:(NSData *)data {
    _limit += data.length;
    [self.data appendData:data];
}

- (void)writeString:(NSString *)string {
    NSUInteger length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSRange range = NSMakeRange(0, length);
    Byte *bytes =  (Byte*)malloc(length);;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [data getBytes:bytes range:range];
    [self writeBytes:bytes length:length];
    free(bytes);
}

- (NSString *)readStringWithLength:(NSUInteger)length {
    NSString *str = [[self readDataWithLength:length] convertedToUtf8String];
    return str;
}

- (NSData *)readDataWithLength:(NSInteger)length {
    Byte bytes[length];
    [self.data getBytes:bytes range:NSMakeRange(self.position, length)];
    _position += length;
    NSData *resultData = [[NSData alloc] initWithBytes:bytes length:length];
    return resultData;
}

- (NSData *)readAll {
    _position = (int)self.data.length;
    return [self.data copy];
}

- (void)reset {
    self.position = 0;
    self.limit = 0;
}

- (void)clear {
    [self reset];
    _data = [NSMutableData dataWithCapacity:self.maxCapacity];
}

- (int)maxCapacity {
    return (int)self.data.length - self.position;
}

- (int)length {
    return (int)self.data.length;
}

- (MYByteBuf *)sliceWithIndex:(int)index length:(int)length {
    //TODO: wmy 仅仅为功能实现，之后再做data数据的复用
    MYByteBuf *bytebuf = [[MYByteBuf alloc] initWithCapacity:length];
    Byte bytes[length];
    [self.data getBytes:&bytes range:NSMakeRange(index, length)];
    [bytebuf.data appendBytes:bytes length:length];
    return bytebuf;
}

@end

