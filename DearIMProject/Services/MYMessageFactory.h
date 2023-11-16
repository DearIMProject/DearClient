//
//  MYMessageFactory.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/16.
//

#import <Foundation/Foundation.h>
#import "MYMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYMessageFactory : NSObject

+ (MYMessage *)messageWithMesssageType:(MYMessageType)msgType;

@end

NS_ASSUME_NONNULL_END
