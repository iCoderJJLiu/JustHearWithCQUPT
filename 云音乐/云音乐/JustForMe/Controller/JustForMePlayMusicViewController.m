//
//  JustForMePlayMusicViewController.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/7.
//  Copyright © 2021 C205. All rights reserved.
//

#define HEIGHT UIScreen.mainScreen.bounds.size.height
#define WIDTH UIScreen.mainScreen.bounds.size.width

#import "JustForMePlayMusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "JustForMePlayedView.h"
@interface JustForMePlayMusicViewController ()<AVAudioPlayerDelegate>
@property(nonatomic, retain)AVAudioPlayer *player;
@property(nonatomic, retain)NSTimer *timer;
@property(nonatomic, copy)NSArray *backgroundImageArray;
@property(nonatomic, strong)JustForMePlayedView *playedView;
@property(nonatomic, strong)NSArray *musicDataListArray;
@end

@implementation JustForMePlayMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundImageArray = @[@"林俊杰", @"星爷", @"许嵩", @"伍佰1", @"周杰伦", @"周星驰", @"EdisonChen", @"jaychou", @"伍佰2", @"JJLin", @"Michael", @"MJ", @"ultraman", @"Vae"];
    _musicDataListArray = @[@"陈冠希-记得我吗", @"陈冠希-战争", @"陈冠希,MC仁,厨房仔-谣言", @"冬木透 (まいた しょうこう)-ウルトラセブンの歌 (赛文奥特曼之歌)", @"福沢良一,少年少女合唱団みずうみ-ウルトラマンタロウ (泰罗奥特曼)", @"华晨宇 - 好想爱这个世界啊", @"林俊杰-幸存者", @"林俊杰-Like You Do", @"林俊杰-Wonderland", @"卢冠廷,莫文蔚-一生所爱", @"伍佰 & China Blue-晚风", @"许嵩,朱婷婷 - 如果当时2020", @"周杰伦 - 红模仿", @"周杰伦-Mojito", @"Michael Jackson-Remember The Time"];
    
    self.navigationController.navigationBar.tintColor  = [UIColor whiteColor];
    self.title = _musicDataListArray[_integer];
    _playedView = [[JustForMePlayedView alloc] init];
    
    NSString *str = [[NSString alloc] initWithString:self.backgroundImageArray[arc4random() % 14]];
    UIImage *backgroundImage = [UIImage imageNamed:str];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeBackImage) userInfo:nil repeats:YES];
    [self setButtons];
    [self creatAVPlayer:_integer];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

- (void)creatAVPlayer:(NSUInteger) integer{
    self.title = _musicDataListArray[integer];
    NSString *nameCopy = [[NSBundle mainBundle] pathForResource:_musicDataListArray[integer] ofType:@"mp3"];
    NSURL *urlMusic = [NSURL fileURLWithPath:nameCopy];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlMusic error:nil];
    [_player prepareToPlay];
    _player.volume = 0.5;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    _player.delegate = self;
    [_player play];
}

- (void)viewWillAppear:(BOOL)animated{
    UIImage *image = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"cm2_topbar_bg"]forBarMetrics:0];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound){
        [_player stop];
        [_playedView.buttonPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        _playedView.buttonPause.tag = 0;
    }
}

- (void)changeBackImage{
    NSUInteger value = arc4random() % 14;
    NSString *str = [[NSString alloc] initWithFormat:@"%@", self.backgroundImageArray[value]];
    CATransition *animation = [CATransition animation];
    animation.duration = 2;
    animation.type = @"fade";
    animation.subtype = kCATransitionFromLeft;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.view.layer addAnimation:animation forKey:nil];
    UIImage *backgroundImage = [UIImage imageNamed:str];
    self.view.layer.contents = (id)backgroundImage.CGImage;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [_timer invalidate];
}

- (void)updateTimer{
    _playedView.musicProgress.progress = _player.currentTime / _player.duration;
}

- (void)setButtons {
    // 暂停 播放按钮
    _playedView.buttonPause = [UIButton buttonWithType:UIButtonTypeCustom];
    _playedView.buttonPause.tag = 1;///<< 暂停为1
    [_playedView.buttonPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [_playedView.buttonPause addTarget:self action:@selector(pauseMusic) forControlEvents:UIControlEventTouchUpInside];
    _playedView.buttonPause.frame = CGRectMake(WIDTH * 0.5 + 20, HEIGHT * 0.77, 50, 50);
    [self.view addSubview:_playedView.buttonPause];
        
    // 停止按钮
    _playedView.buttonStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playedView.buttonStop setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [_playedView.buttonStop addTarget:self action:@selector(stopMusic) forControlEvents:UIControlEventTouchUpInside];
    _playedView.buttonStop.frame = CGRectMake(WIDTH * 0.5 - 70, HEIGHT * 0.77, 50, 50);
    [self.view addSubview:_playedView.buttonStop];
    
    // 上一首歌曲
    _playedView.buttonStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playedView.buttonStop setImage:[UIImage imageNamed:@"leftBtn"] forState:UIControlStateNormal];
    [_playedView.buttonStop addTarget:self action:@selector(leftMusic) forControlEvents:UIControlEventTouchUpInside];
    _playedView.buttonStop.frame = CGRectMake(WIDTH * 0.5 - 160, HEIGHT * 0.77, 50, 50);
    [self.view addSubview:_playedView.buttonStop];
    
    // 下一首歌曲
    _playedView.buttonStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playedView.buttonStop setImage:[UIImage imageNamed:@"rightBtn"] forState:UIControlStateNormal];
    [_playedView.buttonStop addTarget:self action:@selector(rightMusic) forControlEvents:UIControlEventTouchUpInside];
    _playedView.buttonStop.frame = CGRectMake(WIDTH * 0.5 + 110, HEIGHT * 0.77, 50, 50);
    [self.view addSubview:_playedView.buttonStop];
    
    // 进度条
    _playedView.musicProgress = [[UIProgressView alloc] init];
    _playedView.musicProgress.frame = CGRectMake(30, HEIGHT * 0.9, WIDTH - 60, 10);
    _playedView.musicProgress.progress = 0;
    [self.view addSubview:_playedView.musicProgress];
}

- (void)stopMusic{
    [_player stop];
    _player.currentTime = 0;
    [_playedView.buttonPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    _playedView.buttonPause.tag = 0;
    NSLog(@"stop");
}

- (void)playMusic{
    [_player play];
    NSLog(@"play");
}

- (void)pauseMusic{
    if (_playedView.buttonPause.tag == 1) {
        [_player pause];
        NSLog(@"pause");
        [_playedView.buttonPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        _playedView.buttonPause.tag = 0;
    } else if(_playedView.buttonPause.tag == 0){
        [_player play];
        NSLog(@"play");
        [_playedView.buttonPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        _playedView.buttonPause.tag = 1;
    }
    
}

- (void)leftMusic
{
    [_playedView.buttonPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    if ((unsigned long)_integer == 0)
        _integer = 15;
    unsigned long a = _integer - 1;
    _integer --;
    [self creatAVPlayer:a];
    [self playMusic];
    NSLog(@"left");
}

- (void)rightMusic
{
    [_playedView.buttonPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    if ((unsigned long)_integer == 14)
        _integer = -1;
    unsigned long a = (unsigned long)_integer + 1;
    _integer ++;
    [self creatAVPlayer:a];
    [self playMusic];
    NSLog(@"right");
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
