//
//  MYViewController+MYRouter.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYViewController.h"
#import <MYRouter/MYRouter.h>
#import "MYRouterAction.h"
#import "MYApplicationManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYViewController (MYRouter)

+ (NSString *)urlName;

/**
 路由至某个URL

 @param routerURL url
 @param param param
 */
- (void)routerURL:(NSString *)routerURL withParam:(NSDictionary *)param;

- (instancetype)initWithParam:(NSDictionary *)param;

@end

#define __MY_ROUTER_REGISTER__ \
+ (void)load { \
    [MYRouter.defaultRouter registerRouter:[self urlName] handlerAction:^BOOL(NSDictionary *dict) { \
        MYViewController *vc = [[self alloc] initWithParam:dict]; \
        [TopViewController().navigationController pushViewController:vc animated:YES]; \
        return YES; \
    }]; \
} \

NS_ASSUME_NONNULL_END
