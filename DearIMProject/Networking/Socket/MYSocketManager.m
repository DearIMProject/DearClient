//
//  MYSocketManager.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYSocketManager.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import "MYMessageCodec.h"

@interface MYSocketManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *asyncSocket;
@property (nonatomic, strong) NSMutableArray<id<MYSocketManagerDelegate>> *delegates;
@property (nonatomic, strong) MYMessageCodec *msgCodec;

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
    //TODO: wmy test
//    {
//        NSData *data = [message.content dataUsingEncoding:NSUTF8StringEncoding];
//        [_asyncSocket writeData:data withTimeout:-1 tag:0];
//    }
    NSData *data = [self.msgCodec encodeWithMessage:message];
    NSLog(@"data = %@",data);
    [_asyncSocket writeData:data withTimeout:-1 tag:0];
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
        if ([delegate respondsToSelector:@selector(didWriteDataSuccess:)]) {
            [delegate didWriteDataSuccess:self];
        }
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSLog(@"😯接收到data: %@",data);
    for (id<MYSocketManagerDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didReceiveOnManager:message:)]) {            
            [delegate didReceiveOnManager:self message:[self.msgCodec decodeWithData:data]];
        }
    }
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag {
    NSLog(@"");
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    
}


@end
