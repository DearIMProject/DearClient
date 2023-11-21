//
//  MYChatMessageDataSource.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@class MYChatPersonViewModel;

@interface MYChatMessageDataSource : MYDataSource

@property (nonatomic, strong) MYChatPersonViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
