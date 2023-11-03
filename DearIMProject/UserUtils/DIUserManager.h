//
//  MYUserManager.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import <Foundation/Foundation.h>
#import "MYUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYUserManager : NSObject
+ (instancetype)shared;

@property (nonatomic, strong,nullable) MYUser *user;

- (BOOL)isLogin;

/**
 是否过期
 */
- (BOOL)isExpireTime;
@end

NS_ASSUME_NONNULL_END
