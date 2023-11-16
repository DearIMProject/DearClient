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
    NSString *messageStr = self.textView.text;
    MYMessage *message = [[MYMessage alloc] init];
    message.msgId = 11223344;
    message.fromId = 11;
    message.fromEntity = MYMessageEntiteyType_USER;
    message.toId = 22;
    message.toEntity = MYMessageEntiteyType_USER;
    message.content = messageStr;
    message.messageType = MYMessageType_TEXT;
    message.timestamp = [[NSDate alloc] init].timeIntervalSince1970;
    
    NSLog(@"要发送的消息为 message= %@",message);
    
    [TheSocket sendMessage:message];
}

#pragma mark - MYSocketManagerDelegate

- (void)didConnectSuccess:(MYSocketManager *)manager {
    NSLog(@"连接成功！");
}
- (void)didConnectFailure:(MYSocketManager *)manager error:(NSError *)error {
    NSLog(@"连接失败！%@", error);
}

- (void)didWriteDataSuccess:(MYSocketManager *)manager {
    NSLog(@"发送成功");
}

- (void)didReceiveOnManager:(MYSocketManager *)manager message:(MYMessage *)message {
    NSLog(@"message = %@",message);
    self.receiveLabel.text = message.content;
}

@end
