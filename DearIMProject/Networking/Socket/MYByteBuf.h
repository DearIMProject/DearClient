//
//  MYByteBuf.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYByteBuf : NSObject

- (instancetype)init NS_UNAVAILABLE ;

- (instancetype)initWithCapacity:(unsigned long)capacity NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithData:(NSData *)data NS_DESIGNATED_INITIALIZER;

- (int)maxCapacity;

- (void)writeInt:(int)value;

- (int)readInt;

- (void)writeLong:(long)value;

- (long)readLong;

- (void)writeByte:(Byte)value;

- (Byte)readByte;

- (void)writeString:(NSString *)string;
- (NSString *)readStringWithLength:(NSUInteger)length;

- (NSData *)readDataWithLength:(NSInteger)length;


- (void)writeBytes:(Byte *)bytes length:(NSUInteger)length;
- (void)writeData:(NSData *)data;

- (NSData *)readAll;

- (void)reset;

- (void)clear;

- (int)length;

- (MYByteBuf *)sliceWithIndex:(int)index length:(int)length;

@end

NS_ASSUME_NONNULL_END
