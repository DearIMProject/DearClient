//
//  MYChatPersonViewModel.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/16.
//

#import "MYViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYChatPersonViewModel : MYViewModel

@property (nonatomic, strong) NSString *name;/**<  名称 */
@property (nonatomic, strong) NSString *msgContent;/**<  消息内容 */
@property (nonatomic, strong) NSString *iconURL;/**<  头像 */

@end

NS_ASSUME_NONNULL_END
