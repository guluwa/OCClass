//
//  ListItemModel.h
//  OCClass
//
//  Created by mac on 2021/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 列表结构化数据
@interface ListItemModel : NSObject <NSSecureCoding>

@property(nonatomic, strong, readwrite) NSString *title;
@property(nonatomic, strong, readwrite) NSString *describe;
@property(nonatomic, strong, readwrite) NSString *biaoqian;
@property(nonatomic, strong, readwrite) NSString *url;
@property(nonatomic, strong, readwrite) NSString *pic;
@property(nonatomic, strong, readwrite) NSString *ctime;

- (void)configWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
