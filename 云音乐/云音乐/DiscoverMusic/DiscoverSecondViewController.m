//
//  DiscoverSecondViewController.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/6.
//  Copyright © 2021 C205. All rights reserved.
//

#define kMainScreenWidth [[UIScreen mainScreen]bounds].size.width//屏幕宽度
#define kMainScreenHeight [[UIScreen mainScreen]bounds].size.height//屏幕高度

#import "DiscoverSecondViewController.h"
#import "UIImageView+WebCache.h"
#import "HotListModel.h"
@interface DiscoverSecondViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UIImageView *coverBackImage;
@property(nonatomic, strong)UILabel *label;
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation DiscoverSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    NSString *name = self.hotListModel.listName; ///<< 歌单名字
    NSString *introduce = self.hotListModel.listIntro;///<< 歌单简介
    NSString *coverImageUrl = self.hotListModel.coverImageUrl;///<< 歌单封面
    
    UIImage *image = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    _coverBackImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth)];
    [_coverBackImage sd_setImageWithURL:[NSURL URLWithString:coverImageUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _coverBackImage.alpha = 0.5;
    [self.view addSubview:_coverBackImage];
    
    self.title = name;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, kMainScreenHeight / 14.0, kMainScreenWidth - 40, kMainScreenWidth - 40)];
    _label.backgroundColor = [UIColor clearColor];
    _label.text = [NSString stringWithFormat:@"歌单介绍\n\n\n\n%@", introduce];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor whiteColor];
    _label.numberOfLines = 0;
    [self.view addSubview:_label];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kMainScreenWidth, kMainScreenWidth, kMainScreenHeight - kMainScreenWidth) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    UIImage *image = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"cm2_topbar_bg"]forBarMetrics:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hotListModel.songRemarkArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"歌曲目录" ;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor= [UIColor clearColor];
    header.textLabel.text = @"歌曲目录";
    header.textLabel.textColor = [UIColor whiteColor];
    [header.textLabel setFont:[UIFont systemFontOfSize:20]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *strId = @"REUSEID";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:strId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strId];
    }
    cell.textLabel.text = self.hotListModel.songNameArray[indexPath.row];
    cell.detailTextLabel.text = self.hotListModel.songRemarkArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
