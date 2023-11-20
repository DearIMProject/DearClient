//
//  MYChatPersonDataSource.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/16.
//

//TODO: wmy 本地创建一个数据库，用于存放通讯录好友

#import "MYChatPersonDataSource.h"
#import "MYChatPersonViewModel.h"
#import <MYClientDatabase/MYClientDatabase.h>
#import "MYUserManager.h"

@interface MYChatPersonDataSource ()

@property (nonatomic, strong) MYSectionModel *sectionModel;

@end

@implementation MYChatPersonDataSource

- (instancetype)init {
    if(self = [super init]) {
        _sectionModel = [[MYSectionModel alloc] init];
        self.sectionModels = @[self.sectionModel];
    }
    return self;
}

- (void)request {
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray<MYDataChatPerson *> *chatPersons = [theDatabase getAllChatPersonWithUserId:TheUserManager.user.userId];
    for (MYDataChatPerson *chatPerson in chatPersons) {
        MYChatPersonViewModel *vm = [[MYChatPersonViewModel alloc] init];
        vm.name = chatPerson.name;
//        vm.msgContent;
        vm.iconURL = chatPerson.iconURL;
        [array addObject:vm];
    }
    self.sectionModel.viewModels = array;
    [theDatabase getChatMessageWithPerson:0];
    if (self.successBlock) self.successBlock();
}

@end
