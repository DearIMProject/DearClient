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

- (instancetype)initWithCapacity:(unsigned int)capacity NS_DESIGNATED_INITIALIZER;

- (int)maxCapacity;

- (void)writeInt:(int)value;

- (int)readInt;

@end

NS_ASSUME_NONNULL_END
