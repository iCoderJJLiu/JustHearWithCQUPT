//
//  C205LoginView.h
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C205LoginView : UIView
@property (nonatomic, strong)UIButton *loginButton;
- (instancetype)initWithFrame:(CGRect)frame firstTitle:(NSString *)firTitle secondTitle:(NSString *)secTitle  butTitle :(NSString *)butTitle;
@end
