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

- (NSString *)getHost {
    return [NSString stringWithFormat:@"http://%@:8888",self.host];
}

- (void)setEnv:(MYNetworkEnv)env {
    _env = env;
    //TODO: wmy 域名加密
    switch (env) {
        case MYNetworkEnvDaily:
            self.host = @"172.16.92.113";
            break;
        case MYNetworkEnvPrepare:
            //TODO: wmy 域名加密
            self.host = @"localhost";
            break;
        case MYNetworkEnvOnline:
            //TODO: wmy 域名加密
            self.host = @"47.99.103.133";
            break;
        default:
            break;
    }
}

@end
