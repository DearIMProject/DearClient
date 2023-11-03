//
//  MYSocketManager.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYSocketManager.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface MYSocketManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *asyncSocket;
@property (nonatomic, strong) NSMutableArray<id<MYSocketManagerDelegate>> *delegates;

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
        
        _delegates = [NSMutableArray array];
        _host = @"127.0.0.1";
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
    if (![_asyncSocket connectToHost:self.host onPort:8888 error:&error]) {
        for (id<MYSocketManagerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(didConnectFailure:error:)]) {
                [delegate didConnectFailure:self error:error];
            }
        }
    }// end of if
}

- (void)disConnect {
    [_asyncSocket disconnect];
}

- (void)sendText:(NSString *)text {
    
    NSData *sendData = [text dataUsingEncoding:NSUTF8StringEncoding];
    [_asyncSocket writeData:sendData withTimeout:-1 tag:0];
}


#pragma GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    if ([host isEqualToString:self.host] && port == 8888) {
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
    for (id<MYSocketManagerDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didReceiveOnManager:message:)]) {
            NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [delegate didReceiveOnManager:self message:newStr];
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
