//
//  MYByteBuf.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/6.
//

#import "MYByteBuf.h"
#import <MYUtils/MYUtils.h>

@interface MYByteBuf ()

@property (nonatomic, assign) unsigned int capacity;/**<  容量 */
@property (nonatomic, assign) int limit;/**<  写入限制 */
@property (nonatomic, assign) int position;/**<  读取位置 */
@property (nonatomic, strong) NSMutableData *data;/**<  放入的内容 */

@end

@implementation MYByteBuf

- (instancetype)initWithCapacity:(unsigned int)capacity {
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
    Byte bytes[length];
    [self.data getBytes:bytes range:NSMakeRange(self.position, length)];
    _position += length;
    NSData *resultData = [[NSData alloc] initWithBytes:bytes length:length];
    NSString *str = [resultData convertedToUtf8String];
    return str;
}

- (NSData *)readAll {
    _position = (int)self.data.length;
    return [self.data copy];
}

- (void)reset {
    self.position = 0;
    self.limit = 0;
}

- (int)maxCapacity {
    return (int)self.data.length - self.position;
}

- (int)length {
    return self.data.length;
}

@end
