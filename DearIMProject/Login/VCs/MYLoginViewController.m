//
//  MYLoginViewController.m
//  DearIMProject
//
//  Created by APPLE on 2023/10/8.
//

#import "MYLoginViewController.h"
#import <MYUtils/MYUtils.h>
#import "MYUserManager.h"
#import "MYChatManager.h"
#import "MYLoginService.h"

@interface MYLoginViewController ()

@property (nonatomic, strong) MYLoginService *service;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)onClickLogin:(id)sender;
- (IBAction)onClickRegist:(id)sender;
- (IBAction)onClickFgtBtn:(id)sender;

@end

@implementation MYLoginViewController

__MY_ROUTER_REGISTER__

+ (NSString *)urlName {
    return @"login";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(onReceiveLoginSuccess)
                                               name:LOGIN_SUCCESS_NOTIFICATION
                                             object:nil];
    self.navigationController.navigationBar.translucent = YES;
#if DEBUG
    self.nameTextField.text = @"apple1@apple.com";
    self.passwordTextField.text = @"apple";
#endif
}

- (void)onReceiveLoginSuccess {
    
}

- (IBAction)onClickFgtBtn:(id)sender {
    //TODO: 到忘记密码页面
    [self routerURL:@"dearim://forgetpwd" withParam:@{}];
}

- (IBAction)onClickRegist:(id)sender {
    //TODO: wmy 到注册页面
    [self routerURL:@"dearim://register" withParam:@{}];
}

- (IBAction)onClickLogin:(id)sender {
    //TODO: wmy 登录
    // 1. 判断用户名是否填写
    // 2. 判断密码是否填写
    // 3. 调用接口 - 成功跳转到成功页面
    NSString *userName = self.nameTextField.text;
    NSString *password = self.passwordTextField.text;
    [theChatManager initChat];
    @weakify(self);
    [self.service loginWithEmail:userName
                        password:password
                         success:^{
        @strongify(self);
        [MBProgressHUD showSuccess:@"成功！" toView:self.view];
        //TODO: wmy 刷新
        [TheApplication refreshRootViewController];
    } failure:^(NSError * _Nonnull error) {
//        @strongify(self);
        //TODO: wmy show error
        [MBProgressHUD showSuccess:error.domain toView:self.view];
    }];
    // 4. 失败 - 弹toast
}


- (MYLoginService *)service {
    if (!_service) {
        _service = [[MYLoginService alloc] init];
    }
    return _service;
}

@end
