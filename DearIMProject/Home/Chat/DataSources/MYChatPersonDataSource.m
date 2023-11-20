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
    for (int i = 0; i < 10; i++) {
        MYChatPersonViewModel *vm = [[MYChatPersonViewModel alloc] init];
        vm.name = @"一个朋友";
        vm.msgContent = @"一个消息通知消息通知消息通知消息通知消息通知";
        vm.iconURL = @"https://img.iplaysoft.com/wp-content/uploads/2019/free-images/free_stock_photo.jpg";
        [array addObject:vm];
    }
    self.sectionModel.viewModels = array;
    [theDatabase getChatMessageWithPerson:0];
    if (self.successBlock) self.successBlock();
}

@end
