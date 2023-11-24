//
//  MYSocketManager.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import <Foundation/Foundation.h>
#import "MYMessage.h"

NS_ASSUME_NONNULL_BEGIN

#define TheSocket MYSocketManager.defaultSocketManager

@class MYSocketManager;

@protocol MYSocketManagerDelegate <NSObject>

@optional;

- (void)didConnectSuccess:(MYSocketManager *)manager;
- (void)didConnectFailure:(MYSocketManager *)manager error:(NSError *)error;

- (void)didWriteDataSuccess:(MYSocketManager *)manager tag:(long)tag;

- (void)didReceiveOnManager:(MYSocketManager *)manager message:(MYMessage *)message;

@end

@interface MYSocketManager : NSObject

@property (nonatomic, strong) NSString *host;
@property (nonatomic, assign) NSInteger port;

@property (nonatomic, assign) BOOL isConnect;

- (void)addDelegate:(id<MYSocketManagerDelegate>)delegate;
- (void)removeDelegate:(id<MYSocketManagerDelegate>)delegate;

+ (instancetype)defaultSocketManager;

- (void)connect;

- (void)disConnect;

//- (void)sendText:(NSString *)text;

- (void)sendMessage:(MYMessage *)message;

@end

NS_ASSUME_NONNULL_END
