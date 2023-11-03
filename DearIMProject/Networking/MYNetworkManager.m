//
//  MYNetworkManager.m
//  MYBookkeeping
//
//  Created by APPLE on 2022/1/28.
//

#import "MYNetworkManager.h"

@interface MYNetworkManager ()

@end

@implementation MYNetworkManager

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认线上
        self.env = MYNetworkEnvOnline;
        // 如果是debug环境，默认本地调试
#if DEBUG
        self.env = MYNetworkEnvDaily;
#endif
    }
    return self;
}

- (void)setEnv:(MYNetworkEnv)env {
    _env = env;
    //TODO: wmy 域名加密
    switch (env) {
        case MYNetworkEnvDaily:
            self.host = @"http://172.16.92.65:8888";
            break;
        case MYNetworkEnvPrepare:
            //TODO: wmy 域名加密
            self.host = @"http://localhost:8888";
            break;
        case MYNetworkEnvOnline:
            //TODO: wmy 域名加密
            self.host = @"http://47.99.103.133:8888";
            break;
        default:
            break;
    }
}

@end
