//
//  MYProfileDataSource.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/17.
//

#import "MYDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@class MYProfileDataSource;

@protocol MYProfileDataSourceDelegate <NSObject>

- (void)requestBegin:(MYProfileDataSource *)datasource;

- (void)logoutServiceSuccess:(BOOL)success error:(NSError *)error;

@end

@interface MYProfileDataSource : MYDataSource

@property(nonatomic, weak) id<MYProfileDataSourceDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
