//
//  MYChatMessageListViewController.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYChatMessageListViewController.h"
#import "MYViewController+MYRouter.h"
#import "MYChatMessageDataSource.h"

@interface MYChatMessageListViewController ()

@property (nonatomic, strong) MYChatMessageDataSource *datasource;

@end

@implementation MYChatMessageListViewController

__MY_ROUTER_REGISTER__

- (instancetype)initWithParam:(NSDictionary *)param {
    if (self = [super initWithParam:param]) {
        self.viewModel = param[@"viewModel"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initData {
    @weakify(self);
    self.datasource.successBlock = ^{
        @strongify(self);
        [self.tableView reloadData];
    };
    self.datasource.failureBlock = ^(NSError * _Nonnull error) {
        @strongify(self);
        [self.tableView reloadData];
    };
    [self.datasource request];
}

- (void)initView {
    self.tableView.dataSource = self.autolayoutDelegate;
    self.tableView.delegate = self.autolayoutDelegate;
    self.autolayoutDelegate.dataSource = self.datasource;
}

+ (NSString *)urlName {
    return @"messagelist";
}

- (MYChatMessageDataSource *)datasource {
    if (!_datasource) {
        _datasource = [[MYChatMessageDataSource alloc] init];
    }
    return _datasource;
}

@end
