//
// Created by APPLE on 2023/11/6.
//

#import "MYMessageCodec.h"
#import "MYMessage.h"

static int MAGIC_NUMBER = 891013;
static int VERSION = 1;

@implementation MYMessageCodec

- (NSData *)encodeWithMessage:(MYMessage *)message {
    if (!message) {
        return nil;
    }
    
    NSMutableData *data = [NSMutableData data];
    // 魔数
    int magic = ntohl(MAGIC_NUMBER);
    [NSData dataWithBytes:&magic length:sizeof(magic)];
    [data appendBytes:&magic length:sizeof(magic)];
    // 版本号
    int version = ntohl(VERSION);
    [data appendBytes:&version length:sizeof(int)];
    // 序列化
    MYMessageSerializeType type = ntohl(MYMessageSerializeType_JSON);
    [data appendBytes:&type length:sizeof(int)];
    // 消息id
    long msgId = ntohll(message.msgId);
    [data appendBytes:&msgId length:sizeof(long)];
    // 时间戳
    long timestamp = ntohll(message.timestamp);
    [data appendBytes:&timestamp length:sizeof(long)];
    // 发送方
    long fromId = ntohll(message.fromId);
    [data appendBytes:&fromId length:sizeof(int)];
    MYMessageEntityType fromTyp = ntohl(message.fromEntity);
    [data appendBytes:&fromTyp length:sizeof(int)];
    // 接收方
    long toId = ntohll(message.toId);
    [data appendBytes:&toId length:sizeof(int)];
    MYMessageEntityType toTyp = ntohl(message.toEntity);
    [data appendBytes:&toTyp length:sizeof(int)];
    NSString *content = message.content;
    int contentLength = ntohl(message.content.length);
    NSData *bytes = [content dataUsingEncoding:NSUTF8StringEncoding];
    [data appendBytes:&contentLength length:sizeof(int)];
    [data appendBytes:&bytes length:content.length];
    
    return data.copy;
}


- (MYMessage *)decodeWithData:(NSData *)oriData {
    
    NSLog(@"decode a message -----------------------------------------------");
    
    NSData *data = [NSData dataWithData:oriData];
    int magic_number;
    if (data.length < sizeof(int)) {
        return nil;
    }
    [data getBytes:&magic_number length:sizeof(int)];
    if (magic_number != MAGIC_NUMBER) {
        return nil;
    }
    
    // 版本号
    data = [data subdataWithRange:NSMakeRange(sizeof(int), [data length] - sizeof(int))];
    int version;
    if (data.length < sizeof(int)) {
        return nil;
    }
    [data getBytes:&version length:sizeof(int)];
    if (version > VERSION) {
        NSLog(@"请升级APP");
        return nil;
    }
    if (data.length < sizeof(long)) {
        return nil;
    }
    
    // 序列化
    data = [data subdataWithRange:NSMakeRange(sizeof(long), data.length - sizeof(long))];
    MYMessageSerializeType type;
    if (data.length < sizeof(int)) {
        return nil;
    }
    [data getBytes:&type length:sizeof(int)];
    if (type != MYMessageSerializeType_JSON) {
        return nil;
    }
    
    // msgId
    data = [data subdataWithRange:NSMakeRange(sizeof(int), data.length - sizeof(int))];
    long msgId;
    if (data.length < sizeof(long)) {
        return nil;
    }
    [data getBytes:&msgId length:sizeof(long)];
    NSLog(@"msgId = %ld", msgId);

    // 消息类型
    MYMessageType msgType;
    if (data.length < sizeof(int)) {
        return nil;
    }
    [data getBytes:&msgType length:sizeof(int)];
    NSLog(@"msgType = %d",msgType);
    
    // 时间戳
    data = [data subdataWithRange:NSMakeRange(sizeof(int), data.length - sizeof(int))];
    long timestamp;
    if (data.length < sizeof(long)) {
        return nil;
    }
    [data getBytes:&timestamp length:sizeof(long)];
    NSLog(@"timestamp = %ld",timestamp);
    
    // 发送方
    data = [data subdataWithRange:NSMakeRange(sizeof(long), data.length - sizeof(long))];
    long fromId;
    if (data.length < sizeof(long)) {
        return nil;
    }
    [data getBytes:&fromId length:sizeof(long)];
    NSLog(@"fromId = %ld",fromId);

    data = [data subdataWithRange:NSMakeRange(sizeof(long), data.length - sizeof(long))];
    MYMessageEntityType fromType;
    if (data.length < sizeof(int)) {
        return nil;
    }
    [data getBytes:&fromType length:sizeof(int)];
    NSLog(@"fromEntity = %d",fromType);
    
    // 接收方
    data = [data subdataWithRange:NSMakeRange(sizeof(long), data.length - sizeof(long))];
    long toId;
    if (data.length < sizeof(long)) {
        return nil;
    }
    [data getBytes:&toId length:sizeof(long)];
    NSLog(@"toId = %ld",toId);

    data = [data subdataWithRange:NSMakeRange(sizeof(long), data.length - sizeof(long))];
    MYMessageEntityType toType;
    if (data.length < sizeof(int)) {
        return nil;
    }
    [data getBytes:&toType length:sizeof(int)];
    NSLog(@"toType = %d",toType);
    
    // 消息内容长度
    data = [data subdataWithRange:NSMakeRange(sizeof(int), data.length - sizeof(int))];
    int length;
    if (data.length < sizeof(int)) {
        return nil;
    }
    [data getBytes:&length length:sizeof(int)];
    NSLog(@"contentLength = %d",length);
    
    // 消息内容
    data = [data subdataWithRange:NSMakeRange(sizeof(int), data.length - sizeof(int))];
    if (data.length < sizeof(int)) {
        return nil;
    }
    NSString *content;
    [data getBytes:&content length:length];
    NSLog(@"content:%@",content);
    data = [data subdataWithRange:NSMakeRange(length, data.length - length)];
    if (data.length != 0) {
        return nil;
    }
    
    MYMessage *message = [[MYMessage alloc] init];
    message.msgId = msgId;
    message.messageType = msgType;
    message.timestamp = timestamp;
    message.fromId = fromId;
    message.fromEntity = fromType;
    message.toId = toId;
    message.toEntity = toType;
    message.content = content;

    NSLog(@"decode a message end --------------------------------------------");
    
    return message;
}

@end
