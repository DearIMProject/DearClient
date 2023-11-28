//
//  MYAddressListItemView.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/27.
//

#import "MYAddressListItemView.h"
#import <MYRouter/MYRouter.h>
#import <SDWebImage/SDWebImage.h>
#import "MYAddressViewModel.h"

@interface MYAddressListItemView ()

@property (nonatomic, strong) MYAddressViewModel *viewModel;

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *nameLabel;/**<  名称 */
@property (nonatomic, strong) UILabel *contentLabel;/**<  内容 */
@property (nonatomic, strong) UIImageView *iconImageView;/**<  头像 */

@end

@implementation MYAddressListItemView

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
    [self addSubview:self.stackView];
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kIconWidth);
        make.centerY.equalTo(self);
        make.left.mas_equalTo(kMargin);
    }];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(kSpace);
        make.right.mas_lessThanOrEqualTo(self).offset(-kMargin);
        make.centerY.equalTo(self);
    }];
    
}

#pragma mark - Event Response

- (void)setViewModel:(MYAddressViewModel *)viewModel {
    [super setViewModel:viewModel];
    if (![viewModel isKindOfClass:MYAddressViewModel.class]) {
        return;
    }
    self.nameLabel.text = viewModel.name;
    self.contentLabel.text = viewModel.msgContent;
    NSString *iconURL = viewModel.iconURL;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconURL]];
}

- (void)onSelected {
    NSMutableDictionary *dict = @{}.mutableCopy;
    dict[@"viewModel"] = self.viewModel;
    [MYRouter routerURL:@"dearim://messagelist" withParameters:dict];
}

#pragma mark - private methods
#pragma mark - getters & setters & init members

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisVertical;
        [_stackView addArrangedSubview:self.nameLabel];
        [_stackView addArrangedSubview:self.contentLabel];
        _stackView.spacing = kSpace;
    }
    return _stackView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = kSpace;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kBlackColor;
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kBlackColor;
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}


@end
