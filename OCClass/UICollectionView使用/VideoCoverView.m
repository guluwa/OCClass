//
//  VideoCoverView.m
//  OCClass
//
//  Created by mac on 2021/3/23.
//

#import "VideoCoverView.h"
#import "VideoPlayer.h"
#import "VideoToolBar.h"

@interface VideoCoverView()

@property(nonatomic, strong, readwrite) UIImageView *coverView;
@property(nonatomic, strong, readwrite) UIImageView *playButton;
@property(nonatomic, strong, readwrite) NSString *videoUrl;
@property(nonatomic, strong, readwrite) VideoToolBar *toolBar;

@end

@implementation VideoCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - VideoToolBarHeight)];
            _coverView;
        })];
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - VideoToolBarHeight - 50) / 2, 50, 50)];
            _playButton;
        })];
        [self addSubview:({
            _toolBar = [[VideoToolBar alloc]initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, VideoToolBarHeight)];
            _toolBar;
        })];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

#pragma mark - public method 加载视频

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *) videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _playButton.image = [UIImage imageNamed:@"icon.bundle/播放.png"];
    _videoUrl = videoUrl;
    [_toolBar layoutWithModel:nil];
}

#pragma mark - private method 点击播放视频

- (void)_tapToPlay {
    [[VideoPlayer Player] playVideoWithUrl:_videoUrl attachView:_coverView];
}
@end
