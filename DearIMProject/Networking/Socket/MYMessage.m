//
//  MYMessage.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/6.
//

#import "MYMessage.h"

@implementation MYMessage

- (NSString *)description {
    NSMutableString *str = [NSMutableString string];
          
    [str appendFormat:@"id : %ld\n",self.msgId];
    [str appendFormat:@"fromId : %ld\n",self.fromId];
    [str appendFormat:@"fromEntity : %d\n",self.fromEntity];
    [str appendFormat:@"toId : %ld\n",self.toId];
    [str appendFormat:@"messageType : %d\n",self.messageType];
    [str appendFormat:@"timestamp : %ld\n",self.timestamp];
    [str appendFormat:@"content : %@\n",self.content];
    
    return str;
}

@end
