//
//  UIViewAnimationView.h
//  OCClass
//
//  Created by mac on 2021/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewAnimationView : UIView

- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t) clickBlock;
- (void)dismissDeleteView;
- (void)clickButton;

@end

NS_ASSUME_NONNULL_END
