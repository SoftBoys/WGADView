//
//  WGADView.h
//  ADViewDemo
//
//  Created by dfhb@rdd on 17/3/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGADView;
/** index:0 点击取消按钮 1:点击背景图片 */
typedef void(^WGADViewTapHandle)(WGADView *adView, NSInteger index);

typedef enum : NSUInteger {
    WGSkipButtonTypeNormalTime, // 跳过按钮显示倒计时
    WGSkipButtonTypeCircleTime, // 跳过按钮圆形
    WGSkipButtonTypeNone, // 不显示跳过按钮
} WGSkipButtonType;

@interface WGADView : UIImageView

+ (instancetype)adviewToWindow:(UIWindow *)window buttonType:(WGSkipButtonType)buttonType tapHandle:(WGADViewTapHandle)tapHandle;

@property (nonatomic, weak) UIWindow *window;
@property (nonatomic, assign) WGSkipButtonType buttonType;
/** 点击广告(跳过)的回调 */
@property (nonatomic, copy) WGADViewTapHandle tapHandle;
/** 广告图的显示时间 (默认5s) */
@property (nonatomic, assign) NSTimeInterval duration;
/** 默认显示的Image (默认为launchImage) */
@property (nonatomic, strong) UIImage *placeholderImage;
/** 倒计时跳过按钮的背景颜色 默认黑色0.5 (子类中重写) */
- (UIColor *)skipBackgroundColor;
/** 倒计时线条的颜色 默认红色 (子类中重写) */
- (UIColor *)strokeColor;
/** 加载广告url */
- (void)reloadAdImageWithUrl:(NSString *)imageUrl;

/** 隐藏广告页 (带有动画) */
- (void)dismiss;
/** 隐藏广告页 */
- (void)dismissWithAnimated:(BOOL)animated;

@end
