//
//  MYUser.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/2.
//

#import "MYUser.h"

@implementation MYUser

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.userId = [coder decodeInt64ForKey:@"userId"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.email = [coder decodeObjectForKey:@"email"];
        self.os = [coder decodeObjectForKey:@"os"];
        self.token = [coder decodeObjectForKey:@"token"];
        self.expireTime = [coder decodeInt64ForKey:@"expireTime"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.os forKey:@"os"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeInteger:self.expireTime forKey:@"expireTime"];
}

- (BOOL)isVip {
    NSTimeInterval nowTime =
    [[[NSDate alloc] initWithTimeIntervalSince1970:0] timeIntervalSince1970];
    return self.vipStatus && self.expireTime - nowTime > 0;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
