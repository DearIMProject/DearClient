//
//  MYProfileViewController.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/3.
//

#import "MYProfileViewController.h"
#import "MYProfileDataSource.h"
#import "MYApplicationManager.h"

@interface MYProfileViewController () <MYProfileDataSourceDelegate>

@property (nonatomic, strong) MYProfileDataSource *dataSource;

@end

@implementation MYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"profile".local;
    self.tableViewDelegate.dataSource = self.dataSource;
    @weakify(self);
    self.dataSource.successBlock = ^{
        @strongify(self);
        [self.tableView reloadData];
    };
    [self.dataSource request];
}

- (instancetype)init {
    if (self = [super init]) {
        self.tabBarItem.title = @"profile".local;
        self.tabBarItem.image = [UIImage systemImageNamed:@"person"];
        self.tabBarItem.selectedImage = [UIImage systemImageNamed:@"person.fill"];
    }
    return self;
}

#pragma mark - MYProfileDataSourceDelegate

- (void)requestBegin:(MYProfileDataSource *)datasource {
    [MBProgressHUD showLoadingToView:self.view];
}

- (void)logoutServiceSuccess:(BOOL)success error:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view];
    if (error) {
        [MBProgressHUD showError:error.domain toView:self.view];
    }
    [TheApplication refreshRootViewController];
}

- (MYProfileDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[MYProfileDataSource alloc] init];
        _dataSource.delegate = self;
    }
    return _dataSource;
}

@end
