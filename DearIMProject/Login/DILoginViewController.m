//
//  DILoginViewController.m
//  DearIMProject
//
//  Created by APPLE on 2023/10/8.
//

#import "DILoginViewController.h"

@interface DILoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)onClickLogin:(id)sender;
- (IBAction)onClickRegist:(id)sender;
- (IBAction)onClickFgtBtn:(id)sender;

@end

@implementation DILoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)onClickFgtBtn:(id)sender {
    //TODO: 到忘记密码页面
}

- (IBAction)onClickRegist:(id)sender {
    //TODO: wmy 到注册页面
}

- (IBAction)onClickLogin:(id)sender {
    //TODO: wmy 登录
    // 1. 判断用户名是否填写
    // 2. 判断密码是否填写
    // 3. 调用接口 - 成功跳转到成功页面
    // 4. 失败 - 弹toast
}
@end
