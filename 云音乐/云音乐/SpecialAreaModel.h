//
//  SpecialAreaModel.h
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/2.
//  Copyright © 2021 C205. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpecialAreaModel : NSObject
@property(nonatomic, copy)NSString *bannerUrlImage;///<< 专区图片
@property(nonatomic, copy)NSString *areaName;///<< 专区名字
@property(nonatomic, copy)NSString *jumpUrl;///<< 点击跳转URL
@end

NS_ASSUME_NONNULL_END
