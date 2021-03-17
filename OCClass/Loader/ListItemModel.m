//
//  ListItemModel.m
//  OCClass
//
//  Created by mac on 2021/3/17.
//

#import "ListItemModel.h"

@implementation ListItemModel

#pragma mark - NSSecureCoding

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.describe forKey:@"describe"];
    [coder encodeObject:self.biaoqian forKey:@"biaoqian"];
    [coder encodeObject:self.url forKey:@"url"];
    [coder encodeObject:self.pic forKey:@"pic"];
    [coder encodeObject:self.ctime forKey:@"ctime"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.title = [coder decodeObjectForKey:@"title"];
        self.describe = [coder decodeObjectForKey:@"describe"];
        self.biaoqian = [coder decodeObjectForKey:@"biaoqian"];
        self.url = [coder decodeObjectForKey:@"url"];
        self.pic = [coder decodeObjectForKey:@"pic"];
        self.ctime = [coder decodeObjectForKey:@"ctime"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark - public method

- (void)configWithDictionary:(NSDictionary *)dictionary {
#warning 类型是否匹配
	self.title = [dictionary objectForKey:@"title"];
	self.describe = [dictionary objectForKey:@"describe"];
	self.biaoqian = [dictionary objectForKey:@"biaoqian"];
	self.url = [dictionary objectForKey:@"url"];
	self.pic = [dictionary objectForKey:@"pic"];
	self.ctime = [dictionary objectForKey:@"ctime"];
}

@end
