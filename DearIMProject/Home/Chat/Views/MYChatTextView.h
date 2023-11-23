//
//  MYChatTextView.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MYChatTextView;

@protocol MYChatTextViewDelegate <NSObject>

- (void)textView:(MYChatTextView *)textView didClickSendButtonWithText:(NSString *)text;

@end

@interface MYChatTextView : UIView

@property(nonatomic, weak) id<MYChatTextViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
