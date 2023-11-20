//
//  MYRequest.m
//  MYBookkeeping
//
//  Created by APPLE on 2022/1/28.
//

#import "MYRequest.h"
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import "MYUserManager.h"
#import "MYNetworkManager.h"
#import "MYApplicationManager.h"

typedef enum : NSUInteger {
    ERROR_CODE_TOKEN_EXPIRE = 1,
} ERROR_CODE;

@interface _MYResponseModel : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, assign) NSTimeInterval timestamp;/**<  时间戳 */

@end

@implementation _MYResponseModel



@end

@implementation MYRequest

- (void)requestApiName:(NSString *)apiName
               version:(NSString *)version
                 param:(NSDictionary *)param
               success:(void (^)(NSDictionary *result))success
               failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",MYNetworkManager.shared.getHost,apiName,version];
    NSDictionary *hearder;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.baseParam];
    [dict addEntriesFromDictionary:param];
    //TODO: wmy log
//    [MYLog debug:url];
    [manager POST:url parameters:dict headers:hearder progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _MYResponseModel *model = [_MYResponseModel yy_modelWithDictionary:responseObject];
        if (model.success) {
            if (success) {
                success(model.data);
            }
        } else {
            
            if ([model.data[@"errorCode"] intValue] == ERROR_CODE_TOKEN_EXPIRE) {
                MYUserManager.shared.user = nil;
                [MYApplicationManager.shared refreshRootViewController];
            } else {
                NSError *error = [NSError errorWithDomain:model.data[@"errorMsg"] code:1 userInfo:nil];
                if (failure) {
                    failure(error);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([error.domain isEqualToString:NSURLErrorDomain]) {
            // 服务异常
            NSString *exceptionString = NSLocalizedString(@"service_exception", nil);
            NSError *err = [NSError errorWithDomain:exceptionString code:500 userInfo:nil];
            if (failure) {
                failure(err);
            }
        } else {
            if (failure) {
                failure(error);
            }
        }
        
    }];
    
}

- (NSDictionary *)baseParam {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = MYUserManager.shared.user.token;
    return dict;
}

@end
