//
//  UICollectionViewVC.m
//  OCClass
//
//  Created by mac on 2021/3/3.
//

#import "UICollectionViewVC.h"
#import "VideoCoverView.h"
#import "VideoToolBar.h"

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
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width / 16 * 9 + VideoToolBarHeight);
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
        [(VideoCoverView *)cell layoutWithVideoCoverUrl:@"icon.bundle/cover.jpg" videoUrl:@"https://f.video.weibocdn.com/VMtfaSxVlx07LlthdA0801041202dMtd0E010.mp4?label=mp4_1080p&template=1920x1080.25.0&trans_finger=0bde055d9aa01b9f6bc04ccac8f0b471&media_id=4618369551499278&tp=8x8A3El:YTkl0eM8&us=0&ori=1&bf=4&ot=h&ps=3lckmu&uid=3ZoTIp&ab=,1493-g0,1192-g0,1191-g0,1258-g0&Expires=1616646005&ssig=B49J4SosvH&KID=unistore,video"];
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
