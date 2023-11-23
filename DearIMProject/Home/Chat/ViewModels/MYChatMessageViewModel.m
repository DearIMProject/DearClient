//
//  MYChatMessageViewModel.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYChatMessageViewModel.h"
#import "MYUserManager.h"
#import <MYClientDatabase/MYClientDatabase.h>


@interface MYChatMessageViewModel ()

@property(nonatomic, weak) MYDBUser *dataChatPerson;
@property(nonatomic, assign) long fromId;/**<  消息发送方 */

@end

@implementation MYChatMessageViewModel

- (Class)itemViewClass {
    if (self.isBelongMe) {
        return NSClassFromString(@"MYChatMeMessageItemView");
    }
    return NSClassFromString(@"MYChatAnotherMessageItemView");
}

- (void)convertWithDataModel:(MYDataMessage *)dbModel {
    self.content = dbModel.content;
    self.fromId = dbModel.fromId;
    //TODO: wmy 通过通讯录获取icon
    self.dataChatPerson = [theChatUserManager chatPersonWithUserId:dbModel.fromId];
}

- (NSString *)iconURL {
    return self.dataChatPerson.iconURL;
}

- (BOOL)isBelongMe {
    if (self.fromId == TheUserManager.user.userId) {
        return YES;
    }
    return NO;
}

@end
