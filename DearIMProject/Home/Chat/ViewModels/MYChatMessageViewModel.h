//
//  MYChatMessageViewModel.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import <MYMVVM/MYMVVM.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYChatMessageViewModel : MYViewModel

@property (nonatomic, strong) NSString *content;/**<  消息内容 */

@end

NS_ASSUME_NONNULL_END
