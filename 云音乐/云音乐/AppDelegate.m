//
//  AppDelegate.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//
// RGB颜色
#define YQColor(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define YQRandomColor YQColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1.0)


#import "AppDelegate.h"
#import "TabBarViewController.h"
@interface AppDelegate ()<RDVTabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    TabBarViewController * TAB =[[TabBarViewController alloc]init];
    self.window.rootViewController = TAB;
    
    /**
     *  设置系统栏白色
     */
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"cm2_topbar_bg"] forBarMetrics:UIBarMetricsDefault];
    [self.window makeKeyAndVisible];
    return YES;
    
}

//- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage withTabBarVC :(UITabBarController *)tabBarVc
//{
//    UINavigationController * navi = [[UINavigationController alloc]init];
//    // 设置子控制器的文字和图片
//    childVc.tabBarItem.title = title;
//    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//总是显示原图像
//    
//    // 设置文字的样式
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = YQColor(248, 249, 246, 1.0);
//    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//    selectTextAttrs[NSForegroundColorAttributeName] = YQColor(255, 255, 255,1.0);
//    
//    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    
//    //创建navi
//    [navi addChildViewController:childVc];
//    [tabBarVc addChildViewController:navi];
//}


/**
 *  tabbarControllerdelegate
 *
 *  @param tabBarController
 *  @param viewController
 */
- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 0) {
        NSLog(@"点击了第一个");
    }
}

//-(void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index
//{
//    NSLog(@"%lu",index);
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
