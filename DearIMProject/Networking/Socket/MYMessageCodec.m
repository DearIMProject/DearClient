//
// Created by APPLE on 2023/11/6.
//

#import "MYMessageCodec.h"
#import "MYMessage.h"
#import "MYByteBuf.h"

static int MAGIC_NUMBER = 891013;
static int VERSION = 1;

@interface MYMessageCodec ()

@end

@implementation MYMessageCodec

- (NSData *)encodeWithMessage:(MYMessage *)message {
    NSLog(@"decode a message -----------------------------------------------");
    
    if (!message) {
        return nil;
    }
    MYByteBuf *data = [[MYByteBuf alloc] initWithCapacity:10];
    // 魔数
    int magic = MAGIC_NUMBER;
    [data writeInt:magic];
    // 版本号
    int version = VERSION;
    [data writeByte:version];
    // 序列化
    MYMessageSerializeType type = MYMessageSerializeType_JSON;
    [data writeByte:type];

    // 消息id
    long msgId = message.msgId;
    [data writeLong:msgId];
    // 消息类型
    MYMessageType msgType = message.messageType;
    [data writeInt:msgType];
    // 时间戳
    long timestamp = message.timestamp;
    [data writeLong:timestamp];
    // 发送方
    long fromId = message.fromId;
    [data writeLong:fromId];
    MYMessageEntityType fromTyp = message.fromEntity;
    [data writeByte:fromTyp];
    // 接收方
    long toId = message.toId;
    [data writeLong:toId];
    MYMessageEntityType toTyp = message.toEntity;
    [data writeByte:toTyp];
    // 内容
    NSString *content = message.content;
    NSData *datas = [content dataUsingEncoding:NSUTF8StringEncoding];
    int contentLength = (int)datas.length;
    [data writeInt:contentLength];
    Byte abyte[contentLength];
    [datas getBytes:abyte range:NSMakeRange(0, datas.length)];
    [data writeBytes:abyte length:contentLength];
    NSLog(@"decode a message end --------------------------------------------");
    NSMutableData *result = [NSMutableData data];
    MYByteBuf *lengthBuf = [[MYByteBuf alloc] initWithCapacity:4];
//    [lengthBuf writeInt:[data length]];
    [result appendData:[data readAll]];
    NSLog(@"data = %@",result);
    
    return result;
}


- (MYMessage *)decodeWithData:(NSData *)oriData {
    
    NSLog(@"decode a message -----------------------------------------------");
    
    MYByteBuf *data = [[MYByteBuf alloc] initWithData:oriData];
    
    if (data.maxCapacity < sizeof(int)) {
        return nil;
    }
    
    int dataLength = [data readInt];
    NSLog(@"dataLength");
    
    int magic_number = [data readInt];
    if (magic_number != MAGIC_NUMBER) {
        return nil;
    }
    // 版本号
    if (data.maxCapacity < sizeof(int)) {
        return nil;
    }
    int version = [data readByte];;
    if (version > VERSION) {
        NSLog(@"请升级APP");
        return nil;
    }
    
    // 序列化
    if (data.maxCapacity < sizeof(VERSION)) {
        return nil;
    }
    MYMessageSerializeType type = [data readByte];
    if (type > MYMessageSerializeType_ALL) {
        return nil;
    }
    if (type != MYMessageSerializeType_JSON) {
        return nil;
    }
    
    // 消息id
    if (data.maxCapacity < sizeof(int)) {
        return nil;
    }
    long msgId = [data readLong];
    NSLog(@"msgId = %ld", msgId);

    // 消息类型
    if (data.maxCapacity < sizeof(int)) {
        return nil;
    }
    MYMessageType msgType = [data readInt];
    NSLog(@"msgType = %d",msgType);
    
    // 时间戳
    if (data.maxCapacity < sizeof(long)) {
        return nil;
    }
    long timestamp = [data readLong];
    NSLog(@"timestamp = %ld",timestamp);
    
    // 发送方
    if (data.maxCapacity < sizeof(long)) {
        return nil;
    }
    long fromId = [data readLong];
    NSLog(@"fromId = %ld",fromId);
    
    if (data.maxCapacity < sizeof(long)) {
        return nil;
    }
    MYMessageEntityType fromType = [data readByte];
    NSLog(@"fromEntity = %d",fromType);
    
    // 接收方
    if (data.maxCapacity < sizeof(long)) {
        return nil;
    }
    long toId = [data readLong];
    NSLog(@"toId = %ld",toId);
    if (data.maxCapacity < sizeof(long)) {
        return nil;
    }
    MYMessageEntityType toType = [data readByte];
    NSLog(@"toType = %d",toType);
    
    // 消息内容长度
    if (data.maxCapacity < sizeof(int)) {
        return nil;
    }
    int length = [data readInt];
    NSLog(@"contentLength = %d",length);
    if (data.maxCapacity < length) {
        return nil;
    }
    // 消息内容
    NSString *content = [data readStringWithLength:length];
    NSLog(@"content:%@",content);

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
