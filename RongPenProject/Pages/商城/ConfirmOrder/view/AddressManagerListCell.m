//
//  AddressManagerListCell.m
//  SanMuZhuangXiu
//
//  Created by 犇犇网络 on 2018/12/28.
//  Copyright © 2018 Darius. All rights reserved.
//

#import "AddressManagerListCell.h"

@implementation AddressManagerListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView{
    
    NSString*str=@"hahaha哈哈哈哈发回复哈哈发";
    self.nameLabel= [MTool quickCreateLabelWithleft:30*SCREEN_WIDTH/750 top:32*SCREEN_WIDTH/750 width:str.length*17 heigh:40*SCREEN_WIDTH/750 title:@"姓名"];
    self.nameLabel.font=[UIFont systemFontOfSize:16];
    self.nameLabel.textColor=[MTool colorWithHexString:@"333333"];
    [self addSubview: self.nameLabel];
    
    self.defaulLabel=[MTool quickCreateLabelWithleft:self.nameLabel.right top:32*SCREEN_WIDTH/750 width:66*SCREEN_WIDTH/750 heigh:24*SCREEN_WIDTH/750 title:@""];
    self.defaulLabel.font=[UIFont systemFontOfSize:12];
    self.defaulLabel.textColor=[MTool colorWithHexString:@"#888888"];
    [self addSubview: self.defaulLabel];
    
    self.markLabel=[MTool quickCreateLabelWithleft:self.defaulLabel.right+10*SCREEN_WIDTH/750 top:32*SCREEN_WIDTH/750 width:66*SCREEN_WIDTH/750 heigh:24*SCREEN_WIDTH/750 title:@"默认"];
    self.markLabel.textAlignment=NSTextAlignmentCenter;
    self.markLabel.layer.cornerRadius=8;
    self.markLabel.layer.masksToBounds = YES;
    self.markLabel.backgroundColor=[MTool colorWithHexString:@"#FF6B6B"];
    self.markLabel.font=[UIFont systemFontOfSize:10];
    self.markLabel.textColor=[UIColor whiteColor];
    [self addSubview: self.markLabel];
    
    self.addressLabel= [MTool quickCreateLabelWithleft:30*SCREEN_WIDTH/750 top:self.nameLabel.bottom+20*SCREEN_WIDTH/750 width:550*SCREEN_WIDTH/750 heigh:40*SCREEN_WIDTH/750 title:@""];
    self.addressLabel.font=[UIFont systemFontOfSize:14];
    self.addressLabel.textColor=[MTool colorWithHexString:@"999999"];
    [self addSubview: self.addressLabel];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame = CGRectMake(SCREEN_WIDTH-LeftMargin-90,(180-32)*SCREEN_WIDTH/750/2,90, 32*SCREEN_WIDTH/750);
    [self.editBtn setTitle:@"|   编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:[MTool colorWithHexString:@"#888888"] forState:UIControlStateNormal];
    self.editBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:self.editBtn];
    [self.editBtn addTarget:self action:@selector(editBtnclick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)deleteBtnCLick:(id)sender {
    
    self.deleteBlock();
}
- (void)defaultBtnClick:(id)sender {
    
    self.morenBlock();
}
-(void)editBtnclick{
    self.editBlock(_model);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setModel:(AddressModel *)model{
    _model=model;
    NSString*namestr=[NSString stringWithFormat:@"%@",model.name];
    self.nameLabel.frame=CGRectMake(30*SCREEN_WIDTH/750, 32*SCREEN_WIDTH/750, namestr.length*17, 40*SCREEN_WIDTH/750);
    self.nameLabel.text=namestr;
    
    NSString*phonestr=[NSString stringWithFormat:@"%@",model.mobile];
    self.defaulLabel.frame=CGRectMake(self.nameLabel.right, 32*SCREEN_WIDTH/750, phonestr.length*13, 40*SCREEN_WIDTH/750);
    self.defaulLabel.text=phonestr;
    
    self.markLabel.frame=CGRectMake(self.defaulLabel.right+5, 32*SCREEN_WIDTH/750, 66*SCREEN_WIDTH/750, 32*SCREEN_WIDTH/750);
    self.addressLabel.text=[NSString stringWithFormat:@"%@%@%@%@",model.sheng,model.shi,model.qu, model.address];
    if ([model.moren intValue]==0) {
        self.markLabel.hidden=YES;
        
    }
    else{
        self.markLabel.hidden=NO;
        
    }
}
@end
