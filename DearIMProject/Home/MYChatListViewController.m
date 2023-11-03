//
//  MYChatListViewController.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/3.
//

#import "MYChatListViewController.h"

@interface MYChatListViewController ()

@end

@implementation MYChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    self.title = @"chat".local;
}

- (instancetype)init {
    if (self = [super init]) {
        self.tabBarItem.title = @"chat".local;
        self.tabBarItem.image = [UIImage systemImageNamed:@"lanyardcard"];
        self.tabBarItem.selectedImage = [UIImage systemImageNamed:@"lanyardcard.fill"];
    }
    return self;
}

@end
