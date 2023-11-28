//
//  MYRegisterViewController.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYRegisterViewController.h"
#import "MYViewController+MYRouter.h"

@interface MYRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *comfirmTextfield;

@end

@implementation MYRegisterViewController

__MY_ROUTER_REGISTER__

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)onClickRegister:(id)sender {
    NSString *name = self.nameTextfield.text;
}

+ (NSString *)urlName {
    return @"register";
}

@end
