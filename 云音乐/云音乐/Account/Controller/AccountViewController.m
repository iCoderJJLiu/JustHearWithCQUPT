//
//  AccountViewController.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//
#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width

#import "AccountViewController.h"
#import "C205LoginView.h"
#import "AccountLoginViewController.h"
#import "SearchCategoryView.h"

@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UIImageView *headImage;
@property(nonatomic, strong)NSDictionary *dictionary;
@end

@implementation AccountViewController
#pragma mark - 生命周期
- (void)loadView {
    UITableView *tabelView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _table = tabelView;
    self.view = tabelView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidAppear:YES];
    UIImage *backgroundImage = [UIImage imageNamed:@"Vae"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    self.title = @"账号";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _table.dataSource = self;
    _table.delegate = self;
    _table.backgroundColor = [UIColor clearColor];
    
    C205LoginView *view = [[C205LoginView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth/3.5) firstTitle:@"登陆音悦重邮" secondTitle:@"手机电脑多端同步，320k高品质无线下载" butTitle:@"立即登录"];
    [view.loginButton addTarget:self action:@selector(gotoLoginVC) forControlEvents:UIControlEventTouchUpInside];
    _table.tableHeaderView = view;
    _table.tableHeaderView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    _table.tableHeaderView.userInteractionEnabled = YES;
    _table.userInteractionEnabled = YES;
    
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth / 2.0 - 50, 20, 100, 100)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    _dictionary = [userDef objectForKey:@"usersInformationDictionary"];
    if (_dictionary) {
        _table.tableHeaderView.hidden = YES;
        NSString *headUrl = [_dictionary objectForKey:@"headImage"];
        _headImage.image = [UIImage imageNamed:headUrl];
        _headImage.hidden = NO;
        [SearchCategoryView UIBezierPathRoundImage:_headImage];
        [self.view addSubview:_headImage];
        _headImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEvent:)];
        [_headImage addGestureRecognizer:tap];
    }
}

- (void)clickEvent:(UITapGestureRecognizer *)tap{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出登陆" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        _table.tableHeaderView.hidden = NO;
        _headImage.hidden = YES;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:defult];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)gotoLoginVC{
    AccountLoginViewController *loginVC = [[AccountLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 4;
    }else
    {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * arrTitle = @[@"音悦重邮畅听流量包",@"换肤",@"定时关闭",@"设置"];
    NSArray * arrPic = @[@"cm2_set_icn_combo",@"cm2_set_icn_skin",@"cm2_set_icn_time",@"cm2_set_icn_set"];
    static NSString *str = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"积分商城";
        cell.imageView.image = [UIImage imageNamed:@"cm2_set_icn_store"];
        NSLog(@"gbqvwoilekngboqwihlejkng");
    }if (indexPath.section == 1) {
        cell.textLabel.text = arrTitle[indexPath.row];
        NSString *str = arrPic[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:str];
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"官方默认";
        }else if (indexPath.row == 2){
            cell.detailTextLabel.text = @"未开启";
        }
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text =@"分享音悦重邮";
            cell.imageView.image = [UIImage imageNamed:@"cm2_set_icn_share"];
        }else
        {
            cell.textLabel.text = @"关于";
            cell.imageView.image = [UIImage imageNamed:@"cm2_set_icn_about"];
        }
    }
    cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_table cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"分享音悦重邮"]) {
        [self activityShare];
        NSLog(@"dianjizhengque");
    } else if ([cell.textLabel.text isEqualToString:@"关于"]){
        [self aboutApplication];
    }
}


- (void)activityShare{
    //活动内容
    NSString *content = @"分享音悦重邮JustHear";
    //活动的url
    NSURL *url = [NSURL URLWithString:@"https://github.com/iCoderJJLiu?tab=repositories"];
    //活动的图片
    UIImage *image = [UIImage imageNamed:@"占位图"];
    UIActivityViewController * con = [[UIActivityViewController alloc]initWithActivityItems:@[content,url,image] applicationActivities:nil];
    //活动行为结束后回调的block
    con.completionWithItemsHandler = ^(UIActivityType activityType, BOOL completed, NSArray * returnedItems, NSError * __nullable activityError){
        NSLog(@"%@\n%@",activityType,returnedItems);
    };
    [self presentViewController:con animated:YES completion:nil];
}

- (void)aboutApplication{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"关于" message:@"此app设计及开发工作由iCoderJJLiu独立完成" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:defult];
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
