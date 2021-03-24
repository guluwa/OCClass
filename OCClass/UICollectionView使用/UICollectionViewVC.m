//
//  UICollectionViewVC.m
//  OCClass
//
//  Created by mac on 2021/3/3.
//

#import "UICollectionViewVC.h"
#import "VideoCoverView.h"

@interface UICollectionViewVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong, readwrite) NSString *articleUrl;

@end

@implementation UICollectionViewVC

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        _articleUrl = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width / 16 * 9);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[VideoCoverView class] forCellWithReuseIdentifier:@"VideoCoverView"];
    [self.view addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 200;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCoverView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCoverView" forIndexPath:indexPath];
    if ([cell isKindOfClass:[VideoCoverView class]]) {
        [(VideoCoverView *)cell layoutWithVideoCoverUrl:@"icon.bundle/cover.jpg" videoUrl:@"https://locallimit.us.sinaimg.cn/I1p9UpjClx07Ll024Ooo010412022VpE0E010.mp4?label=mp4_720p&template=1280x720.25.0&trans_finger=1f0da16358befad33323e3a1b7f95fc9&media_id=4618262227648526&tp=8x8A3El:YTkl0eM8&us=0&ori=1&bf=4&ot=h&ps=3lckmu&uid=3ZoTIp&ab=3915-g1,966-g1,3370-g1,1493-g0,1192-g0,1191-g0,3601-g5,1258-g0&Expires=1616580034&ssig=yLIeHgvo8P&KID=unistore,video"];
    }
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if(indexPath.item % 3 == 0) {
//        return CGSizeMake(self.view.frame.size.width, 100);
//    } else {
//        return CGSizeMake((self.view.frame.size.width - 10) / 2, 300);
//    }
//}
@end
