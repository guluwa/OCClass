//
//  VideoToolBar.m
//  OCClass
//
//  Created by mac on 2021/3/25.
//

#import "VideoToolBar.h"

@interface VideoToolBar()
@property(nonatomic, strong, readwrite) UIImageView *avatorImageView;
@property(nonatomic, strong, readwrite) UILabel *nickLabel;

@property(nonatomic, strong, readwrite) UIButton *commentButton;
@property(nonatomic, strong, readwrite) UIButton *likeButton;
@property(nonatomic, strong, readwrite) UIButton *shareButton;

@end

@implementation VideoToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _avatorImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            _avatorImageView.layer.masksToBounds = YES;
            _avatorImageView.layer.cornerRadius = 15;
            _avatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
            _avatorImageView;
        })];
        [self addSubview:({
            _nickLabel = [[UILabel alloc]init];
            _nickLabel.font = [UIFont systemFontOfSize:15];
            _nickLabel.textColor = [UIColor lightGrayColor];
            _nickLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _nickLabel;
        })];
        [self addSubview:({
            _commentButton = [[UIButton alloc]init];
            _commentButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [_commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _commentButton.translatesAutoresizingMaskIntoConstraints = NO;
            _commentButton;
        })];
        [self addSubview:({
            _likeButton = [[UIButton alloc]init];
            _likeButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [_likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _likeButton.translatesAutoresizingMaskIntoConstraints = NO;
            _likeButton;
        })];
        [self addSubview:({
            _shareButton = [[UIButton alloc]init];
            _shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [_shareButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _shareButton.translatesAutoresizingMaskIntoConstraints = NO;
            _shareButton;
        })];
    }
    return self;
}

- (void)layoutWithModel:(id)model {
    self.backgroundColor = [UIColor whiteColor];
    _avatorImageView.backgroundColor = [UIColor redColor];
    _nickLabel.text = @"咕噜娃";
    
    [_commentButton setTitle:@"评论100" forState:UIControlStateNormal];
    [_likeButton setTitle:@"点赞25" forState:UIControlStateNormal];
    [_shareButton setTitle:@"分享5" forState:UIControlStateNormal];
    
    [NSLayoutConstraint activateConstraints:@[
        [NSLayoutConstraint constraintWithItem:_avatorImageView
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:_avatorImageView
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1
                                      constant:15],
        [NSLayoutConstraint constraintWithItem:_avatorImageView
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1
                                      constant:30],
        [NSLayoutConstraint constraintWithItem:_avatorImageView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1
                                      constant:30],
        [NSLayoutConstraint constraintWithItem:_nickLabel
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:_avatorImageView
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:_nickLabel
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:_avatorImageView
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1
                                      constant:15],
    ]];
    
    NSString *vflString = @"H:|-15-[_avatorImageView]-0-[_nickLabel]->=0-[_commentButton]-15-[_likeButton]-15-[_shareButton]-15-|";
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflString options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_avatorImageView, _nickLabel, _commentButton, _likeButton, _shareButton)]];
    
    
}
@end
