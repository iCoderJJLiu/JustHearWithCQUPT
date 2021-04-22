//
//  UIImage+C205imageFromColor.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//

#import "UIImage+C205imageFromColor.h"

@implementation UIImage (C205imageFromColor)
+ (UIImage *)buttonImageFromColor:(UIColor *)color withFrame:(CGRect)frame{
    CGRect rect = frame;
    CGSize imageSize = rect.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}
@end
