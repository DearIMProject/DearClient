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

static int MAGIC_NUMBER = 891013;

NSString *const CHAT_CONNECT_SUCCESS = @"CHAT_CONNECT_SUCCESS";
NSString *const CHAT_CONNECT_FAILURE = @"CHAT_CONNECT_FAILURE";

@interface MYChatManager () <MYSocketManagerDelegate>

@end

@implementation MYChatManager

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
    }
    return self;
}

- (void)initChat {
    //TODO: wmy
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

- (void)didWriteDataSuccess:(MYSocketManager *)manager {
    
}

- (void)didReceiveOnManager:(MYSocketManager *)manager message:(MYMessage *)message {
    if (message.messageType == MYMessageType_REQUEST_LOGIN) {
        NSString *content = message.content;
        if (content.intValue == MAGIC_NUMBER) {
            //success
            [NSNotificationCenter.defaultCenter postNotificationName:CHAT_CONNECT_SUCCESS object:nil];
        } else {
            NSLog(@"connect failure:%@",content);
        }
    }
}

#pragma mark - notification

- (void)onReceiveLoginNotification {
    //1. 开启长连接
    TheSocket.host = @"172.16.92.59";
    TheSocket.port = 9999;
    [TheSocket addDelegate:self];
    [TheSocket connect];
}


@end
