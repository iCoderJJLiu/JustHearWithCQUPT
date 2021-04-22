//
//  MusicListModel.h
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/2.
//  Copyright © 2021 C205. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicListModel : NSObject
@property(nonatomic, copy) NSString *listRankName;///<< 歌单分类
@property(nonatomic, copy) NSString *listBannerUrl;///<< 分类图片
@property(nonatomic, copy) NSString *listJumpUrl;///<< 跳转url
@end

NS_ASSUME_NONNULL_END
