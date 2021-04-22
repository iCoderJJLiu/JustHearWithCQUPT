//
//  HotListModel.h
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/2.
//  Copyright © 2021 C205. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotListModel : NSObject

/// 一级VC
@property(nonatomic, copy) NSString *coverImageUrl;///<< 歌单封面
@property(nonatomic, copy) NSString *category;///<< 所属类别
@property(nonatomic, copy) NSString *authorName;///<< 作者名称

/// 二级VC
@property(nonatomic, copy) NSString *listName;///<< 歌单名字
@property(nonatomic, copy) NSString *listIntro;///<< 歌单简介
@property(nonatomic, copy) NSArray *songNameArray;///<< 歌曲名字
@property(nonatomic, copy) NSArray *songRemarkArray;///<< remark
@end

NS_ASSUME_NONNULL_END
