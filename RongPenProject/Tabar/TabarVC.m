//
//  MainIndexVC.m
//  jiyouhui2020
//
//  Created by TigerYang on 2020/7/30.
//  Copyright © 2020 Lmjx. All rights reserved.
//

#import "TabarVC.h"

#import "ReadIndexVC.h"
#import "ConfirmIndexVC.h"
#import "PracticeIndexVC.h"
#import "MainIndexVC.h"

@interface TabarVC () <UITabBarControllerDelegate, UITabBarDelegate>

@end


@implementation TabarVC

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
}

-(void)addChildViewControllers{
    
    [self addChildViewController:[[ReadIndexVC alloc] init] title:@"点读" imageName:@"main_read" selectedImageName:@"main_recommend_s"];
    [self addChildViewController:[[ConfirmIndexVC alloc] init] title:@"闯关" imageName:@"main_cat" selectedImageName:@"main_cat_s"];
    [self addChildViewController:[[PracticeIndexVC alloc] init] title:@"练习" imageName:@"main_product" selectedImageName:@"main_product_s"];
    [self addChildViewController:[[MainIndexVC alloc] init] title:@"我的" imageName:@"main_ehome" selectedImageName:@"main_ehome_s"];
}


- (void)addChildViewController:(UIViewController *)childViewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    childViewController.title = title;
    childViewController.tabBarItem.image = [UIImage imageNamed:imageName];
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:childViewController];
    [self addChildViewController:navigationController];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    //颜色属性
    attributes[NSForegroundColorAttributeName] = [MTool colorWithHexString:@"#3C3C3C"];
    //字体大小属性
    //还有一些其他属性的key可以去NSAttributedString.h文件里去找
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    NSMutableDictionary *selectAttri = [NSMutableDictionary dictionary];
    selectAttri[NSForegroundColorAttributeName] = [MTool colorWithHexString:@"#D12E2E"];
    selectAttri[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    childViewController.tabBarItem.title = title;
    //设置为选中状态的文字属性
    [childViewController.tabBarItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    //设置选中状态的属性
    [childViewController.tabBarItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    self.tabBar.tintColor = [MTool colorWithHexString:@"#D12E2E"];;
}

@end
