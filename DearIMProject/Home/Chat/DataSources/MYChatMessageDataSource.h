//
//  MYChatMessageDataSource.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYDataSource.h"
#import "MYMessage.h"
#import "MYUser.h"

NS_ASSUME_NONNULL_BEGIN

@class MYChatPersonViewModel;

@interface MYChatMessageDataSource : MYDataSource

@property (nonatomic, strong) MYChatPersonViewModel *viewModel;

- (void)addChatMessage:(MYMessage *)message byUser:(MYUser *)user;

@end

NS_ASSUME_NONNULL_END
