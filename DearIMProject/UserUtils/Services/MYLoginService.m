//
//  MYLoginService.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYLoginService.h"
#import <YYModel/YYModel.h>
#import <MYUtils/MYUtils.h>
#import "MYUserManager.h"
#import "MYRequest.h"



@interface MYLoginService ()

@property (nonatomic, strong) MYRequest *request;

@end

@implementation MYLoginService

- (instancetype)init {
    if (self = [super init]) {
        _request = [[MYRequest alloc] init];
        
    }
    return self;
}

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
               success:(SuccessBlock)success
               failure:(FailureBlock)failure {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"email"] = email;
    // MD5Utils
    param[@"password"] = password;
    [self.request requestApiName:@"/user/login"
                         version:@""
                           param:param
                         success:^(NSDictionary * _Nonnull result) {
        TheUserManager.user = [MYUser yy_modelWithJSON:result[@"user"]];
        [NSNotificationCenter.defaultCenter postNotificationName:LOGIN_SUCCESS_NOTIFICATION object:nil];
        if (success) {
            success();
        }
        } failure:failure];
}

- (void)autoLoginWithSuccess:(SuccessBlock)success
                     failure:(FailureBlock)failure {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = TheUserManager.user.token;
    [self.request requestApiName:@"/user/autologin" version:@""
                           param:param
                         success:^(NSDictionary * _Nonnull result) {
        NSLog(@"");
        } failure:failure];
}
@end
