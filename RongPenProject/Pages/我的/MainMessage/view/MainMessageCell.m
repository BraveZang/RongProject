//
//  MainMessageCell.m
//  SanMuZhuangXiu
//
//  Created by zanghui  on 2020/5/28.
//  Copyright © 2020 Darius. All rights reserved.
//

#import "MainMessageCell.h"
#import "MessageModel.h"
@implementation MainMessageCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView{
    
    float viewH=120*SCREEN_WIDTH/750;
    float imgH=80*SCREEN_WIDTH/750;
    if (IS_IPAD) {
        viewH=viewH*2/3;
        imgH=imgH*2/3;
    }
   
    self.heardImg=[[UIImageView alloc]initWithFrame:CGRectMake(30*SCREEN_WIDTH/750, (viewH-imgH)/2, imgH, imgH)];
    self.heardImg.layer.cornerRadius=imgH/2;
    self.heardImg.layer.masksToBounds=YES;
    [self.heardImg setImage:[UIImage imageNamed:@"mine_message_fw"]];
    self.heardImg.borderColor=[MTool colorWithHexString:@"f8f8f8"];
    self.heardImg.borderWidth=1;
    [self addSubview:self.heardImg];
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+5, (viewH-imgH)/2, 300, imgH/2)];
    self.nameLab.font=[UIFont systemFontOfSize:14];
    self.nameLab.text=@"服务通知";
    [self addSubview:self.nameLab];
    
    
    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+5,  self.nameLab.bottom, 300, imgH/2)];
    self.contentLab.font=[UIFont systemFontOfSize:12];
    self.contentLab.textColor=[MTool colorWithHexString:@"666666"];
    self.contentLab.text=@"暂无通知";
    [self addSubview:self.contentLab];
    
    self.timeLab=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30*SCREEN_WIDTH/750-100, 0, 100, imgH)];
    self.timeLab.font=[UIFont systemFontOfSize:12];
    self.timeLab.textAlignment=NSTextAlignmentRight;
    self.timeLab.textColor=[MTool colorWithHexString:@"666666"];
    self.timeLab.text=@"2020-5-28";
    [self addSubview:self.timeLab];
    
    
}
-(void)setModel:(MessageModel *)model{
    _model=model;
    if ([model.lastMessage[@"type"] isEqualToString:@"image"]==YES) {
        self.contentLab.text=@"[图片]";
    }
    else{
        self.contentLab.text=model.lastMessage[@"content"];
    }
    //    self.timeLab.text=[MTool distanceTimeWithBeforeTime:[MessageModel.receivedTime integerValue]/1000];
    self.timeLab.text=[DZTools compareCurrentTime:model.receivedTime];
    
}

@end
