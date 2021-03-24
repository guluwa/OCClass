//
//  ListLoader.m
//  OCClass
//
//  Created by mac on 2021/3/16.
//

#import "ListLoader.h"
#import <AFNetworking.h>
#import "ListItemModel.h"

@interface ListLoader ()

@end

@implementation ListLoader

- (void)loadListDataWithFinishBlock:(ListLoaderFinishBlock)finishBlock {
    
    NSArray<ListItemModel *> *listData = [self _readDataFromLocal];
    finishBlock(YES, listData);
    
    NSString *str = @"http://www.qidianlife.com/Singular/index.php?m=App&c=MaMain&a=index&uid=1579431187&page=1&pagesize=10";
    
    //    [[AFHTTPSessionManager manager] GET:str parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    //
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        NSLog(@"");
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        NSLog(@"");
    //    }];
    
    
    NSURL *strURL = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:strURL];
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
#warning 类型检查
        NSArray *dataArray = [((NSDictionary *)jsonObj) objectForKey:@"data"];
        NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:dataArray.count];
        for(NSDictionary *item in dataArray) {
            ListItemModel *model = [[ListItemModel alloc]init];
            [model configWithDictionary:item];
            [itemArray addObject:model];
        }
        [strongSelf archiveListDataWithArray:itemArray.copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(finishBlock) {
                finishBlock(error == nil, itemArray.copy);
            }
        });
    }];
    [dataTask resume];
}

- (NSArray<ListItemModel *> *)_readDataFromLocal {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"GuluwaData/list"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    
    id unarchiverObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [ListItemModel class], nil] fromData:readListData error:nil];
    
    if ([unarchiverObj isKindOfClass:[NSArray class]] && [unarchiverObj count] > 0) {
        return (NSArray<ListItemModel *> *)unarchiverObj;
    }
    return nil;
}

- (void)archiveListDataWithArray:(NSArray<ListItemModel *> *)array {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = pathArray[0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 创建文件夹
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"GuluwaData"];
    NSError *createError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];
    
    // 创建文件
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
//    NSData *listData = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    id unarchiverObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [ListItemModel class], nil] fromData:readListData error:nil];
    
    // 查询文件
//    BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];
    
    // 删除文件
//    if (fileExist) {
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }
    
    // 追加内容
//    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
//    [fileHandle seekToEndOfFile];
//    [fileHandle writeData:[@"edf" dataUsingEncoding:NSUTF8StringEncoding]];
//    // 实时更新
//    [fileHandle synchronizeFile];
//    [fileHandle closeFile];
    
    NSLog(@"");
}

@end
