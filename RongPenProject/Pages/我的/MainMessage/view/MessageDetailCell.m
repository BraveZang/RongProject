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
    
    float viewH=180*SCREEN_WIDTH/750;
    if (IS_IPAD) {
        viewH=viewH*2/3;
    }
    self.backgroundColor=[UIColor clearColor];
    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, viewH)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.cornerRadius=4;
    [self addSubview:bgView];
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,0, 300, viewH/3)];
    self.nameLab.font=[UIFont systemFontOfSize:14];
    self.nameLab.text=@"服务通知";
    [bgView addSubview:self.nameLab];
    
    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, self.nameLab.bottom, ScreenWidth-LeftMargin*2,viewH/3*2)];
    self.contentLab.font=[UIFont systemFontOfSize:12];
    self.contentLab.numberOfLines=0;
    self.contentLab.textColor=[MTool colorWithHexString:@"333333"];
    [bgView addSubview:self.contentLab];
    
    self.timeLab=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20-LeftMargin-200, 0, 200, viewH/3)];
    self.timeLab.font=[UIFont systemFontOfSize:12];
    self.timeLab.textAlignment=NSTextAlignmentRight;
    self.timeLab.textColor=[MTool colorWithHexString:@"666666"];
    self.timeLab.text=@"2020-5-28";
    [bgView addSubview:self.timeLab];
}
-(void)setModel:(MessageDetailModel *)model{
    
    self.contentLab.text=model.content;
    self.timeLab.text=[MTool dateStringFromString:model.addtime toFormat:@"YYYY-MM-dd HH:mm"];
    self.nameLab.text=model.title;
    
}
@end
