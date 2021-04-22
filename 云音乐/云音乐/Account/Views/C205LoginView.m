//
//  C205LoginView.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//
#define kMainScreenWidth [[UIScreen mainScreen]bounds].size.width//屏幕宽度

#define kMainScreenHeight [[UIScreen mainScreen]bounds].size.height//屏幕高度

#import "C205LoginView.h"
#import "UIImage+C205imageFromColor.h"

@implementation C205LoginView

/**
 *  固定初始化
 *
 */
- (instancetype)initWithFrame:(CGRect)frame firstTitle:(NSString *)firTitle secondTitle:(NSString *)secTitle  butTitle :(NSString *)butTitle
{
    CGFloat maggin = 8;
    self = [super initWithFrame:frame];
    if (self) {
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, maggin, kMainScreenWidth, kMainScreenWidth/10)];
        label1.text = firTitle;
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont fontWithName:@"ArialUnicodeMS" size:15];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, label1.frame.size.height+label1.frame.origin.x, kMainScreenWidth, frame.size.width/14)];
        label2.text = secTitle;
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font = [UIFont fontWithName:@"ArialUnicodeMS" size:15];

        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:butTitle forState:UIControlStateNormal];
        _loginButton.frame = CGRectMake(maggin*10, label2.frame.size.height + label2.frame.origin.y +maggin, kMainScreenWidth/1.5 - maggin*2, frame.size.width/12);
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 10;
        _loginButton.layer.borderWidth =0.5;
        _loginButton.layer.borderColor = [UIColor blackColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        UIImage * image = [UIImage  buttonImageFromColor:[UIColor colorWithWhite:0.880 alpha:0.900] withFrame:_loginButton.frame];
        _loginButton.center = CGPointMake(self.center.x, label2.frame.size.height + label2.frame.origin.y +maggin +frame.size.width/24);
        [_loginButton setBackgroundImage:image forState:UIControlStateHighlighted];
        [self addSubview:label1];
        [self addSubview:label2];
        [self addSubview:_loginButton];
   }
    return self;
}

@end
