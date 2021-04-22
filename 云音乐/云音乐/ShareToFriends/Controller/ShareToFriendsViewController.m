//
//  ShareToFriendsViewController.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//
#define HEIGHT UIScreen.mainScreen.bounds.size.height
#define WIDTH UIScreen.mainScreen.bounds.size.width

#import "ShareToFriendsViewController.h"
#import "AccountLoginViewController.h"
@interface ShareToFriendsViewController ()
@property(nonatomic, strong)NSDictionary *dictionary;
@property(nonatomic, strong)UIImageView *qrCodeImage;
@end

@implementation ShareToFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"MJ"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    self.title = @"分享给朋友";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    _dictionary = [userDef objectForKey:@"usersInformationDictionary"];
    if (_dictionary) {
        // 生成二维码
        [self createQRCode];
    } else {
        [self showLoginAlertAcion];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [_qrCodeImage removeFromSuperview];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    _dictionary = [userDef objectForKey:@"usersInformationDictionary"];
    if (_dictionary) {
        // 生成二维码
        [self createQRCode];
    } else{
    }
}

- (void)showLoginAlertAcion{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登陆" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AccountLoginViewController *loginVC = [[AccountLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
    [alertController addAction:defult];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)createQRCode{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    // 3.给过滤器添加数据
    // Todo
    NSString *dataString = @"https://github.com/iCoderJJLiu";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    _qrCodeImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 150, WIDTH - 100, WIDTH - 100)];
    [self.view addSubview:_qrCodeImage];
    _qrCodeImage.image = [UIImage imageWithCIImage:outputImage scale:200 orientation:UIImageOrientationUp];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
