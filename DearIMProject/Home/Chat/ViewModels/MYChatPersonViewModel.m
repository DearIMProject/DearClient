//
//  MYChatPersonViewModel.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/16.
//

#import "MYChatPersonViewModel.h"

@implementation MYChatPersonViewModel

- (Class)itemViewClass {
    return NSClassFromString(@"MYChatPersonItemView");
}

- (CGSize)itemSize {
    return CGSizeMake(0, 64);
}
- (void)convertFromDBModel:(MYDataChatPerson *)chatPerson {
    self.name = chatPerson.name;
    self.iconURL = chatPerson.iconURL;
    self.userId = chatPerson.userId;
}

@end
