//
//  MAlertView.h
//  SanMuZhuangXiu
//
//  Created by apple on 2019/7/5.
//  Copyright © 2019 Darius. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MAlertViewDelegate <NSObject>

- (void)malertviewDidMiss;

@end

@interface MAlertView : UIView
{
    IBOutlet UILabel *label;
}

@property (nonatomic, assign) id <MAlertViewDelegate> delegate;

- (void)showWithTitle:(NSString *)title inView:(UIView *)view;

@end
