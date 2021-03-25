//
//  VideoPlayer.h
//  OCClass
//
//  Created by mac on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayer : UIView

+ (VideoPlayer *)Player;
- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
