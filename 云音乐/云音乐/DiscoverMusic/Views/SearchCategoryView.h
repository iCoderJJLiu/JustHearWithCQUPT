//
//  SearchCategoryView.h
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/1.
//  Copyright © 2021 C205. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchCategoryView : UIView

@property(nonatomic, strong)UIButton *westButton;
@property(nonatomic, strong)UIButton *japreanButton;
@property(nonatomic, strong)UIButton *specialButton;
@property(nonatomic, strong)UIButton *chineseButton;
@property(nonatomic, strong)UIButton *musicListButton;
@property(nonatomic, strong)UIButton *hotList;
@property(nonatomic, strong)UIScrollView *scrollListView;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)cuteStringByAssignedString:(NSMutableString *)mutableString;
+ (void)UIBezierPathRoundImage:(UIImageView *)imageView;
+ (int)getRandomNumber:(int)from to:(int)to;
@end

NS_ASSUME_NONNULL_END
