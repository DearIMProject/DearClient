//
//  MYChatMessageViewModel.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYChatMessageViewModel.h"

@implementation MYChatMessageViewModel

- (Class)itemViewClass {
    return NSClassFromString(@"MYChatMessageItemView");
}

@end
