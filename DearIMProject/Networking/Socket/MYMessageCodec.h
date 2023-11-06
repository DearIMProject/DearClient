//
// Created by APPLE on 2023/11/6.
//

#import <Foundation/Foundation.h>

@class MYMessage;


@interface MYMessageCodec : NSObject
/**
 * 消息编码
 */
- (NSData *)encodeWithMessage:(MYMessage *)message;

/**
 * 消息解码
 */
- (MYMessage *)decodeWithData:(NSData *)data;

@end