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
    long userId = TheUserManager.user.userId;
    NSArray<MYDataChatPerson *> *chatPersons = [theDatabase getAllChatPersonWithUserId:userId];
    for (MYDataChatPerson *chatPerson in chatPersons) {
        MYChatPersonViewModel *vm = [[MYChatPersonViewModel alloc] init];
        [vm convertFromDBModel:chatPerson];
        [array addObject:vm];
    }
    self.sectionModel.viewModels = array;
    if (self.successBlock) self.successBlock();
}

@end
