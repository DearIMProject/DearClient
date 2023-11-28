//
//  MYSocketManager.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYSocketManager.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import "MYMessageCodec.h"
#import "MYByteBuf.h"

@interface MYSocketManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *asyncSocket;
@property (nonatomic, strong) NSMutableArray<id<MYSocketManagerDelegate>> *delegates;
@property (nonatomic, strong) MYMessageCodec *msgCodec;
@property (nonatomic, strong) MYByteBuf *readBuf;/**<  读取的数据 */

@end

@implementation MYSocketManager

static MYSocketManager *__onetimeClass;
+ (instancetype)defaultSocketManager {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        __onetimeClass = [[MYSocketManager alloc] init];
    });
    return __onetimeClass;
}

- (instancetype)init {
    if (self = [super init]) {
        _asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        _msgCodec = [[MYMessageCodec alloc] init];
        _delegates = [NSMutableArray array];
        _host = @"127.0.0.1";
        _port = 9999;
        _readBuf = [[MYByteBuf alloc] initWithCapacity:100];
    }
    return self;
}

- (void)addDelegate:(id<MYSocketManagerDelegate>)delegate {
    if ([self.delegates containsObject:delegate]) {
        return;
    }
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id<MYSocketManagerDelegate>)delegate {
    if (![self.delegates containsObject:delegate]) {
        return;
    }
    [self.delegates removeObject:delegate];
}

- (void)connect {
    NSError *error;
    if ([_asyncSocket isConnected]) {
        [_asyncSocket disconnectAfterReadingAndWriting];
    }
    
    if (![_asyncSocket connectToHost:self.host onPort:self.port error:&error]) {
        for (id<MYSocketManagerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(didConnectFailure:error:)]) {
                [delegate didConnectFailure:self error:error];
            }
        }
    }// end of if
    if (error) {
        NSLog(@"😭😭😭😭😭😭通道连接失败：host:%@,port:%ld",self.host,(long)self.port);
    }
}

- (void)disConnect {
    [_asyncSocket disconnect];
}

- (void)sendMessage:(MYMessage *)message {
    NSData *data = [self.msgCodec encodeWithMessage:message];
    NSLog(@"data = %@",data);
    [_asyncSocket writeData:data withTimeout:-1 tag:message.timestamp];
}


#pragma GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"😄😄😄😄😄通道连接成功！！！！");
    if ([host isEqualToString:self.host] && port == self.port) {
        for (id<MYSocketManagerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(didConnectSuccess:)]) {
                [delegate didConnectSuccess:self];
            }
        }
    }
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    for (id<MYSocketManagerDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didWriteDataSuccess:tag:)]) {
            [delegate didWriteDataSuccess:self tag:tag];
        }
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSLog(@"😯接收到data: %@",data);
    Byte bytes[data.length];
    [data getBytes:bytes length:data.length];
    [self.readBuf writeBytes:bytes length:data.length];
    while (self.readBuf.length > 4) {// 长度为4
        int length = [self.readBuf readInt];
        if (self.readBuf.length >= length + 4) { // 粘包
            NSData *bodyData = [self.readBuf readDataWithLength:length];
            [self receiveData:bodyData];
            NSData *restData = [self.readBuf readDataWithLength:self.readBuf.length - length - 4];
            [self.readBuf clear];
            [self.readBuf writeData:restData];
        } else  { // 半包
            [sock readDataWithTimeout:-1 buffer:self.readBuf.readAll.mutableCopy bufferOffset:self.readBuf.length tag:0];
            return;
        }
    }
    [sock readDataWithTimeout:-1 buffer:self.readBuf.readAll.mutableCopy bufferOffset:self.readBuf.length tag:0];
}

- (void)receiveData:(NSData *)data {
    for (id<MYSocketManagerDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didReceiveOnManager:message:)]) {
            [delegate didReceiveOnManager:self message:[self.msgCodec decodeWithData:data]];
        }
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag {
    NSLog(@"");
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    
}


@end
