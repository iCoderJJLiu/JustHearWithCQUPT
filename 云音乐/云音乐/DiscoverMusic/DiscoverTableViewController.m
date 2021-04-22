//
//  DiscoverTableViewController.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/6.
//  Copyright © 2021 C205. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "UIImageView+WebCache.h"
#import "NewMusicModel.h"
#import "SpecialAreaModel.h"
#import "MusicListModel.h"
#import "HotListModel.h"
#import "SearchCategoryView.h"
#import "SearchResultModel.h"
#import "DiscoverSecondViewController.h"
@interface DiscoverTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation DiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    NSArray *arrayImage = @[@"周杰伦", @"JJLin", @"MJ", @"Vae", @"ultraman", @"星爷"];
    NSString *currentImageStr = arrayImage[[SearchCategoryView getRandomNumber:0 to:5]];
    UIImage *backgroundImage = [UIImage imageNamed:currentImageStr];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *strId = @"REUSEID";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:strId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strId];
    }
    if ([_arrayData[0] isKindOfClass:[NewMusicModel class]]) {
        
        NewMusicModel *musicModel = self.arrayData[indexPath.row];
        cell.textLabel.text = musicModel.musicFileName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"歌曲发布时间:%@", musicModel.musicAddTime];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:musicModel.musicCover] placeholderImage:[UIImage imageNamed:@"占位图"]];
        
    } else if ([_arrayData[0] isKindOfClass:[SpecialAreaModel class]]){
        
        SpecialAreaModel *areaModel = self.arrayData[indexPath.row];
        cell.textLabel.text = areaModel.areaName;
        
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:areaModel.bannerUrlImage] placeholderImage:[UIImage imageNamed:@"占位图"]];
        cell.detailTextLabel.text = areaModel.jumpUrl;
        cell.detailTextLabel.hidden = YES;
        
    } else if ([_arrayData[0] isKindOfClass:[MusicListModel class]]){
        MusicListModel *listModel = self.arrayData[indexPath.row];
        cell.textLabel.text = listModel.listRankName;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:listModel.listBannerUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
        cell.detailTextLabel.text = listModel.listJumpUrl;
        cell.detailTextLabel.hidden = YES;
        
    } else if ([_arrayData[0] isKindOfClass:[HotListModel class]]){
        HotListModel *hotModel = self.arrayData[indexPath.row];
        cell.textLabel.text = hotModel.listName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"作者名称:%@", hotModel.authorName];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:hotModel.coverImageUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
        cell.tag = 1;
        
    } else if([_arrayData[0] isKindOfClass:[SearchResultModel class]]){
        SearchResultModel *resultModel = self.arrayData[indexPath.row];
        cell.textLabel.text = resultModel.fileName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"专辑名字:%@", resultModel.albumName];
    }
    // 圆角处理
//    [SearchCategoryView UIBezierPathRoundImage:cell.imageView];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - cell点击事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.tag == 1) {
        HotListModel *hotListModel = self.arrayData[indexPath.row];
        DiscoverSecondViewController *secondVC = [[DiscoverSecondViewController alloc] init];
        secondVC.hotListModel = hotListModel;
        [self.navigationController pushViewController:secondVC animated:YES];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:cell.detailTextLabel.text]];
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
