//
//  WGADView.h
//  ADViewDemo
//
//  Created by dfhb@rdd on 17/3/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
/** index:0 取消 1:点击 */
typedef void(^WGADViewTapHandle)(NSInteger index);

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
/** 倒计时跳过按钮的背景颜色 默认黑色0.5 (子类中重写) */
- (UIColor *)skipBackgroundColor;
/** 倒计时线条的颜色 默认红色 (子类中重写) */
- (UIColor *)strokeColor;
/** 加载广告url */
- (void)reloadAdImageWithUrl:(NSString *)imageUrl;

@end
