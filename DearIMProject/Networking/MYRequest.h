//
//  MYRequest.h
//  MYBookkeeping
//
//  Created by APPLE on 2022/1/28.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYRequest : NSObject

- (void)requestApiName:(NSString *)apiName
               version:(NSString *)version
                 param:(NSDictionary *)param
               success:(void (^)(NSDictionary *result))success
               failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
