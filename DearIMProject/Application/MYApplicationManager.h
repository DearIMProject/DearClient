//
//  MYApplicationManager.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import <UIKit/UIKit.h>

#define TopViewController() MYApplicationManager.shared.topViewController

#define TheApplication MYApplicationManager.shared

NS_ASSUME_NONNULL_BEGIN

@interface MYApplicationManager : NSObject

@property (nonatomic, strong) UIWindow *mainWindow;

+ (instancetype)shared;

- (UIViewController *)rootViewController;

- (void)refreshRootViewController;

- (UIViewController *)topViewController;

#pragma mark - application
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
