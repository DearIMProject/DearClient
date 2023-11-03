//
//  MYUserManager.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYUserManager.h"
#import <MYUtils/MYUtils.h>
#import "MYLoginService.h"

NSString *const LOGIN_SUCCESS_NOTIFICATION = @"LOGIN_SUCCESS_NOTIFICATION";
NSString *const AUTO_LOGIN_SUCCESS_NOTIFICATION = @"AUTO_LOGIN_SUCCESS_NOTIFICATION";

@interface MYUserManager ()

@property (nonatomic, strong) MYLoginService *loginService;

@end

@implementation MYUserManager

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
        _loginService = [[MYLoginService alloc] init];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *userData = [defaults valueForKey:@"userData"];
        if (userData) {
            NSError *error;
            // 2.读取归档，并将其显示在对应文本框。
            MYUser *user = [NSKeyedUnarchiver unarchivedObjectOfClass:MYUser.class fromData:userData error:&error];
            [MYLog debug:[NSString stringWithFormat:@"init user = %@",user]];
            //TODO: wmy test
            if (!user) {
                user = [[MYUser alloc] init];
                user.token = @"tokens";
            }
            _user = user;
            
            
        }
    }
    return self;
}

- (BOOL)isLogin {
    return self.user;
}

- (BOOL)isExpireTime {
    if (self.user.expireTime == 0) {
        return YES;
    }
    long time = self.user.expireTime/1000;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:0];
    
    if (time - date.timeIntervalSince1970 < 5 * 24 * 60 * 60) {
        return YES;
    }
    return NO;
}

- (void)clearLoginInfo {
    self.user = nil;
}

- (void)setUser:(MYUser *)user {
    _user = user;
    if (user == nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:nil forKey:@"userData"];
        [defaults synchronize];
        return;
    }
    NSError *error;
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user requiringSecureCoding:NO error:&error];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:userData forKey:@"userData"];
    [defaults synchronize];
}

- (void)checkAutoLoginWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    if (self.isLogin && !self.isExpireTime) {
        [self.loginService autoLoginWithSuccess:success failure:^(NSError * _Nonnull error) {
            [self clearLoginInfo];
            if (failure) failure(error);
        }];
    }
}

@end
