//
//  VideoCoverView.m
//  OCClass
//
//  Created by mac on 2021/3/23.
//

#import "VideoCoverView.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoCoverView()

@property(nonatomic, strong, readwrite) AVPlayerItem *playerItem;
@property(nonatomic, strong, readwrite) AVPlayer *player;
@property(nonatomic, strong, readwrite) AVPlayerLayer *playerLayer;

@property(nonatomic, strong, readwrite) UIImageView *coverView;
@property(nonatomic, strong, readwrite) UIImageView *playButton;
@property(nonatomic, strong, readwrite) NSString *videoUrl;

@end

@implementation VideoCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            _coverView;
        })];
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - 50) / 2, 50, 50)];
            _playButton;
        })];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

#pragma mark - public method 加载视频

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *) videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _playButton.image = [UIImage imageNamed:@"icon.bundle/播放.png"];
    _videoUrl = videoUrl;
}

#pragma mark - private method 点击播放视频

- (void)_tapToPlay {
    
    NSURL *url = [NSURL URLWithString:_videoUrl];
    
    AVAsset *asset = [AVAsset assetWithURL:url];
    
    _playerItem = [AVPlayerItem playerItemWithAsset:asset];
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    CMTime duration = _playerItem.duration;
    CGFloat videoDuration = CMTimeGetSeconds(duration);
    
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度 %@", @(CMTimeGetSeconds(time)));
    }];
    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = _coverView.frame;
    [_coverView.layer addSublayer:_playerLayer];
        
    NSLog(@"");
}

- (void)_handlePlayEnd {
//    [_playerLayer removeFromSuperlayer];
//    _playerItem = nil;
//    _player = nil;
    [_player seekToTime:CMTimeMake(0, 1)];
    [_player play];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerStatusReadyToPlay) {
            [_player play];
        } else {
            NSLog(@"");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSLog(@"缓冲： %@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}
@end
