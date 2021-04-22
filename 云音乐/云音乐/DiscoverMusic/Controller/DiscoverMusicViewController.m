//
//  DiscoverMusicViewController.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//
#define kMainScreenWidth [[UIScreen mainScreen]bounds].size.width//屏幕宽度
#define kMainScreenHeight [[UIScreen mainScreen]bounds].size.height//屏幕高度

#ifdef DEBUG //开发阶段
#define Log(format,...) printf("%s",[[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])

#else //发布阶段
#define Log(...)
#endif

// 下载歌曲1
#define downloadMusic01 @"http://trackercdnbj.kugou.com/i/v2/?album_audio_id=99121191&behavior=play&cmd=25&album_id=6960309&hash=b5a2d566c9de70422f5e5e7203054219&userid=0&pid=2&version=9108&area_code=1&appid=1005&key=407732fc325852538ca836581fe4e370&pidversion=3001&with_res_tag=1"

// 下载歌曲2
#define downloadMusic02 @"http://trackercdnbj.kugou.com/i/v2/?album_audio_id=53214003&behavior=play&module=&mtype=0&cmd=26&token=&album_id=1952211&userid=0&hash=34c7777fffdd4fdf04e02af1f6857ca4&pid=2&vipType=65530&version=9108&area_code=1&appid=1005&mid=286974383886022203545511837994020015101&key=0c68167f46e46ed953bd489f6fdc9120&pidversion=3001&with_res_tag=1"

// 热门歌单
#define hotMusicList @"http://mobilecdnbj.kugou.com/api/v5/special/recommend?recommend_expire=0&sign=52186982747e1404d426fa3f2a1e8ee4&plat=0&uid=0&version=9108&page=1&area_code=1&appid=1005&mid=286974383886022203545511837994020015101&_t=1545746286"

// 歌单
#define musicList @"http://mobilecdnbj.kugou.com/api/v3/rank/list?version=9108&plat=0&showtype=2&parentid=0&apiver=6&area_code=1&withsong=1&with_res_tag=1"

// 专区
#define specialArea @"http://mobilecdnbj.kugou.com/api/v3/tag/list?pid=0&apiver=2&plat=0"

// 华语新歌
#define newChineseMusic @"http://mobilecdnbj.kugou.com/api/v3/rank/newsong?version=9108&plat=0&with_cover=1&pagesize=100&type=1&area_code=1&page=1&with_res_tag=1"

// 欧美新歌
#define newWestMusic @"http://mobilecdnbj.kugou.com/api/v3/rank/newsong?version=9108&plat=0&with_cover=1&pagesize=100&type=2&area_code=1&page=1&with_res_tag=1"

// 日韩新歌
#define newJaprea @"http://mobilecdnbj.kugou.com/api/v3/rank/newsong?version=9108&plat=0&with_cover=1&pagesize=100&type=3&area_code=1&page=1&with_res_tag=1"

// 搜索歌曲
#define searchMusicLink @"http://msearchcdn.kugou.com/api/v3/search/song?showtype=14&highlight=em&pagesize=30&tag_aggr=1&tagtype=全部 &plat=0&sver=5&keyword=%@&correct=1&api_ver=1&version=9108&page=1&area_code=1&tag=1&with_res_tag=1"

#import "DiscoverMusicViewController.h"
#import "SearchCategoryView.h"
#import "AFNetworking.h"

#import "NewMusicModel.h"
#import "SpecialAreaModel.h"
#import "MusicListModel.h"
#import "HotListModel.h"
#import "SearchResultModel.h"

#import "DiscoverTableViewController.h"
@interface DiscoverMusicViewController ()<UISearchResultsUpdating,UISearchBarDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property(nonatomic, strong)UISearchController *searchController;
@property(nonatomic, strong)SearchCategoryView *categoryView;
@property(nonatomic, copy)NSArray *linksArray;
@property(nonatomic, strong)NSURLConnection *connection;
@property(nonatomic, strong)NSMutableData *date;
@property(nonatomic, strong)NSMutableString *mutableString;
@property(nonatomic, copy)NSDictionary *currentDictionary;
@property(nonatomic, strong)NSMutableArray *arrayData;
@property(nonatomic, strong)DiscoverTableViewController *tableViewController;



@end

@implementation DiscoverMusicViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"EdisonChen"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    [self loadNaviBarItem];
    [self loadSearch];
    [self setCategoryView];
    _arrayData = [[NSMutableArray alloc] init];
    self.linksArray = [[NSArray alloc] initWithObjects:newChineseMusic, specialArea, newWestMusic, newJaprea, musicList, hotMusicList, nil];
}



#pragma mark -移除定时器
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [_timer invalidate];
//    _timer = nil;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 创建category音乐按钮
- (void)setCategoryView {
    _categoryView = [[SearchCategoryView alloc] init];
    
    
    _categoryView.scrollListView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _categoryView.backgroundColor = [UIColor clearColor];
    _categoryView.scrollListView.pagingEnabled = YES;
    _categoryView.scrollListView.scrollEnabled = YES;
    _categoryView.scrollListView.contentSize = CGSizeMake(kMainScreenWidth, kMainScreenHeight - 20);
    _categoryView.scrollListView.bounces = YES;
    [self.view addSubview:_categoryView.scrollListView];
    
    _categoryView.westButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_categoryView.westButton setImage:[UIImage imageNamed:@"欧美新歌"] forState:UIControlStateNormal];
    _categoryView.westButton.frame = CGRectMake(20, 100, (kMainScreenWidth - 60) / 2.0, 70);
    
    
    _categoryView.chineseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_categoryView.chineseButton setImage:[UIImage imageNamed:@"华语新歌"] forState:UIControlStateNormal];
    _categoryView.chineseButton.frame = CGRectMake(kMainScreenWidth / 2.0 + 10, 100, (kMainScreenWidth - 60) / 2.0, 70);
    
    _categoryView.japreanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_categoryView.japreanButton setImage:[UIImage imageNamed:@"日韩新歌"] forState:UIControlStateNormal];
    _categoryView.japreanButton.frame = CGRectMake(20, 200, (kMainScreenWidth - 60) / 2.0, 70);
    
    _categoryView.specialButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_categoryView.specialButton setImage:[UIImage imageNamed:@"专区"] forState:UIControlStateNormal];
    _categoryView.specialButton.frame = CGRectMake(kMainScreenWidth / 2.0 + 10, 200, (kMainScreenWidth - 60) / 2.0, 70);
    
    _categoryView.musicListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_categoryView.musicListButton setImage:[UIImage imageNamed:@"歌单"] forState:UIControlStateNormal];
    _categoryView.musicListButton.frame = CGRectMake(20, 300, (kMainScreenWidth - 60) / 2.0, 70);
    
    _categoryView.hotList = [UIButton buttonWithType:UIButtonTypeCustom];
    [_categoryView.hotList setImage:[UIImage imageNamed:@"热门歌单"] forState:UIControlStateNormal];
    _categoryView.hotList.frame = CGRectMake(kMainScreenWidth / 2.0 + 10, 300, (kMainScreenWidth - 60) / 2.0, 70);
    
    _categoryView.chineseButton.tag = 0;
    _categoryView.specialButton.tag = 1;
    _categoryView.westButton.tag = 2;
    _categoryView.japreanButton.tag = 3;
    _categoryView.musicListButton.tag = 4;
    _categoryView.hotList.tag = 5;
    
    _categoryView.hotList.layer.cornerRadius = 7;
    _categoryView.hotList.layer.masksToBounds = true;
    
    _categoryView.chineseButton.layer.cornerRadius = 7;
    _categoryView.chineseButton.layer.masksToBounds = true;
    
    _categoryView.specialButton.layer.cornerRadius = 7;
    _categoryView.specialButton.layer.masksToBounds = true;
    
    _categoryView.westButton.layer.cornerRadius = 7;
    _categoryView.westButton.layer.masksToBounds = true;
    
    _categoryView.japreanButton.layer.cornerRadius = 7;
    _categoryView.japreanButton.layer.masksToBounds = true;
    
    _categoryView.musicListButton.layer.cornerRadius = 7;
    _categoryView.musicListButton.layer.masksToBounds = true;
    
    [_categoryView.scrollListView addSubview:_categoryView.westButton];
    [_categoryView.scrollListView addSubview:_categoryView.chineseButton];
    [_categoryView.scrollListView addSubview:_categoryView.specialButton];
    [_categoryView.scrollListView addSubview:_categoryView.musicListButton];
    [_categoryView.scrollListView addSubview:_categoryView.hotList];
    [_categoryView.scrollListView addSubview:_categoryView.japreanButton];
    
    

    
    
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];

    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:{ // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备未连接网络" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
                [alertController addAction:cancel];
                [alertController addAction:defult];
                [self presentViewController:alertController animated:YES completion:nil];
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                [_categoryView.chineseButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_categoryView.westButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_categoryView.specialButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_categoryView.musicListButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_categoryView.hotList addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_categoryView.japreanButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                [_categoryView.chineseButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_categoryView.westButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_categoryView.specialButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_categoryView.musicListButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_categoryView.hotList addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [_categoryView.japreanButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                break;
        }
    }];

    // 3.开始监控
    [mgr startMonitoring];
    
    
}

#pragma mark - categoryButtonTouchUpEvent
- (void)categoryButtonPressed:(UIButton *)pressButton{
    
    NSURL *url = [NSURL URLWithString:self.linksArray[pressButton.tag]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    self.date = [[NSMutableData alloc] init];
    
    _tableViewController = [[DiscoverTableViewController alloc] init];
    
    if (pressButton.tag == 0) {
        //华语专区
        _tableViewController.title = @"华语新歌";
    } else if (pressButton.tag == 1){
        //专区
        _tableViewController.title = @"专区";
    } else if (pressButton.tag == 2){
        //欧美专区
        _tableViewController.title = @"欧美新歌";
    } else if (pressButton.tag == 3){
        //日韩专区
        _tableViewController.title = @"日韩新歌";
    } else if (pressButton.tag == 4){
        //歌单
        _tableViewController.title = @"歌单";
    } else if (pressButton.tag == 5){
        //热门歌单
        _tableViewController.title = @"热门歌单";
    }
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    _mutableString = [[NSMutableString alloc] initWithData:self.date encoding:NSUTF8StringEncoding];
    
    // 专区 热门歌单
    // 需要修改：华语新歌 日韩新歌 欧美新歌 歌单
    if ([_mutableString hasPrefix:@"<!--KG_TAG_RES_START-->"]) {
        [_mutableString deleteCharactersInRange:NSMakeRange(0, 23)];
        [_mutableString deleteCharactersInRange:NSMakeRange(_mutableString.length - 21, 21)];
    }
    _currentDictionary = [SearchCategoryView dictionaryWithJsonString:_mutableString];
    
    if ([_currentDictionary isKindOfClass:[NSDictionary class]]) {
        Log(@"%@",_currentDictionary);
        
        ///<< 解析数据
        NSDictionary *dictionarySubjects = [_currentDictionary objectForKey:@"data"];
        [_arrayData removeAllObjects];
        
        // 搜索结果
        if ([dictionarySubjects objectForKey:@"aggregation"]) {
            NSArray *listArray = [dictionarySubjects objectForKey:@"info"];
            for (NSDictionary *dicInfoList in listArray) {
                SearchResultModel *resultModel = [[SearchResultModel alloc] init];
                NSString *fakeFileName = [dicInfoList objectForKey:@"filename"];
                fakeFileName = [fakeFileName stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
                fakeFileName = [fakeFileName stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
                resultModel.fileName = fakeFileName;
//                resultModel.fileName = [dicInfoList objectForKey:@"filename"];
                resultModel.albumName = [dicInfoList objectForKey:@"album_name"];
                [self.arrayData addObject:resultModel];
            }
        } else if ([dictionarySubjects objectForKey:@"list"]) {
            // 热门歌单
            NSArray *listArray = [dictionarySubjects objectForKey:@"list"];
            
            for (NSDictionary *dicMusicList in listArray) {
                
                HotListModel *hotModel = [[HotListModel alloc] init];
                
                NSString *specialName = [dicMusicList objectForKey:@"specialname"];///<< 歌单名字
                NSString *nickName = [dicMusicList objectForKey:@"nickname"];///<< 作者名称
                NSString *introduction = [dicMusicList objectForKey:@"intro"];///<< 歌单简介
                NSString *reason = [dicMusicList objectForKey:@"reason"];///<< 所属类别
                NSMutableString *mutableString = [dicMusicList objectForKey:@"imgurl"];
                NSString *string = [SearchCategoryView cuteStringByAssignedString:mutableString];
                
                // 一级VC
                hotModel.authorName = nickName;
                hotModel.category = reason;
                hotModel.coverImageUrl = string;
                hotModel.listName = specialName;
                hotModel.listIntro = introduction;
                
                NSArray *songArray = [dicMusicList objectForKey:@"songs"];
                NSMutableArray *songNameArray = [[NSMutableArray alloc] init];
                NSMutableArray *remarkArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dicSong in songArray) {
                    NSString *songName = [dicSong objectForKey:@"filename"];///<< 歌曲名字
                    NSString *remark = [dicSong objectForKey:@"remark"];///<< remark
                    [songNameArray addObject:songName];
                    [remarkArray addObject:remark];
                }
                hotModel.songNameArray = songNameArray;
                hotModel.songRemarkArray = remarkArray;
                [self.arrayData addObject:hotModel];
            }
        } else if ([dictionarySubjects objectForKey:@"info"]) {
            NSArray *infoArray = [dictionarySubjects objectForKey:@"info"];
            
            for (NSDictionary *dicInfoList in infoArray) {
                if ([dicInfoList objectForKey:@"children"]) {
                    NSArray *childrenArray = [dicInfoList objectForKey:@"children"];
                    // 专区
                    if (childrenArray != nil && ![childrenArray isKindOfClass:[NSNull class]] && childrenArray.count != 0) {
                        for (NSDictionary *childrenDic in childrenArray) {
                            SpecialAreaModel *specialModel = [[SpecialAreaModel alloc] init];
                            NSString *name = [childrenDic objectForKey:@"name"];///<< 专区名字
                            NSString *jumpUrl = [childrenDic objectForKey:@"jump_url"];///<< 点击跳转
                            NSMutableString *bannerurl = [childrenDic objectForKey:@"bannerurl"];///<< 专区图片
                            NSString *string = [SearchCategoryView cuteStringByAssignedString:bannerurl];
                            
                            
                            if (![jumpUrl isEqualToString:@""] && ![bannerurl isEqualToString:@""]) {
                                specialModel.bannerUrlImage = string;
                                specialModel.jumpUrl = jumpUrl;
                                specialModel.areaName = name;
                                [self.arrayData addObject:specialModel];
                            }
                        }
                    } else { // 歌单
                        if (![[dicInfoList objectForKey:@"jump_url"] isEqualToString:@""]) {
                            MusicListModel *listModel = [[MusicListModel alloc] init];
                            NSString *jumpUrl = [dicInfoList objectForKey:@"jump_url"];///<< 跳转url
                            NSString *rankName = [dicInfoList objectForKey:@"rankname"];///<< 歌单名字
                            NSMutableString *mutableString = [dicInfoList objectForKey:@"imgurl"];///<< 歌单封面
                            NSString *string = [SearchCategoryView cuteStringByAssignedString:mutableString];
                            listModel.listJumpUrl = jumpUrl;
                            listModel.listRankName = rankName;
                            listModel.listBannerUrl = string;
                            [self.arrayData addObject:listModel];
                        }
                    }
                } else {//新歌
                    NSMutableString *musicCoverUrl = [dicInfoList objectForKey:@"cover"];///<< 歌曲封面
                    NSString *string = [SearchCategoryView cuteStringByAssignedString:musicCoverUrl];
                    NSString *musicName = [dicInfoList objectForKey:@"filename"];///<< 歌曲名字
                    NSString *addtime = [dicInfoList objectForKey:@"addtime"];///<< 发布时间
                    NewMusicModel *newModel = [[NewMusicModel alloc] init];
                    newModel.musicAddTime = addtime;
                    newModel.musicFileName = musicName;
                    newModel.musicCover = string;
                    [self.arrayData addObject:newModel];
                }
            }
        }
        _tableViewController.arrayData = self.arrayData;
    }
    [self.navigationController pushViewController:_tableViewController animated:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //将每次回传的数据连接起来
    [self.date appendData:data];
}

#pragma mark - Navigation
- (void)loadNaviBarItem {
    UIButton *voidSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    voidSearchButton.frame = CGRectMake(0, 0, 24, 24);
    [voidSearchButton setBackgroundImage:[UIImage imageNamed:@"cm2_top_icn_mic"] forState:UIControlStateNormal];
    [voidSearchButton setBackgroundImage:[UIImage imageNamed:@"cm2_top_icn_mic_prs"] forState:UIControlStateHighlighted];
    [voidSearchButton addTarget:self action:@selector(cickForPushToVoiceVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:voidSearchButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)loadSearch{
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    _searchController.searchResultsUpdater = self;
    
    _searchController.dimsBackgroundDuringPresentation = NO;
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(0, 0, 10, 44);
    
    _searchController.searchBar.placeholder = @"搜索音乐、歌词、电台";
    
    _searchController.searchBar.delegate  = self;
    
    _searchController.searchBar.backgroundColor = [UIColor clearColor];
    
    _searchController.searchBar.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setTitleView:_searchController.searchBar];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}

- (void)cickForPushToVoiceVC{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"语音功能处于测试阶段" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:cancel];
    [alertController addAction:defult];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - searchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    self.navigationItem.leftBarButtonItem.customView.hidden = NO;
    return YES;
}

// 网络请求
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"框中文字为:%@", searchBar.text);
    _tableViewController = [[DiscoverTableViewController alloc] init];
    _tableViewController.title = [NSString stringWithFormat:@"\"%@\"的搜索结果",searchBar.text];
    NSString *netPath = [NSString stringWithFormat:@"http://msearchcdn.kugou.com/api/v3/search/song?showtype=14&highlight=em&pagesize=30&tag_aggr=1&tagtype=全部&plat=0&sver=5&keyword=%@&correct=1&api_ver=1&version=9108&page=2&area_code=1&tag=1&with_res_tag=1", searchBar.text];
    // 中文转码
    NSString *standardPath = [netPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:standardPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    self.date = [[NSMutableData alloc] init];
}

@end
