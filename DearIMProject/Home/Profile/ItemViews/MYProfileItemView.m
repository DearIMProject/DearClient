//
//  MYProfileItemView.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYProfileItemView.h"
#import "MYProfileItemViewModel.h"

@interface MYProfileItemView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) MYProfileItemViewModel *viewModel;

@end

@implementation MYProfileItemView

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
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.equalTo(self);
    }];
}

#pragma mark - Event Response

- (void)setViewModel:(MYProfileItemViewModel *)viewModel {
    [super setViewModel:viewModel];
    if (![viewModel isKindOfClass:MYProfileItemViewModel.class]) {
        return;
    }
    self.titleLabel.text = viewModel.title;
}

- (void)onSelected {
    if (self.viewModel.selectBlock) {
        self.viewModel.selectBlock();
    }
}

#pragma mark - private methods
#pragma mark - getters & setters & init members

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        //TODO: wmy test
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

@end
