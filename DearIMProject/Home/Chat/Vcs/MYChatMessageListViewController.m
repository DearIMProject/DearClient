//
//  MYChatMessageListViewController.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYChatMessageListViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "MYViewController+MYRouter.h"
#import "MYChatMessageDataSource.h"
#import "MYChatTextView.h"
#import "MYChatManager.h"


@interface MYChatMessageListViewController () <MYChatTextViewDelegate,MYChatManagerDelegate>

@property(nonatomic, strong) MYChatMessageDataSource *datasource;

@property(nonatomic, strong) MYChatTextView *textView;

@property (nonatomic, assign) BOOL isKeyBoardShow;

@end

@implementation MYChatMessageListViewController

__MY_ROUTER_REGISTER__

#pragma mark - dealloc

- (void)dealloc {
    [theChatManager removeChatDelegate:self];
}
#pragma mark - life cycle

- (instancetype)initWithParam:(NSDictionary *)param {
    if (self = [super initWithParam:param]) {
        self.viewModel = param[@"viewModel"];
        self.datasource.viewModel = self.viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [theChatManager addChatDelegate:self];
    self.view.backgroundColor = kPageBackgroundColor;
    [self initView];
    [self initData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    IQKeyboardManager.sharedManager.enable = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    IQKeyboardManager.sharedManager.enable = YES;
}

- (void)initView {
    self.tableView.dataSource = self.autolayoutDelegate;
    self.tableView.delegate = self.autolayoutDelegate;
    self.autolayoutDelegate.dataSource = self.datasource;
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(64 + kSafeArea_Bottom);
//        make.height.mas_lessThanOrEqualTo(200 + kSafeArea_Bottom);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.textView.mas_top);
    }];
}

- (void)initData {

    @weakify(self);
    self.datasource.successBlock = ^{
        @strongify(self);
        [self.tableView reloadData];
    };
    self.datasource.failureBlock = ^(NSError *_Nonnull error) {
        @strongify(self);
        [self.tableView reloadData];
    };
    [self.datasource request];

    [self addKeyboardNotification];
    
}

- (void)addKeyboardNotification {
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onReceiveKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onReceiveKeyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onReceiveKeyboardDidChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
}



#pragma mark - Notification

- (void)onReceiveKeyboardDidChange:(NSNotification *)aNotification {
    NSValue *value = [[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    float animationDuration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect frame = [self.view.window.screen bounds];//屏幕尺寸
    CGRect viewFrame = self.view.frame;
    CGRect textViewFrame = self.textView.frame;
    if (self.isKeyBoardShow) {
        viewFrame.size.height = frame.size.height - keyboardHeight - kSafeAreaNavBarHeight;
        textViewFrame.size.height = 64;
    } else {
        viewFrame.size.height = frame.size.height - kSafeAreaNavBarHeight;
        textViewFrame.size.height = 64 + kSafeArea_Bottom;
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.view.frame = viewFrame;
        self.textView.frame = textViewFrame;
    }];
}

- (void)onReceiveKeyboardWillShow:(NSNotification *)aNotification {
    self.isKeyBoardShow = YES;
    //TODO: wmy 后期来改善UI问题
}

- (void)onReceiveKeyboardDidHide:(NSNotification *)aNotification {
    self.isKeyBoardShow = NO;
}
#pragma mark - MYChatTextViewDelegate

- (void)textView:(MYChatTextView *)textView didClickSendButtonWithText:(NSString *)text {
    [theChatManager sendContext:text toUser:self.viewModel.model withMsgType:MYMessageType_CHAT_MESSAGE];
}

#pragma mark - MYChatManagerDelegate

- (void)chatManager:(MYChatManager *)manager didReceiveMessage:(MYMessage *)message fromUser:(MYUser *)user {
    NSLog(@"content:%@",message.content);
    [self.datasource addChatMessage:message byUser:user];
}

#pragma mark - Event Response
#pragma mark - private methods
#pragma mark - getters & setters & init members

+ (NSString *)urlName {
    return @"messagelist";
}

- (MYChatMessageDataSource *)datasource {
    if (!_datasource) {
        _datasource = [[MYChatMessageDataSource alloc] init];
    }
    return _datasource;
}

- (MYChatTextView *)textView {
    if (!_textView) {
        _textView = [[MYChatTextView alloc] init];
        _textView.backgroundColor = kWhiteColor;
        _textView.delegate = self;
    }
    return _textView;
}



@end
