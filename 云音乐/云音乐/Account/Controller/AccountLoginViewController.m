//
//  AccountLoginViewController.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/7.
//  Copyright © 2021 C205. All rights reserved.
//

#define HEIGHT UIScreen.mainScreen.bounds.size.height
#define WIDTH UIScreen.mainScreen.bounds.size.width

#import "AccountLoginViewController.h"
#import "AccountViewController.h"
#import "AFNetworking.h"
#import "HttpClient.h"
@interface AccountLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UIButton *loginButton;
@end

@implementation AccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的音乐";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // 设置背景图片
    UIImage *backgroundImage = [UIImage imageNamed:@"林俊杰"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    [self setInputUI];
}

- (void)setInputUI{
    _userName = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH * 0.1, HEIGHT / 2.0, WIDTH * 0.8, 50)];
    _userName.borderStyle = UITextBorderStyleRoundedRect;
    _userName.placeholder = @"请输入学号";
    _userName.delegate = self;
    _userName.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_userName];
    
    _userSecret = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH * 0.1, HEIGHT / 1.7, WIDTH * 0.8, 50)];
    _userSecret.borderStyle = UITextBorderStyleRoundedRect;
    _userSecret.placeholder = @"请输入身份证后六位";
    _userSecret.keyboardType = UIKeyboardTypeNumberPad;
    _userSecret.delegate = self;
    _userSecret.secureTextEntry = YES;
    [self.view addSubview:_userSecret];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setImage:[UIImage imageNamed:@"登陆icon"] forState:UIControlStateNormal];
    _loginButton.frame = CGRectMake(WIDTH * 0.1, HEIGHT / 1.5, WIDTH * 0.8, 80);
    [_loginButton addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    
    _userHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, WIDTH, WIDTH)];
    _userHeadImage.image = [UIImage imageNamed:@"重邮logo"];
    _userHeadImage.alpha = 0.1;
    [self.view addSubview:_userHeadImage];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_userName resignFirstResponder];
    [_userSecret resignFirstResponder];
}


- (void)Login{
    NSDictionary *parameter = @{@"stuNum":_userName.text,@"idNum":_userSecret.text};
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:@"https://cyxbsmobile.redrock.team/wxapi/magipoke/token" method:HttpRequestPost parameters:parameter prepareExecute:^{
        //
    } progress:^(NSProgress *progress) {
        //
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *string = [error localizedDescription];
        NSLog(@"the string is %@", string);
        if ([string containsString:@"400"]) {
            NSLog(@"登陆成功");
            if ([_userName.text isEqualToString:@"2017215188"] && [_userSecret.text isEqualToString:@"126015"]) {
                NSDictionary *dictionary = @{@"userName":_userName.text, @"userSecret":_userSecret.text, @"headImage":@"旺仔头像"};
                [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:@"usersInformationDictionary"];
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"音悦重邮登陆成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defult = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertController addAction:defult];
                [self presentViewController:alertController animated:YES completion:nil];
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号密码错误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:defult];
                [self presentViewController:alertController animated:YES completion:nil];
            }
   
        } else {
            NSLog(@"登陆失败");
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"请检查网络设置" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [controller addAction:action];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField.text.length < 10){
        //返回值为YES的时候,文本框可以进行编辑
        return YES;
    }else{
        //当返回NO的时候,文本框内的内容不会在再改变,甚至不能进行删除
        return NO;
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
