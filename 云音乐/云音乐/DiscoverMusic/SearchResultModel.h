//
//  SearchResultModel.h
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/6.
//  Copyright © 2021 C205. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultModel : NSObject
@property(nonatomic, copy)NSString *fileName; ///<< 歌曲名字
@property(nonatomic, copy)NSString *albumName; ///<< 专辑名字
@end

NS_ASSUME_NONNULL_END
