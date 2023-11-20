//
//  MYHomeTabbarViewController.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/3.
//

#import "MYHomeTabbarViewController.h"
#import <MYMVVM/MYMVVM.h>
#import "MYProfileViewController.h"
#import "MYChatPersonListViewController.h"

@interface MYHomeTabbarViewController () <UITabBarControllerDelegate>

@property (nonatomic, strong) MYChatPersonListViewController *chatVC;/**<  聊天界面 */
@property (nonatomic, strong) MYProfileViewController *profileVC;/**<  我的 */

@end

@implementation MYHomeTabbarViewController

- (instancetype)init {
    if (self = [super init]) {
        self.viewControllers = @[self.chatVC,self.profileVC];
        [self addChildViewController:self.chatVC];
        [self addChildViewController:self.profileVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initData {
    self.delegate = self;
}

- (void)initView {
    UITabBarAppearance * bar = [UITabBarAppearance new];
    bar.backgroundColor = kWhiteColor;
    bar.backgroundEffect = nil;
    bar.selectionIndicatorTintColor = kThemeColor;
    self.tabBar.scrollEdgeAppearance = bar;
    self.tabBar.standardAppearance = bar;
    self.selectedIndex = 0;
}


#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    self.title = viewController.title;
}

- (MYChatPersonListViewController *)chatVC {
    if (!_chatVC) {
        _chatVC = [[MYChatPersonListViewController alloc] init];
    }
    return _chatVC;
}

- (MYProfileViewController *)profileVC {
    if (!_profileVC) {
        _profileVC = [[MYProfileViewController alloc] init];
    }
    return _profileVC;
}

@end
