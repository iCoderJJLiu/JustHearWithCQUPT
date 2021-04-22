//
//  TabBarViewController.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//

#define kMainScreenWidth [[UIScreen mainScreen]bounds].size.width//屏幕宽度
#define kMainScreenHeight [[UIScreen mainScreen]bounds].size.height//屏幕高度


// RGB颜色
#define YQColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import "TabBarViewController.h"

#import "DiscoverMusicViewController.h"///<< 发现音乐
#import "JustForMeViewController.h"///<< 我的音乐
#import "ShareToFriendsViewController.h"///<< 朋友
#import "AccountViewController.h"///<< 账号

#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
@interface TabBarViewController ()

@property(nonatomic, strong)DiscoverMusicViewController *discoverVC;
@property(nonatomic, strong)JustForMeViewController *mineVC;
@property(nonatomic, strong)ShareToFriendsViewController *sharedVC;
@property(nonatomic, strong)AccountViewController *account;



@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)UIImageView *coverImage;



@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initImage{
    _coverImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appCover"]];
    _coverImage.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
    [self.view addSubview:_coverImage];
    [self beginRemove];
    [self setDiscoverViewController];
}

- (void)beginRemove
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(remove) userInfo:nil repeats:YES];
}

- (void)remove
{
    [_timer invalidate];
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.type = @"fade";
    animation.subtype = kCATransitionFromLeft;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.view.layer addAnimation:animation forKey:nil];
    [_coverImage removeFromSuperview];
}

- (void)setDiscoverViewController{
    self.tabBar.translucent = YES;
    
    self.discoverVC = [[DiscoverMusicViewController alloc] init];
    
    self.mineVC = [[JustForMeViewController alloc] init];
    
    self.sharedVC = [[ShareToFriendsViewController alloc] init];
    
    self.account = [[AccountViewController alloc] init];
    
    UIViewController *disNa = [[UINavigationController alloc]
                               initWithRootViewController:self.discoverVC];
    UIViewController *sharedNa = [[UINavigationController alloc]
                                  initWithRootViewController:self.sharedVC];
    UIViewController *accountNa = [[UINavigationController alloc]
                                   initWithRootViewController:self.account];
    UIViewController *mineNa = [[UINavigationController alloc]
                                initWithRootViewController:self.mineVC];
    
    [self setViewControllers:@[disNa, mineNa, sharedNa, accountNa]];
    [disNa.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"cm2_topbar_bg"]forBarMetrics:0];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = YQColor(248, 249, 246, 1.0);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = YQColor(255, 255, 255,1.0);
    NSArray *tabBarItemImages = @[@"cm2_btm_icn_discovery", @"cm2_btm_icn_music", @"cm2_btm_icn_friend",@"cm2_btm_icn_account"];
    
    NSArray *titleArray = @[@"发现音乐",@"我的音乐",@"朋友",@"账号"];
    
    
    RDVTabBar *tabBar = [self tabBar];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cm2_btm_tab_left_prs"]];
    [tabBar setFrame:CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), CGRectGetWidth(tabBar.frame), 49)];
    image.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49);
    
    [tabBar.backgroundView addSubview:image];
    
    for (int i = 0; i < 4; i++) {
        RDVTabBarItem *item = [[self tabBar].items objectAtIndex:i];
        if (i < 2) {
            [item setBackgroundSelectedImage:[UIImage imageNamed:@"cm2_blk_left_check"] withUnselectedImage:nil];
        }else
        {
            [item setBackgroundSelectedImage:[UIImage imageNamed:@"cm2_blk_left_check"] withUnselectedImage:nil];
        }
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_prs", [tabBarItemImages objectAtIndex:i]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tabBarItemImages objectAtIndex:i]]];
        item.title = [titleArray objectAtIndex:i];
        item.selectedTitleAttributes = selectTextAttrs;
        item.unselectedTitleAttributes = textAttrs;
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
