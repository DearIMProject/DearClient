//
//  MYAddressService.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/27.
//

#import <Foundation/Foundation.h>
#import "MYUser.h"
NS_ASSUME_NONNULL_BEGIN



@interface MYAddressService : NSObject

/// 获取所有的通讯录人员
/// - Parameters:
///   - success: 成功回调
///   - failure: 失败回调
- (void)getAllAddressListWithSuccess:(void(^)(NSArray<MYUser *> * _Nonnull users))success
                             failure:(void(^)(NSError * _Nonnull error))failure;

@end

NS_ASSUME_NONNULL_END
