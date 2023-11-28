//
//  MYAddressService.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/27.
//

#import "MYAddressService.h"
#import "MYRequest.h"


@interface MYAddressService ()

@property (nonatomic, strong) MYRequest *request;

@end

@implementation MYAddressService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _request = [[MYRequest alloc] init];
    }
    return self;
}

- (void)getAllAddressListWithSuccess:(void(^)(NSArray<MYUser *> * _Nonnull users))success
                             failure:(void(^)(NSError * _Nonnull error))failure {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [self.request requestApiName:@"/addressbook/all" version:@""
                           param:param success:^(NSDictionary * _Nonnull result) {
            //TODO: wmy
        NSArray<MYUser *> *users = [NSArray yy_modelArrayWithClass:MYUser.class json:result[@"list"]];
        if (success) {
            success(users);
        }
        } failure:failure];
}



@end
