//
//  JustForMePlayedView.h
//  音悦重邮JustHear
//
//  Created by J J on 2021/4/7.
//  Copyright © 2021 C205. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JustForMePlayedView : UIView
@property (retain,nonatomic)UIButton *buttonPlay;
@property (retain,nonatomic)UIButton *buttonPause;
@property (retain,nonatomic)UIButton *buttonStop;
@property (strong,nonatomic)UIButton *buttonBack;
@property (retain,nonatomic)UIProgressView *musicProgress;
@end

NS_ASSUME_NONNULL_END
