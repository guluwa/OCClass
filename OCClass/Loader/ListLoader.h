//
//  ListLoader.h
//  OCClass
//
//  Created by mac on 2021/3/16.
//

#import <Foundation/Foundation.h>

@class ListItemModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ListLoaderFinishBlock)(BOOL success, NSArray<ListItemModel *> *dataArray);

@interface ListLoader : NSObject

- (void)loadListDataWithFinishBlock:(ListLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
