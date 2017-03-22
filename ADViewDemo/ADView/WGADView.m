//
//  WGADView.m
//  ADViewDemo
//
//  Created by dfhb@rdd on 17/3/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGADView.h"

#import "SDImageCache.h"
#import "SDWebImageManager.h"

#define kMainScreenW  CGRectGetWidth([UIScreen mainScreen].bounds)
#define kMainScreenH  CGRectGetHeight([UIScreen mainScreen].bounds)

#ifdef DEBUG
#define WGDebugLog(...)  NSLog(__VA_ARGS__)
#else
#define WGDebugLog(...)
#endif

@interface WGADView ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval seconds;
@property (nonatomic, strong) UIButton *buttonCircle_skip;
@property (nonatomic, strong) UIButton *buttonNormal_skip;
@property (nonatomic, strong) CAShapeLayer *viewLayer;
@end
@implementation WGADView

+ (instancetype)adviewToWindow:(UIWindow *)window buttonType:(WGSkipButtonType)buttonType tapHandle:(WGADViewTapHandle)tapHandle {
    WGADView *adView = [[self class] new];
    adView.window = window;
    adView.buttonType = buttonType;
    adView.tapHandle = tapHandle;
    adView.frame = window.bounds;
    [window addSubview:adView];
    return adView;
}
- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        _duration = 5;
        
        // UILaunchImages
//        self.image = [self getLaunchImage];
        self.placeholderImage = [self getLaunchImage];
    }
    return self;
}
- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImage = placeholderImage;
    self.image = _placeholderImage;
}
- (UIImage *)getLaunchImage {
    UIImage *lauchImage  = nil;
    NSString *viewOrientation = nil;
    CGSize viewSize  = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation  = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft ||
        orientation == UIInterfaceOrientationLandscapeRight) {
        viewOrientation = @"Landscape";
    } else {
        viewOrientation = @"Portrait";
    }
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSArray *imagesDictionary = info[@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
//    WGDebugLog(@"info:%@", info);
    return lauchImage;
}
- (void)setButtonType:(WGSkipButtonType)buttonType {
    _buttonType = buttonType;
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    if (_buttonType == WGSkipButtonTypeCircleTime) {
        [self addSubview:self.buttonCircle_skip];
    } else if (_buttonType == WGSkipButtonTypeNormalTime) {
        [self addSubview:self.buttonNormal_skip];
    } else if (_buttonType == WGSkipButtonTypeNone) {
        
    }
}

- (void)reloadAdImageWithUrl:(NSString *)imageUrl {
    if (imageUrl.length <= 0) {
        [self invalidate];
        [self removeFromSuperview];
        return;
    }
    
    [self startTimer];
    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageUrl];
    if (cacheImage) {
        WGDebugLog(@"cache");
        self.image = cacheImage;
    } else {
        WGDebugLog(@"download");
        __weak typeof(self) weakself = self;
        NSURL *url = [NSURL URLWithString:imageUrl];
        [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image) {
                __strong typeof(weakself) strongself = weakself;
                strongself.image = image;
                [[SDImageCache sharedImageCache] storeImage:image forKey:imageUrl];
            } else {
//                [self tapWithIndex:0];
                [self invalidate];
                [self removeFromSuperview];
            }
            
        }];
    }
    
}

- (void)startTimer {
    // 开启圆盘倒计时
    [self setCircle];
    [self invalidate];
    self.seconds = self.duration;

    [self repeadWithDuration:nil];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(repeadWithDuration:) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)repeadWithDuration:(NSTimer *)timer {
    
    NSString *title = [NSString stringWithFormat:@"%d跳过", (int)self.seconds];

    if (self.buttonType == WGSkipButtonTypeCircleTime) {
        title = [NSString stringWithFormat:@"%d", (int)self.seconds];
        title = @"跳过";
        [self.buttonCircle_skip setTitle:title forState:UIControlStateNormal];
    } else {
        [self.buttonNormal_skip setTitle:title forState:UIControlStateNormal];
    }
    NSTimeInterval duration = -- self.seconds;
    if (duration < 0) {
        [self invalidate];
        [self dismiss];
    } else {
        WGDebugLog(@"duration:%@",@(duration));
    }
}
- (void)setCircle {
    
    __block NSTimeInterval count = 0;
    
    CGFloat duration = 0.1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),duration*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (count > self.duration) {
                self.viewLayer.strokeStart = 1;
                dispatch_source_cancel(timer);
            } else {
                count += duration;
                self.viewLayer.strokeStart = count/self.duration;
            }
            
            
        });
    });
    dispatch_resume(timer);
}
#pragma mark - 隐藏图片
- (void)dismiss {
    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self invalidate];
        [self removeFromSuperview];
    }];
}
- (void)invalidate {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)skipClick {
    [self tapWithIndex:0];
}
- (void)tapWithIndex:(NSInteger)index {
    [self invalidate];
    [self removeFromSuperview];
    if (self.tapHandle) {
        self.tapHandle(index);
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self tapWithIndex:1];
}
#pragma mark - getter && setter
- (UIColor *)skipBackgroundColor {
    return [[UIColor blackColor] colorWithAlphaComponent:0.5];
}
- (UIColor *)strokeColor {
    return [UIColor redColor];
}
- (UIButton *)buttonCircle_skip {
    if (_buttonCircle_skip == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        CGFloat buttonW = 50, buttonH = buttonW;
        CGFloat buttonX = kMainScreenW - buttonW - 10;
        CGFloat buttonY = 20;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = [self strokeColor].CGColor;
        layer.lineWidth = 2;
        layer.lineCap = kCALineCapRound;
        layer.lineJoin = kCALineJoinRound;
        layer.strokeStart = 0;
        CGRect frame = button.bounds;
        layer.path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:buttonW/2].CGPath;
        layer.fillColor = [self skipBackgroundColor].CGColor;

        [button.layer insertSublayer:layer atIndex:0];
        self.viewLayer = layer;
        
        [button addTarget:self action:@selector(skipClick) forControlEvents:UIControlEventTouchUpInside];
        
        _buttonCircle_skip = button;
    }
    return _buttonCircle_skip;
}
- (UIButton *)buttonNormal_skip {
    if (_buttonNormal_skip == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.masksToBounds = YES;
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 4;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.backgroundColor = [self skipBackgroundColor];
        CGFloat buttonW = 60, buttonH = 30;
        CGFloat buttonX = kMainScreenW - buttonW - 10;
        CGFloat buttonY = 20;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button addTarget:self action:@selector(skipClick) forControlEvents:UIControlEventTouchUpInside];
        _buttonNormal_skip = button;
    }
    return _buttonNormal_skip;
}

#pragma mark - private
- (void)dealloc {
    WGDebugLog(@"---AdView is dealloc---");
}
@end
