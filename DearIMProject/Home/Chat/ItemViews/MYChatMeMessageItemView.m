//
//  MYChatMeMessageItemView.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYChatMeMessageItemView.h"
#import <MYUIKit/MYUIKit.h>
#import <SDWebImage/SDWebImage.h>
#import "MYChatMessageViewModel.h"

@interface MYChatMeMessageItemView ()

@property(nonatomic, strong) UILabel *contentLabel;/**< 内容  */
@property (nonatomic, strong) UIView *contentView;/**<  内容外围 */
@property(nonatomic, strong) MYChatMessageViewModel *viewModel;
@property (nonatomic, strong) UIImageView *meIconImageView;/**<  自己头像 */
@property(nonatomic, strong) UIStackView *stackView;
@end

@implementation MYChatMeMessageItemView
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
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(kMargin);
        make.bottom.mas_equalTo(-kMargin);
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
    [self.meIconImageView sd_setImageWithURL:[NSURL URLWithString:viewModel.iconURL]];
    
    self.contentView.backgroundColor = kThemeColor;
    self.contentLabel.textColor = kWhiteColor;
    self.meIconImageView.hidden = NO;
    
}

#pragma mark - private methods
#pragma mark - getters & setters & init members

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        [_stackView addArrangedSubview:UIView.new];
        [_stackView addArrangedSubview:self.contentView];
        [_stackView addArrangedSubview:self.meIconImageView];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.spacing = kMargin * 0.5;
        _stackView.alignment = UIStackViewAlignmentLeading;
        [self.meIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(kSecondIconWidth);
        }];
        self.meIconImageView.layer.cornerRadius = kSecondIconWidth * 0.5;
        [self.contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _stackView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kBlackColor;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.clipsToBounds = YES;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}


- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [_contentView addSubview:self.contentLabel];
        _contentView.layer.cornerRadius = kSpace;
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];
    }
    return _contentView;
}

- (UIImageView *)meIconImageView {
    if (!_meIconImageView) {
        _meIconImageView = [[UIImageView alloc] init];
        _meIconImageView.clipsToBounds = YES;
    }
    return _meIconImageView;
}
@end
