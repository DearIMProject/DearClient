//
//  MYMessage+MYConvert.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/23.
//

#import "MYMessage.h"
#import <MYClientDatabase/MYClientDatabase.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYMessage (MYConvert)

+ (MYDataMessage *)convertFromMessage:(MYMessage *)message;

@end

NS_ASSUME_NONNULL_END
