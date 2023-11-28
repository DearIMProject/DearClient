//
//  MYUser+MYConvert.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/22.
//

#import "MYUser+MYConvert.h"

@implementation MYUser (MYConvert)

+ (instancetype)convertFromDBModel:(MYDBUser *)dbModel {
    MYUser *user = [[MYUser alloc] init];
    user.userId = dbModel.userId;
    user.username = dbModel.name;
    user.icon = dbModel.iconURL;
    return user;
}

@end
