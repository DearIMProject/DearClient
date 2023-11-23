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
    user.name = dbModel.name;
    user.iconURL = dbModel.iconURL;
    return user;
}

@end
