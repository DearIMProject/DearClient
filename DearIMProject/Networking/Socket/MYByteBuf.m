//
//  MYByteBuf.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/6.
//

#import "MYByteBuf.h"

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

- (void)writeInt:(int)value {

    Byte byte[] = {0,0,0,0};

    byte[0] = value & 0xFF000000;
    byte[1] = value & 0x00FF0000;
    byte[2] = value & 0x0000FF00;
    byte[3] = value & 0x000000FF;
    
    [self.data appendBytes:&byte length:sizeof(int)];
    _limit+=sizeof(int);
}

- (int)readInt {
    int value;
    [self.data getBytes:&value range:NSMakeRange(_position, sizeof(value))];
    _position += sizeof(value);
    
    Byte byte[] = {0,0,0,0};

    byte[0] = value & 0xFF000000;
    byte[1] = value & 0x00FF0000;
    byte[2] = value & 0x0000FF00;
    byte[3] = value & 0x000000FF;
    
//    Byte byte[] = {0,0,0,0};
//
//    byte[0] = value & 0xFF000000;
//    byte[1] = value & 0x00FF0000;
//    byte[2] = value & 0x0000FF00;
//    byte[3] = value & 0x000000FF;
//
    int result = 0;

    result = (int) ((byte[0] & 0xFF)
    | ((byte[1] & 0xFF)<<8)
    | ((byte[2] & 0xFF)<<16)
    | ((byte[3] & 0xFF)<<24));

    return result;


}

- (int)maxCapacity {
    return _capacity;
}

@end
