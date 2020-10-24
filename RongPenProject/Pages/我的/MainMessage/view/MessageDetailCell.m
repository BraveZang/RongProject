//
//  MessageDetailCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/24.
//

#import "MessageDetailCell.h"

@implementation MessageDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView{
    
    float viewH=200*SCREEN_WIDTH/750;
    if (IS_IPAD) {
        viewH=viewH*2/3;
    }
    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, viewH)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.cornerRadius=4;
    [self addSubview:bgView];
    
    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(10,0, ScreenWidth-40,viewH/3*2)];
    self.contentLab.font=[UIFont systemFontOfSize:12];
    self.contentLab.numberOfLines=0;
    self.contentLab.textColor=[MTool colorWithHexString:@"333333"];
    [self addSubview:self.contentLab];
    
    self.timeLab=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30*SCREEN_WIDTH/750-200, self.contentLab.bottom, 200, viewH/3)];
    self.timeLab.font=[UIFont systemFontOfSize:12];
    self.timeLab.textAlignment=NSTextAlignmentRight;
    self.timeLab.textColor=[MTool colorWithHexString:@"666666"];
    self.timeLab.text=@"2020-5-28";
    [self addSubview:self.timeLab];
}

@end
