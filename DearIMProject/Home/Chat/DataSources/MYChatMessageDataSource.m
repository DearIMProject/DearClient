//
//  MYChatMessageDataSource.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYChatMessageDataSource.h"
#import "MYChatMessageViewModel.h"
#import <MYClientDatabase/MYClientDatabase.h>

#import "MYChatPersonViewModel.h"

@interface MYChatMessageDataSource ()

@property (nonatomic, strong) MYSectionModel *sectionModel;

@end

@implementation MYChatMessageDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sectionModel = [[MYSectionModel alloc] init];
        self.sectionModels = @[self.sectionModel];
    }
    return self;
}

- (void)request {
    NSMutableArray<MYChatMessageViewModel *> *vms = [NSMutableArray array];
    NSArray<MYDataMessage *> *dataMessages = [theDatabase getChatMessageWithPerson:self.viewModel.userId];
    for (MYDataMessage *dataMessage in dataMessages) {
        MYChatMessageViewModel *vm = [[MYChatMessageViewModel alloc] init];
        [vm convertWithDataModel:dataMessage];
        [vms addObject:vm];
    }
    self.sectionModel.viewModels = vms;
    if (self.successBlock) {
        self.successBlock();
    }
}


@end
