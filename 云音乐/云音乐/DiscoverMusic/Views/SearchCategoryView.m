//
//  SearchCategoryView.m
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//

#import "SearchCategoryView.h"

@implementation SearchCategoryView

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)cuteStringByAssignedString:(NSMutableString *)mutableString{
    NSString *string;
    if ([mutableString containsString:@"/{size}"]) {
        string = [mutableString stringByReplacingOccurrencesOfString:@"/{size}" withString:@""];
    } else {
        string = mutableString;
    }
    return string;
}

+ (void)UIBezierPathRoundImage:(UIImageView *)imageView{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:imageView.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
}

+(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

@end
