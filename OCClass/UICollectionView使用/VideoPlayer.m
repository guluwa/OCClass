//
//  VideoPlayer.m
//  OCClass
//
//  Created by mac on 2021/3/25.
//

#import "VideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayer()

@property(nonatomic, strong, readwrite) AVPlayerItem *playerItem;
@property(nonatomic, strong, readwrite) AVPlayer *player;
@property(nonatomic, strong, readwrite) AVPlayerLayer *playerLayer;

@end

@implementation VideoPlayer

+ (VideoPlayer *)Player {
    static VideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[VideoPlayer alloc]init];
    });
    return player;
}

#pragma mark - private method 点击播放视频

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView {
    
    [self stopPlay];
    
    NSURL *url = [NSURL URLWithString:videoUrl];
    
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
    _playerLayer.frame = attachView.frame;
    [attachView.layer addSublayer:_playerLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    NSLog(@"");
}

- (void)stopPlay {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    
    [_playerLayer removeFromSuperlayer];
    _playerItem = nil;
    _player = nil;
}

- (void)_handlePlayEnd {
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
