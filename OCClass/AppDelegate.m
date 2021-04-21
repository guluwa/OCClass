//
//  AppDelegate.m
//  OCClass
//
//  Created by mac on 2021/2/22.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return YES;
}


#pragma mark - UISceneSession lifecycle


/*
1.如果没有在APP的Info.plist文件中包含scene的配置数据，或者要动态更改场景配置数据，需要实现此方法。 UIKit会在创建新scene前调用此方法。
2.方法会返回一个UISceneConfiguration对象，其包含其中包含场景详细信息，包括要创建的场景类型，用于管理场景的委托对象以及包含要显示的初始视图控制器的情节提要。如果未实现此方法，则必须在应用程序的Info.plist文件中提供场景配置数据。

总结下：默认在info.plist中进行了配置， 不用实现该方法也没有关系。如果没有配置就需要实现这个方法并返回一个UISceneConfiguration对象。
配置参数中Application Session Role 是个数组，每一项有三个参数:
Configuration Name:   当前配置的名字;
Delegate Class Name:  与哪个i代理对象关联;
StoryBoard name: 这个Scene使用的哪个storyboard。
注意：代理方法中调用的是配置名为Default Configuration的Scene，则系统就会自动去调用SceneDelegate这个类。这样SceneDelegate和AppDelegate产生了关联。
*/
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

// 在分屏中关闭其中一个或多个scene时候回调用
- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
