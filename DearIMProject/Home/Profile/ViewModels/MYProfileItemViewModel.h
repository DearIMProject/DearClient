//
//  MYProfileItemViewModel.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectBlock)(void);

@interface MYProfileItemViewModel : MYViewModel

@property (nonatomic, strong) NSString *title;/**<  标题 */

@property(nonatomic, copy) SelectBlock selectBlock;

@end

NS_ASSUME_NONNULL_END
