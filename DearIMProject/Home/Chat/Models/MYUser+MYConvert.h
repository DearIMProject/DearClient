//
//  MYUser+MYConvert.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/22.
//

#import "MYUser.h"
#import <MYClientDatabase/MYClientDatabase.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYUser (MYConvert)

+ (instancetype)convertFromDBModel:(MYDBUser *)dbModel;

@end

NS_ASSUME_NONNULL_END
