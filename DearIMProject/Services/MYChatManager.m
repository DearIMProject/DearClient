//
//  MYChatManager.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/16.
//

#import "MYChatManager.h"
#import "MYUserManager.h"
#import "MYSocketManager.h"
#import "MYMessageFactory.h"
#import "MYUser+MYConvert.h"

static int MAGIC_NUMBER = 891013;

NSString *const CHAT_CONNECT_SUCCESS = @"CHAT_CONNECT_SUCCESS";
NSString *const CHAT_CONNECT_FAILURE = @"CHAT_CONNECT_FAILURE";

@interface MYChatManager () <MYSocketManagerDelegate>

@property (nonatomic, strong) NSMutableArray<id<MYChatManagerDelegate>> *delegateArray;

@property (nonatomic, strong) NSTimer *timer;/**<  心跳机制 */

@end

@implementation MYChatManager

- (void)dealloc {
    [TheSocket removeDelegate:self];
}

static MYChatManager *__onetimeClass;
+ (instancetype)defaultChatManager {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        __onetimeClass = [[MYChatManager alloc] init];
    });
    return __onetimeClass;
}

- (instancetype)init {
    if (self = [super init]) {
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(onReceiveLoginNotification)
                                                   name:LOGIN_SUCCESS_NOTIFICATION object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(onReceiveLoginNotification)
                                                   name:AUTO_LOGIN_SUCCESS_NOTIFICATION object:nil];
        _delegateArray = [NSMutableArray array];
    }
    return self;
}

- (void)initChat {
    [TheSocket addDelegate:self];
}

- (void)addChatDelegate:(id<MYChatManagerDelegate>)delegate {
    if (![self.delegateArray containsObject:delegate]) {
        [self.delegateArray addObject:delegate];
    }
}

- (void)removeChatDelegate:(id<MYChatManagerDelegate>)delegate {
    if ([self.delegateArray containsObject:delegate]) {
        [self.delegateArray removeObject:delegate];
    }
}

#pragma mark - MYSocketManagerDelegate

- (void)didConnectSuccess:(MYSocketManager *)manager {
    // 发送登录信息
    MYMessage *message = [MYMessageFactory messageWithMesssageType:MYMessageType_REQUEST_LOGIN];
    message.content = TheUserManager.user.token;
    [TheSocket sendMessage:message];
}

- (void)didConnectFailure:(MYSocketManager *)manager error:(NSError *)error {
    
}

- (void)didWriteDataSuccess:(MYSocketManager *)manager tag:(long)tag {
    for (id<MYChatManagerDelegate> delegate in self.delegateArray) {
        if ([delegate respondsToSelector:@selector(chatManager:sendMessageSuccessWithTag:)]) {
            [delegate chatManager:self sendMessageSuccessWithTag:tag];
        }
    }
}

- (void)didReceiveOnManager:(MYSocketManager *)manager message:(MYMessage *)message {
    if (message.messageType == MYMessageType_REQUEST_LOGIN) {
        NSString *content = message.content;
        if (content.intValue == MAGIC_NUMBER) {
            //success
            [NSNotificationCenter.defaultCenter postNotificationName:CHAT_CONNECT_SUCCESS object:nil];
            [self sendContext:TheUserManager.user.token toUser:nil withMsgType:MYMessageType_REQUEST_OFFLINE_MSGS];
        } else {
            //TODO: wmy 重试机制
            NSLog(@"connect failure:%@",content);
            [NSNotificationCenter.defaultCenter postNotificationName:CHAT_CONNECT_FAILURE object:nil];
        }
    } else if (message.messageType == MYMessageType_REQUEST_OFFLINE_MSGS) {
        [self clearHeartbeat];
    } else if (message.messageType == MYMessageType_REQUEST_HEART_BEAT) {
        [self resetHeartbeat];
    } else if (message.messageType == MYMessageType_CHAT_MESSAGE) {
        [self resetHeartbeat];
        for (id<MYChatManagerDelegate> delegate in self.delegateArray) {
            if ([delegate respondsToSelector:@selector(chatManager:didReceiveMessage:fromUser:)]) {
                MYUser *user = [MYUser convertFromDBModel:[theChatUserManager chatPersonWithUserId:message.fromId]];
                [delegate chatManager:self didReceiveMessage:message fromUser:user];
            }
        }
    }
}

- (void)sendContext:(NSString *)content toUser:(MYUser *)user withMsgType:(MYMessageType)msgType {
    MYMessage *message = [MYMessageFactory messageWithMesssageType:msgType];
    message.content = content;
    message.toId = user.userId;
    message.toEntity = MYMessageEntiteyType_USER;
    [TheSocket sendMessage:message];
}

#pragma mark - heart beat

- (void)clearHeartbeat {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(sendHeartbeat) object:nil];
    [_timer timeInterval];
    _timer = nil;
}

- (void)resetHeartbeat {
    [self clearHeartbeat];
    NSInteger stepTime = 5 * 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:stepTime
                                              target:self
                                            selector:@selector(sendHeartbeat)
                                            userInfo:nil repeats:YES];
}

- (void)sendHeartbeat {
    MYMessage *message = [MYMessageFactory messageWithMesssageType:MYMessageType_REQUEST_HEART_BEAT];
    [self sendContext:nil toUser:nil withMsgType:MYMessageType_REQUEST_HEART_BEAT];
}

#pragma mark - notification

- (void)onReceiveLoginNotification {
    //1. 开启长连接
    [TheSocket connect];
}


@end
