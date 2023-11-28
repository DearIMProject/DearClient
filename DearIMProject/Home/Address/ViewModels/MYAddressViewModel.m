//
//  MYAddressViewModel.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/27.
//

#import "MYAddressViewModel.h"
#import "MYUser+MYConvert.h"

@implementation MYAddressViewModel

@dynamic model;

- (Class)itemViewClass {
    return NSClassFromString(@"MYAddressListItemView");
}

- (CGSize)itemSize {
    return CGSizeMake(0, 64);
}
- (void)convertFromDBModel:(MYDBUser *)chatPerson {
    //TODO: wmy 将chatPerson 转为user
    MYUser *user = [MYUser convertFromDBModel:chatPerson];
    [self converFromUser:user];
    
}

- (void)converFromUser:(MYUser *)user {
    self.model = user;
    self.name = user.username;
    self.iconURL = user.icon;
    self.userId = user.userId;
}

@end
