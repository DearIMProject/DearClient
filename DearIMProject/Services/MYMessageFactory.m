//
//  MYMessageFactory.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/16.
//

#import "MYMessageFactory.h"
#import "MYLoginRequestMessage.h"
#import "MYChatMessage.h"
#import "MYUserManager.h"
#import "MYHeartBeatMessage.h"
#import "MYRequestOfflineMessage.h"
#import "MYReadedMessage.h"

@implementation MYMessageFactory
+ (MYMessage *)messageWithMesssageType:(MYMessageType)msgType {
    MYMessage *message;
    switch (msgType) {
        case MYMessageType_TEXT:
        case MYMessageType_PICTURE:
        case MYMessageType_FILE:
        case MYMessageType_LINK:
        case MYMessageType_CHAT_MESSAGE:
            message = [[MYChatMessage alloc] init];
            break;
        case MYMessageType_REQUEST_LOGIN:
            message = [[MYLoginRequestMessage alloc] init];
            break;
        case MYMessageType_REQUEST_HEART_BEAT:
            message = [[MYHeartBeatMessage alloc] init];
            break;
        case MYMessageType_REQUEST_OFFLINE_MSGS:
            message = [[MYRequestOfflineMessage alloc] init];
            break;
        case MYMessageType_READED_MESSAGE:
            message = [[MYReadedMessage alloc] init];
        default:
            break;
    }
    message.messageType = msgType;
    message.fromId = TheUserManager.user.userId;
    message.fromEntity = MYMessageEntiteyType_USER;
    message.timestamp = [[NSDate alloc] init].timeIntervalSince1970;
    return message;
}
@end
