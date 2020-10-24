//
//  ZRAlertController.m
//  ZYJSVPN
//
//  Created by mac on 2019/1/3.
//  Copyright © 2019年 ZrteC. All rights reserved.
//

#import "ZRAlertController.h"

@interface ZRAlertController ()

@end

@implementation ZRAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (instancetype)initZRAlerControllerWithTitle:(nonnull NSString *)title message:(nonnull NSString *)message style:(NSString *)style titleArr:(NSMutableArray *)titleArr alerAction:(void (^)(NSInteger index))alerAction{
    //参数说明:
    //title表示弹框的标题;
    //message表示弹框的展示的信息;
    //style是0或者1;代表弹框的类型;UIAlertControllerStyleActionSheet = 0（带取消按钮）,UIAlertControllerStyleAlert = 1; UIAlertControllerStyleActionSheet = 3无取消按钮
    //titleArr为弹框中出现的按钮标题的数组;个数你自己决定;
    //alerAction为block回调时间,因为这里只需要判断点击的按钮坐标就可以,其他需要壳自行添加参数;
    
    //判断弹框类型
    if ([style isEqualToString:@"1"]) {
        ZRAlertController *alert = [ZRAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (NSInteger i = 0; i < titleArr.count; i++) {
            
            
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    if (alerAction) {
                        alerAction(i);
                    }
                    
                }];
                [alert addAction:confirm];
            
            
        }
        return alert;
        
    }else{
        ZRAlertController *alert = [ZRAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSInteger i = 0; i < titleArr.count; i++) {
            if (i == titleArr.count-1) {
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArr objectAtIndex:i] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    if (alerAction) {
                        alerAction(i);
                    }
                    
                }];
                [alert addAction:confirm];
            }else{
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    if (alerAction) {
                        alerAction(i);
                    }
                    
                }];
                [alert addAction:confirm];
        
            }
        }
        
        return alert;
    }
    
}

-(void)showWBAler{
    [[self getCurrentVC] presentViewController:self animated:YES completion:nil];
}

-(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}


@end
