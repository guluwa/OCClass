//
//  UIViewAnimationView.m
//  OCClass
//
//  Created by mac on 2021/3/9.
//

#import "UIViewAnimationView.h"

@interface UIViewAnimationView ()

@property(nonatomic, strong, readwrite) UIView *backgroundView;
@property(nonatomic, strong, readwrite) UIButton *deleteButton;

@end

@implementation UIViewAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
            _backgroundView.backgroundColor = [UIColor blackColor];
            _backgroundView.alpha = 0.5;
            [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteView)] ];
            _backgroundView;
        })];
        [self addSubview:({
            _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [_deleteButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
            _deleteButton.backgroundColor = [UIColor blueColor];
            _deleteButton;
        })];
    }
    return self;
}

- (void)showDeleteView {
    [[UIApplication sharedApplication].windows.lastObject addSubview:self];
//    [UIView animateWithDuration:1.f animations:^{
//        self.deleteButton.frame = CGRectMake(self.bounds.size.width / 2 - 100, self.bounds.size.height / 2 - 100, 200, 200);
//    }];
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.deleteButton.frame = CGRectMake(self.bounds.size.width / 2 - 100, self.bounds.size.height / 2 - 100, 200, 200);
    } completion:^(BOOL finished) {
        NSLog(@"animation finish");
    }];
}

- (void)dismissDeleteView {
    [self removeFromSuperview];
}

- (void)clickButton {
    [self removeFromSuperview];
}

@end
