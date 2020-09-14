//
//  AppDelegate.m
//  jiyouhui2020
//
//  Created by zanghui  on 2020/7/30.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "DZNavigationController.h"

@interface DZNavigationController ()

@end

@implementation DZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.navigationBar.translucent = NO;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    UIImage *image = [UIImage imageNamed:@"back"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.interactivePopGestureRecognizer.delegate=(id)self;
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage new]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:image];
    //    //设置Navigation Bar背景图片
    //    UIImage *title_bg = [UIImage imageNamed:@"pic_toubudaohanglanbeijing"];  //获取图片
    //    CGSize titleSize = CGSizeMake(ViewWidth, 64);  //获取Navigation Bar的位置和大小
    //    title_bg = [self scaleToSize:title_bg size:titleSize];//设置图片的大小与Navigation Bar相同
    //    [self.navigationBar setBackgroundImage:title_bg forBarMetrics:UIBarMetricsDefault];  //设置背景
}
//调整图片大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
