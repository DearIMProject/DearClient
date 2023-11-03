//
//  MYViewController+MYRouter.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYViewController+MYRouter.h"

@implementation MYViewController (MYRouter)


+ (NSString *)urlName {
//    NSAssert(false, @"subclass must override");
    return @"base";
}

- (void)routerURL:(NSString *)routerURL withParam:(NSDictionary *)param {
    [MYRouter.defaultRouter routerURL:routerURL withParameters:param];
}

@end
