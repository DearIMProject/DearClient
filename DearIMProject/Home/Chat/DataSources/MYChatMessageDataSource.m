//
//  MYChatMessageDataSource.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYChatMessageDataSource.h"
#import "MYChatMessageViewModel.h"
#import "MYMessage+MYConvert.h"
#import <MYClientDatabase/MYClientDatabase.h>

#import "MYChatPersonViewModel.h"

@interface MYChatMessageDataSource ()

@property (nonatomic, strong) MYSectionModel *sectionModel;
@property (nonatomic, strong) NSMutableArray<MYChatMessageViewModel *> *vms;

@end

@implementation MYChatMessageDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sectionModel = [[MYSectionModel alloc] init];
        self.sectionModels = @[self.sectionModel];
        _vms = [NSMutableArray array];
        self.sectionModel.viewModels = self.vms;
    }
    return self;
}

- (void)request {
    NSArray<MYDataMessage *> *dataMessages = [theDatabase getChatMessageWithPerson:self.viewModel.userId];
    for (MYDataMessage *dataMessage in dataMessages) {
        MYChatMessageViewModel *vm = [[MYChatMessageViewModel alloc] init];
        [vm convertWithDataModel:dataMessage];
        [self.vms addObject:vm];
    }
    if (self.successBlock) {
        self.successBlock();
    }
}

- (void)addChatMessage:(MYMessage *)message byUser:(MYUser *)user {
    MYDataMessage *dbMessage = [MYMessage convertFromMessage:message];
    [theDatabase addChatMessage:dbMessage];
    MYChatMessageViewModel *vm = [[MYChatMessageViewModel alloc] init];
    [vm convertWithDataModel:dbMessage];
    [self.vms addObject:vm];
    if (self.successBlock) {
        self.successBlock();
    }
}
@end
