//
//  MYProfileViewController.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/3.
//

#import "MYProfileViewController.h"

@interface MYProfileViewController ()

@end

@implementation MYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blueColor;
    self.title = @"profile".local;
}

- (instancetype)init {
    if (self = [super init]) {
        self.tabBarItem.title = @"profile".local;
        self.tabBarItem.image = [UIImage systemImageNamed:@"person"];
        self.tabBarItem.selectedImage = [UIImage systemImageNamed:@"person.fill"];
    }
    return self;
}

@end
