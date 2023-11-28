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
#import "MYAddressListViewController.h"

@interface MYHomeTabbarViewController () <UITabBarControllerDelegate>

@property (nonatomic, strong) MYChatPersonListViewController *chatVC;/**<  聊天界面 */
@property (nonatomic, strong) MYProfileViewController *profileVC;/**<  我的 */
@property (nonatomic, strong) MYAddressListViewController *addressListVC;

@end

@implementation MYHomeTabbarViewController

- (instancetype)init {
    if (self = [super init]) {
        _chatVC = [[MYChatPersonListViewController alloc] init];
        _profileVC = [[MYProfileViewController alloc] init];
        _addressListVC = [[MYAddressListViewController alloc] init];
        self.viewControllers = @[self.chatVC,self.addressListVC,self.profileVC];
        [self addChildViewController:self.chatVC];
        [self addChildViewController:self.addressListVC];
        [self addChildViewController:self.profileVC];
        self.title = self.chatVC.title;
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

@end
