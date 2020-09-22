//
//  ConfirmIndexCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/9/21.
//

#import "ConfirmIndexCell.h"

@interface ConfirmIndexCell()

@end

@implementation ConfirmIndexCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    float viewW=ScreenWidth-LeftMargin*2;
    float viewH=FitRealValue(280);
    float labH=FitRealValue(60);
    if (IS_IPAD) {
        viewH=viewH*2/3;
        labH=labH*2/3;
    }
    self.img=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 0,viewW,viewH)];
    self.img.cornerRadius=5;
    [self addSubview:self.img];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, (viewH-labH)/2,viewW-LeftMargin,labH)];
    self.titleLab.font=[UIFont boldSystemFontOfSize:22];
    self.titleLab.textColor=[MTool colorWithHexString:@"#FFFFFF"];
    [self.img addSubview:self.titleLab];
    
}
@end
