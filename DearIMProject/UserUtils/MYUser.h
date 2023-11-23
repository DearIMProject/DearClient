//
//  MYUser.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYUser : NSObject <NSCoding, NSSecureCoding>

@property (nonatomic, assign) long long userId;/**< 用户id  */
@property (nonatomic, strong) NSString *name;/**<  用户名称 */
@property (nonatomic, strong) NSString *email;/**<  邮箱 */
@property (nonatomic, strong) NSString *os;/**< 型号  */
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *iconURL;/**< 头像  */ 
@property (nonatomic, assign) long expireTime;
@property (nonatomic, assign) BOOL vipStatus;
@property (nonatomic, assign) NSTimeInterval vipExpired;

- (BOOL)isVip;
@end

NS_ASSUME_NONNULL_END
