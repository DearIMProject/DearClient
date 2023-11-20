//
//  MYChatMessageDataSource.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYChatMessageDataSource.h"
#import "MYChatMessageViewModel.h"


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
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        MYChatMessageViewModel *vm = [[MYChatMessageViewModel alloc] init];
        int count = arc4random() % 100;
        NSMutableString *content = [NSMutableString string];
        for (int i = 0; i < count; i++) {
            [content appendString:@"1"];
        }
        vm.content = content;
        [array addObject:vm];
    }
    self.sectionModel.viewModels = array;
    if (self.successBlock) {
        self.successBlock();
    }
}

@end
