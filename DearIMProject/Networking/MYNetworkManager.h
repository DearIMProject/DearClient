//
//  MYNetworkManager.h
//  MYBookkeeping
//
//  Created by APPLE on 2022/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define theNetworkManager MYNetworkManager.shared

typedef enum : NSUInteger {
    MYNetworkEnvDaily,
    MYNetworkEnvPrepare,
    MYNetworkEnvOnline,
} MYNetworkEnv;

@interface MYNetworkManager : NSObject

@property (nonatomic, strong) NSString *host;/**<  域名 */

@property (nonatomic, assign) MYNetworkEnv env;

+ (instancetype)shared;

- (NSString *)getHost;

@end

NS_ASSUME_NONNULL_END
