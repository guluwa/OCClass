//
//  ListLoader.m
//  OCClass
//
//  Created by mac on 2021/3/16.
//

#import "ListLoader.h"
#import <AFNetworking.h>

@interface ListLoader ()

@end

@implementation ListLoader

- (void)listDataLoad {
	NSString *str = @"http://www.tianqiapi.com/api?version=v9&appid=23035354&appsecret=8YvlPNrz";
    
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
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        NSLog(@"");
    }];
    [dataTask resume];
}

@end
