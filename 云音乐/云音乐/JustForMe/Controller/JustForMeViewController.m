//
//  JustForMeViewController.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//

#import "JustForMeViewController.h"
#import "JustForMeView.h"
#import "SearchCategoryView.h"
#import "JustForMePlayMusicViewController.h"
@interface JustForMeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)JustForMeView *forMeView;
@property(nonatomic, strong)NSArray *musicDataListArray;
@property(nonatomic, strong)NSArray *coverDataListArray;
@end

@implementation JustForMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景图片
    UIImage *backgroundImage = [UIImage imageNamed:@"JJLin"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    self.title = @"我的音乐";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self setUI];
    
    
    //
    _musicDataListArray = @[@"陈冠希-记得我吗", @"陈冠希-战争", @"陈冠希,MC仁,厨房仔-谣言", @"冬木透 (まいた しょうこう)-ウルトラセブンの歌 (赛文奥特曼之歌)", @"福沢良一,少年少女合唱団みずうみ-ウルトラマンタロウ (泰罗奥特曼)", @"华晨宇 - 好想爱这个世界啊", @"林俊杰-幸存者", @"林俊杰-Like You Do", @"林俊杰-Wonderland", @"卢冠廷,莫文蔚-一生所爱", @"伍佰 & China Blue-晚风", @"许嵩,朱婷婷 - 如果当时2020", @"周杰伦 - 红模仿", @"周杰伦-Mojito", @"Michael Jackson-Remember The Time"];
    
    
    _coverDataListArray = @[@"让我再次介绍我自己", @"Please Steal This Album", @"三角度", @"《赛文奥特曼》特摄主题曲", @"《泰罗奥特曼》特摄主题曲", @"新世界NEW WORLD", @"幸存者 Drifter", @"Like You Do 如你", @"Wonderland", @"《大话西游主题曲-一生所爱》", @"忘情1015精选辑", @"如果当时2020", @"依然范特西", @"Mojito", @"Dangerous"];
}

- (void)setUI{
    _forMeView = [[JustForMeView alloc] init];
    _forMeView.justForMeTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _forMeView.justForMeTableView.dataSource = self;
    _forMeView.justForMeTableView.delegate = self;
    _forMeView.justForMeTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _forMeView.justForMeTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_forMeView.justForMeTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _musicDataListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSString *strId = @"reuseId";
    UITableViewCell *cell = [_forMeView.justForMeTableView dequeueReusableCellWithIdentifier:strId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strId];
    }

    cell.textLabel.text = _musicDataListArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell.imageView setImage:[UIImage imageNamed:_coverDataListArray[indexPath.row]]];
    cell.detailTextLabel.text = _coverDataListArray[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
//    [SearchCategoryView UIBezierPathRoundImage:cell.imageView];
    cell.backgroundColor = [UIColor clearColor];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - cell点击事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_forMeView.justForMeTableView cellForRowAtIndexPath:indexPath];
    NSLog(@"歌曲名字:%@", cell.textLabel.text);
    JustForMePlayMusicViewController *playMusicVC = [[JustForMePlayMusicViewController alloc] init];
    playMusicVC.integer = indexPath.row;
    [self.navigationController pushViewController:playMusicVC animated:YES];
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
