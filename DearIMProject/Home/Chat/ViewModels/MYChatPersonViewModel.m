//
//  MYChatPersonViewModel.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/16.
//

#import "MYChatPersonViewModel.h"
#import "MYUser+MYConvert.h"

@implementation MYChatPersonViewModel

- (Class)itemViewClass {
    return NSClassFromString(@"MYChatPersonItemView");
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
    self.name = user.name;
    self.iconURL = user.iconURL;
    self.userId = user.userId;
}

@end
