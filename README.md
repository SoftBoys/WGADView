# WGADView
一款集成于App启动广告页面的框架
## 导入方式
pod 'WGADView' 

## 快速集成
在 AppDelegate 中 didFinishLaunch 方法中添加如下代码
``` 
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
self.window.rootViewController = nav;
WGADView *adview = [WGADView adviewToWindow:self.window buttonType:WGSkipButtonTypeCircleTime tapHandle:^(NSInteger index) {
        NSLog(@"index:%@", @(index));
        if (index == 1) {
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = [UIColor whiteColor];
            vc.title = @"webView";
            [nav pushViewController:vc animated:YES];
        }
    }];

    NSString *url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490158649193&di=f937d1d1446b360ecb83d3ec2d69c74a&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01e1445757ee930000018c1b51cf31.png";
    [adview reloadAdImageWithUrl:url];
```
详情请具体查看 Demo 
