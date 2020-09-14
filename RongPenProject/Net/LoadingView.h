//
//  NewLoadingView.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView {
    
    
    UIImageView *loadingImageView;
    
    BOOL animationing;
    
    CGFloat angle;
    
}

- (void)stopAnimation;


@property (nonatomic, assign) BOOL loadingViewAlpha;

@end
