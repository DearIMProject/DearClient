//
//  MYChatMessageListViewController.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYTableViewController.h"
#import "MYChatPersonViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MYChatMessageListViewController : MYTableViewController

@property (nonatomic, strong) MYChatPersonViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
