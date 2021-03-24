//
//  ViewController.m
//  OCClass
//
//  Created by mac on 2021/2/22.
//

#import "ViewController.h"
#import "UICollectionViewVC.h"
#import "UIScrollViewVC.h"
#import "NormalTableViewCell.h"
#import "WKWebViewVCViewController.h"
#import "UIViewAnimationView.h"
#import "ListLoader.h"
#import "ListItemModel.h"

@interface TestView : UIView

@end

@implementation TestView

- (instancetype)init {
	self = [super init];
	if (self) {

	}
	return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
}
- (void)didMoveToSuperview {
	[super didMoveToSuperview];
}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow {
	[super willMoveToWindow:newWindow];
}
- (void)didMoveToWindow {
	[super didMoveToWindow];
}

@end

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, NormalTableCellDelegate>

@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong, readwrite) NSArray *dataArray;
@property(nonatomic, strong, readwrite) ListLoader *listLoader;

@end

@implementation ViewController

- (instancetype)init {
	self = [super init];
	/**
	   防止父类初始化失败，导致整体逻辑错误，所以要判断是否已经正确的alloc分配内存以及是否初始化成功。
	   对于alloc方法来说系统是有可能失败的，同时init函数如果在需要传参数的时候，传入错误的参数也可能返回nil。
	 */
	if (self) {
		NSLog(@"init");
	}
	return self;
}

- (void)loadView {
	NSLog(@"loadView");
	[super loadView];
}

- (void)dealloc {
	NSLog(@"dealloc");
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"viewWillAppear");
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"viewDidAppear");
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	NSLog(@"viewWillDisappear");
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	NSLog(@"viewDidDisappear");
	[super viewDidDisappear:animated];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	NSLog(@"viewDidLoad");
    self.title = @"列表";
//    TestView *view = [[TestView alloc] init];
//    view.backgroundColor = [UIColor grayColor];
//    view.frame = CGRectMake(100, 100, 100, 100);
//    [self.view addSubview:view];

	_tableView = [[UITableView alloc] initWithFrame: self.view.bounds];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
    _listLoader = [[ListLoader alloc] init];
    __weak typeof(self) wself = self;
    [_listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<ListItemModel *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
        NSLog(@"");
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListItemModel *model = [self.dataArray objectAtIndex:indexPath.row];
    UICollectionViewVC *viewController = [[UICollectionViewVC alloc] initWithUrlString:model.url];
    viewController.title = model.title;
//	viewController.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
	[self.navigationController pushViewController:viewController animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:model.aid];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
	if (!cell) {
		cell = [[NormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tableViewCell"];
		cell.delegate = self;
	}
	[cell layoutTableViewCellWithItem:[_dataArray objectAtIndex:indexPath.row]];
//    cell.textLabel.text = [NSString stringWithFormat: @"主标题 - %@", @(indexPath.row)];
//    cell.detailTextLabel.text = @"副标题";
	return cell;
}

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
	UIViewAnimationView *animationView = [[UIViewAnimationView alloc] initWithFrame:self.view.bounds];
	CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];

	__weak typeof(self) wself = self;
	[animationView showDeleteViewFromPoint:rect.origin clickBlock:^{
	         __strong typeof(self) strongSelf = wself;
//	         [strongSelf.dataArray removeLastObject];
//	         [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
	 }];
}
@end
