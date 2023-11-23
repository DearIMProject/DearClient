//
//  MYMessage+MYConvert.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/23.
//

#import "MYMessage+MYConvert.h"

@implementation MYMessage (MYConvert)

+ (MYDataMessage *)convertFromMessage:(MYMessage *)message {
    MYDataMessage *dbMessage = [[MYDataMessage alloc] init];
    dbMessage.msgId = message.msgId;
    dbMessage.fromId = message.fromId;
    dbMessage.fromEntity = message.fromEntity;
    dbMessage.toId = message.toId;
    dbMessage.toEntity = message.toEntity;
    dbMessage.content = message.content;
    dbMessage.messageType = message.messageType;
    dbMessage.timestamp = message.timestamp;
    return dbMessage;
}

@end
