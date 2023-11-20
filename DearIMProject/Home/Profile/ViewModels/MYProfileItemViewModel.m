//
//  MYProfileItemViewModel.m
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYProfileItemViewModel.h"

@implementation MYProfileItemViewModel

- (Class)itemViewClass {
    return NSClassFromString(@"MYProfileItemView");
}

- (CGSize)itemSize {
    return CGSizeMake(0, 48);
}

@end
