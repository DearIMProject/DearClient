//
//  MYProfileDataSource.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYProfileDataSource.h"
#import "MYLoginService.h"
#import "MYProfileItemViewModel.h"

@interface MYProfileDataSource ()

@property (nonatomic, strong) MYLoginService *loginService;

@property (nonatomic, strong) MYSectionModel *profileSectionModel;

@property (nonatomic, strong) MYProfileItemViewModel *logoutViewModel;

@end

@implementation MYProfileDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _loginService = [[MYLoginService alloc] init];
        _profileSectionModel = [[MYSectionModel alloc] init];
        self.sectionModels = @[self.profileSectionModel];
        _logoutViewModel = [[MYProfileItemViewModel alloc] init];
        _logoutViewModel.title = @"logout".local;
        @weakify(self);
        _logoutViewModel.selectBlock = ^{
            @strongify(self);
            [self logout];
        };
        _profileSectionModel.viewModels = @[self.logoutViewModel];
    }
    return self;
}

- (void)logout {
    if ([self.delegate respondsToSelector:@selector(requestBegin:)]) {
        [self.delegate requestBegin:self];
    }
    @weakify(self);
    [self.loginService logoutWithSuccess:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(logoutServiceSuccess:error:)]) {
            [self.delegate logoutServiceSuccess:YES error:nil];
        }
    } failure:^(NSError * _Nonnull error) {
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(logoutServiceSuccess:error:)]) {
            [self.delegate logoutServiceSuccess:NO error:error];
        }
    }];
}

- (void)request {
    if (self.successBlock) {
        self.successBlock();
    }
}

@end
