//
//  MYTestChatViewController.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYTestChatViewController.h"
#import "MYSocketManager.h"

@interface MYTestChatViewController () <MYSocketManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *receiveLabel;

- (IBAction)onClickSend:(id)sender;

@end

@implementation MYTestChatViewController

- (void)dealloc {
    [TheSocket removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试消息的发送和接收";
    [TheSocket addDelegate:self];
}
- (IBAction)onClickConnect:(id)sender {
    [TheSocket connect];
}

- (IBAction)onClickUpdateAddress:(id)sender {
    TheSocket.host = self.addressTextField.text;
}

- (IBAction)onClickSend:(id)sender {
    NSString *message = self.textView.text;
    [TheSocket sendText:message];
}

#pragma mark - MYSocketManagerDelegate

- (void)didConnectSuccess:(MYSocketManager *)manager {
    NSLog(@"连接成功！");
}
- (void)didConnectFailure:(MYSocketManager *)manager error:(NSError *)error {
    
}

- (void)didWriteDataSuccess:(MYSocketManager *)manager {
    NSLog(@"发送成功");
}

- (void)didReceiveOnManager:(MYSocketManager *)manager message:(NSString *)message {
    NSLog(@"message = %@",message);
    self.receiveLabel.text = message;
}

@end
