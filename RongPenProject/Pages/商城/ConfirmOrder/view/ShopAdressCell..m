//
//  ShopAdressCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import "ShopAdressCell.h"

@implementation ShopAdressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    self.backgroundColor=[UIColor whiteColor];
    return self;
}
-(void)initView{
    
    self.heardImg=[[UIImageView alloc]initWithFrame:CGRectMake(20*SCREEN_WIDTH/750, 60*SCREEN_WIDTH/750, 40*SCREEN_WIDTH/750, 40*SCREEN_WIDTH/750)];
    [self.heardImg setImage:[UIImage imageNamed:@"attend_ico_position"]];
    [self addSubview:self.heardImg];
    
    self.adresslab=[MTool quickCreateLabelWithleft:self.heardImg.right+20*SCREEN_WIDTH/750 top:30*SCREEN_WIDTH/750 width:600*SCREEN_WIDTH/750 heigh:60*SCREEN_WIDTH/750 title:@"把爱奥奥哈或哈奥哈哈哈哈奥"];
    self.adresslab.font=[UIFont systemFontOfSize:16];
    self.adresslab.textColor=[MTool colorWithHexString:@"333333"];
    [self addSubview:self.adresslab];
    
    self.namelab=[MTool quickCreateLabelWithleft:self.heardImg.right+20*SCREEN_WIDTH/750 top:self.adresslab.bottom  width:600*SCREEN_WIDTH/750 heigh:30*SCREEN_WIDTH/750 title:@"把爱奥奥哈或哈奥哈哈哈哈奥"];
    self.namelab.font=[UIFont systemFontOfSize:12];
    self.namelab.textColor=[MTool colorWithHexString:@"7f8082"];
    [self addSubview:self.namelab];
    
    self.tishilab=[MTool quickCreateLabelWithleft:self.heardImg.right+20*SCREEN_WIDTH/750 top:30*SCREEN_WIDTH/750 width:600*SCREEN_WIDTH/750 heigh:60*SCREEN_WIDTH/750 title:@"暂无地址，点击添加地址"];
    self.tishilab.hidden=YES;
    self.tishilab.font=[UIFont systemFontOfSize:16];
    self.tishilab.textColor=[MTool colorWithHexString:@"7f8082"];
    [self addSubview:self.tishilab];
    
    UIView*lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 160*SCREEN_WIDTH/750, SCREEN_WIDTH, 24*SCREEN_WIDTH/750)];
    lineview.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    [self addSubview:lineview];
}
-(void)setAdressmodel:(AddressModel *)adressmodel{
    _adressmodel=adressmodel;
    if (_adressmodel.detail.length==0) {
        self.adresslab.hidden=YES;
        self.namelab.hidden=YES;
        self.tishilab.hidden=NO;
        
    }
    else{
        self.adresslab.hidden=NO;
        self.namelab.hidden=NO;
        self.tishilab.hidden=YES;
        
    }
    self.adresslab.text=_adressmodel.detail;
    self.namelab.text=[NSString stringWithFormat:@"%@ %@",_adressmodel.name,_adressmodel.phone];
}

@end
