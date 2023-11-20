//
//  MYChatMessageItemView.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYChatMessageItemView.h"
#import "MYChatMessageViewModel.h"

@interface MYChatMessageItemView ()

@property (nonatomic, strong) UILabel *contentLabel;/**< 内容  */
@property (nonatomic, strong) MYChatMessageViewModel *viewModel;


@end

@implementation MYChatMessageItemView
@dynamic viewModel;

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
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(kMargin * 0.5);
        make.bottom.mas_equalTo(-kMargin * 0.5);
        make.right.mas_equalTo(-kMargin);
    }];
}

#pragma mark - Event Response

- (void)setViewModel:(MYChatMessageViewModel *)viewModel {
    [super setViewModel:viewModel];
    if (![viewModel isKindOfClass:MYChatMessageViewModel.class]) {
        return;
    }
    self.contentLabel.text = viewModel.content;
}

#pragma mark - private methods
#pragma mark - getters & setters & init members


- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kBlackColor;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
#if DEBUG
        _contentLabel.layer.borderWidth = 1;
        _contentLabel.layer.borderColor = [UIColor redColor].CGColor;
#endif
    }
    return _contentLabel;
}

@end
