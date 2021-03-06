//
//  ScreenUtils.h
//  OCClass
//
//  Created by mac on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define IS_LANDSCAPE (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].windows.firstObject.windowScene.interfaceOrientation))

#define SCREEN_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define UI(x) UIAdapter(x)
#define UIRect(x, y, width, height) UIRectAdapter(x, y, width, height)

#define IS_IPHONE_X_XR_MAX (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XMAX)

#define IS_IPHONE_X (SCREEN_WIDTH == [ScreenUtils sizeFor58Inch].width && SCREEN_HEIGHT == [ScreenUtils sizeFor58Inch].height)
#define IS_IPHONE_XR (SCREEN_WIDTH == [ScreenUtils sizeFor61Inch].width && SCREEN_HEIGHT == [ScreenUtils sizeFor61Inch].height && [UIScreen mainScreen].scale == 2)
#define IS_IPHONE_XMAX (SCREEN_WIDTH == [ScreenUtils sizeFor65Inch].width && SCREEN_HEIGHT == [ScreenUtils sizeFor65Inch].height && [UIScreen mainScreen].scale == 3)

#define STATUS_BAR_HEIGHT (IS_IPHONE_X_XR_MAX ? 44 : 20)

static inline NSInteger UIAdapter(float x) {
    // 1、分机型 特定的比例
    
    // 2、屏幕宽度按比例适配
    CGFloat scale = 428 / SCREEN_WIDTH;
    return (NSInteger)x / scale;
}

static inline CGRect UIRectAdapter(x, y, width, height) {
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
}

@interface ScreenUtils : NSObject

// iPhone xs max
+ (CGSize)sizeFor65Inch;

// iPhone xr
+ (CGSize)sizeFor61Inch;

// iPhone x
+ (CGSize)sizeFor58Inch;

@end

NS_ASSUME_NONNULL_END
