//
//  MYChatManager.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/16.
//  聊天相关链接业务
// 1，登录后监听登录信息，发送登录请求
// 2. 登录成功后向上发送通知
// 3. 维护一个待发送的队列。发送消息
// 4. 队列需要本地记录，下次启动登录成功后进行消息的自动发送
// 5.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define theChatManager MYChatManager.defaultChatManager

FOUNDATION_EXPORT NSString *const CHAT_CONNECT_SUCCESS;
FOUNDATION_EXPORT NSString *const CHAT_CONNECT_FAILURE;

@interface MYChatManager : NSObject

+ (instancetype)defaultChatManager;

- (void)initChat;

@end

NS_ASSUME_NONNULL_END