//
//  MYSocketManager.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define TheSocket MYSocketManager.defaultSocketManager

@class MYSocketManager;

@protocol MYSocketManagerDelegate <NSObject>

@optional;

- (void)didConnectSuccess:(MYSocketManager *)manager;
- (void)didConnectFailure:(MYSocketManager *)manager error:(NSError *)error;

- (void)didWriteDataSuccess:(MYSocketManager *)manager;

- (void)didReceiveOnManager:(MYSocketManager *)manager message:(NSString *)message;

@end

@interface MYSocketManager : NSObject

@property (nonatomic, strong) NSString *host;

@property (nonatomic, assign) BOOL isConnect;

- (void)addDelegate:(id<MYSocketManagerDelegate>)delegate;
- (void)removeDelegate:(id<MYSocketManagerDelegate>)delegate;

+ (instancetype)defaultSocketManager;

- (void)connect;

- (void)disConnect;

- (void)sendText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
