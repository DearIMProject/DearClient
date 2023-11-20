//
//  MYUserManager.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import <Foundation/Foundation.h>
#import "MYUser.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const LOGIN_SUCCESS_NOTIFICATION;
FOUNDATION_EXPORT NSString *const AUTO_LOGIN_SUCCESS_NOTIFICATION;
FOUNDATION_EXPORT NSString *const LOGOUT_NOTIFICATION;

#define TheUserManager MYUserManager.shared

@interface MYUserManager : NSObject
+ (instancetype)shared;

@property (nonatomic, strong,nullable) MYUser *user;

- (void)clearLoginInfo;

- (BOOL)isLogin;

/**
 是否过期
 */
- (BOOL)isExpireTime;

/// 自动登录
/// - Parameters:
///   - success: 登录成功
///   - failure: 登录失败
- (void)checkAutoLoginWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure;



@end

NS_ASSUME_NONNULL_END
