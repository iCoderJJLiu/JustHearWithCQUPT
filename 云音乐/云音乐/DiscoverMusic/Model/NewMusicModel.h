//
//  ChineseMusicModel.h
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/2.
//  Copyright © 2021 C205. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewMusicModel : NSObject
@property(nonatomic, copy) NSString *musicFileName;///<< 歌曲名字
@property(nonatomic, copy) NSString *musicCover;///<< 封面
@property(nonatomic, copy) NSString *musicAddTime;///<< 发布时间
@end

NS_ASSUME_NONNULL_END
