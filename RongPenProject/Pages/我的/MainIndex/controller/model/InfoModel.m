
//
//  InfoModel.m
//  AloneWalker
//
//  Created by mac on 18/06/2019.
//  Copyright © 2019 ZrteC. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

- (instancetype)initWithTitle:(NSString *)title  Content:(NSString *)content  andalert:(nonnull NSString *)alert{
    
    self = [super init];
    if (self) {
        
        self.title = title;
        self.content = content;
        self.alert  = alert;
    }
    return self;
    
}


- (void)setContent:(NSString *)content{
 
    _content = content;
 
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
