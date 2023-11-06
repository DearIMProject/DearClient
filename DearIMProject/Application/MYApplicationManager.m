//
//  MYApplicationManager.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYApplicationManager.h"
#import <MYMVVM/MYMVVM.h>
#import "MYLoginViewController.h"
#import "MYUserManager.h"
#import "MYHomeTabbarViewController.h"
#import "ViewController.h"

@interface MYApplicationManager ()

@property(nonatomic, strong) MYNavigationViewController *naviController;

@end

@implementation MYApplicationManager

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)refreshRootViewController {
    self.mainWindow.rootViewController = self.rootViewController;
    [self.mainWindow makeKeyWindow];
}

- (UIViewController *)rootViewController {
    #if DEBUG
        ViewController *tabbar = [[ViewController alloc] init];
        UINavigationController *testnavi = [[UINavigationController alloc] initWithRootViewController:tabbar];
        return testnavi;
    #endif
    if ([MYUserManager.shared isLogin] && !MYUserManager.shared.isExpireTime) {
        MYHomeTabbarViewController *tabBar = [[MYHomeTabbarViewController alloc] init];
        return tabBar;
    }
    MYNavigationViewController *navi =
    [[MYNavigationViewController alloc] initWithRootViewController:MYLoginViewController.new];
    self.naviController = navi;
    return navi;
}

- (UIViewController *)topViewController {
    return self.naviController.topViewController;
}

#pragma mark - appdelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //用户自动登录
    @weakify(self);
    [TheUserManager checkAutoLoginWithSuccess:^{
//        [MBProgressHUD showSuccess:@"login_success".local toView:self.mainWindow];
    } failure:^(NSError * _Nonnull error) {
        @strongify(self);
//        [MBProgressHUD showError:error.description toView:self.mainWindow];
        self.mainWindow.rootViewController = self.rootViewController;
        [self.mainWindow makeKeyAndVisible];
    }];
    return YES;
}

@end
