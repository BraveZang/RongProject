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
    
    self.heardImg=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 60*SCREEN_WIDTH/750, 40*SCREEN_WIDTH/750, 50*SCREEN_WIDTH/750)];
    [self.heardImg setImage:[UIImage imageNamed:@"adressimg"]];
    [self addSubview:self.heardImg];
    
    self.adresslab=[MTool quickCreateLabelWithleft:self.heardImg.right+20*SCREEN_WIDTH/750 top:30*SCREEN_WIDTH/750 width:FitRealValue(600) heigh:60*SCREEN_WIDTH/750 title:@"把爱奥奥哈或哈奥哈哈哈哈奥"];
    self.adresslab.font=[UIFont systemFontOfSize:16];
    self.adresslab.textColor=[MTool colorWithHexString:@"333333"];
    [self addSubview:self.adresslab];
    
    self.namelab=[MTool quickCreateLabelWithleft:self.heardImg.right+20*SCREEN_WIDTH/750 top:self.adresslab.bottom  width:500*SCREEN_WIDTH/750 heigh:50*SCREEN_WIDTH/750 title:@"把爱奥奥哈或哈奥哈哈哈哈奥"];
    self.namelab.font=[UIFont systemFontOfSize:12];
    self.namelab.numberOfLines=0;

    self.namelab.textColor=[MTool colorWithHexString:@"7f8082"];
    [self addSubview:self.namelab];
    
    self.tishilab=[MTool quickCreateLabelWithleft:self.heardImg.right+20*SCREEN_WIDTH/750 top:0 width:600*SCREEN_WIDTH/750 heigh:164*SCREEN_WIDTH/750 title:@"暂无地址，点击添加地址"];
    self.tishilab.hidden=YES;
    self.tishilab.font=[UIFont systemFontOfSize:14];
    self.tishilab.textColor=[MTool colorWithHexString:@"7f8082"];
    [self addSubview:self.tishilab];
}
-(void)setAdressmodel:(AddressModel *)adressmodel{
    _adressmodel=adressmodel;
    if (_adressmodel.address.length==0) {
        self.adresslab.hidden=YES;
        self.namelab.hidden=YES;
        self.tishilab.hidden=NO;
        
    }
    else{
        self.adresslab.hidden=NO;
        self.namelab.hidden=NO;
        self.tishilab.hidden=YES;
        
    }
    self.namelab.text=_adressmodel.address;
    self.adresslab.text=[NSString stringWithFormat:@"%@ %@",_adressmodel.name,_adressmodel.mobile];
}

@end
