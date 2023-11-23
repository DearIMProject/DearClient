//
//  MYChatTextView.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/22.
//

#import "MYChatTextView.h"
#import <Masonry/Masonry.h>
#import <MYSkin/MYSkin.h>
#import <MYUtils/MYUtils.h>

@interface MYChatTextView () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end

@implementation MYChatTextView

#pragma mark - dealloc
#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.right.mas_equalTo(-kMargin);
        make.top.mas_equalTo(kMargin * 0.5);
        make.height.mas_equalTo(48);
    }];
    [self.textView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

#pragma mark - Event Response

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *str = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([text isEqualToString:@"\n"]) {
        str = [str trim];
        NSLog(@"输入内容:%@",str);
        if ([self.delegate respondsToSelector:@selector(textView:didClickSendButtonWithText:)]) {
            [self.delegate textView:self didClickSendButtonWithText:str];
        }
        [textView resignFirstResponder];
        return NO;
    }    
    return YES;
}

#pragma mark - getters & setters & init members

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        _textView.backgroundColor = kSecondGrayColor;
        _textView.layer.cornerRadius = kSpace;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.textColor = kBlackColor;
        _textView.text = @"123";
    }
    return _textView;
}

@end
