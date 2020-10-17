//
//  ConfirmOrderVCCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import "ConfirmOrderVCCell.h"

@implementation ConfirmOrderVCCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    self.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    return self;
}
-(void)initView{
    
    float viewH=FitRealValue(368);
    float viewW=ScreenWidth-LeftMargin*2;

    float bottomViewH=FitRealValue(108);

    float imgH=FitRealValue(160);
    float imgW=FitRealValue(160);
    
    float btnW=FitRealValue(100);
    float btnH=FitRealValue(30);


    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH-bottomViewH)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    self.heardImg=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, FitRealValue(50), imgW, imgH)];
    [bgView addSubview:self.heardImg];
    
    self.markLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+5, FitRealValue(50), FitRealValue(40), FitRealValue(20))];
    self.markLab.textColor=[UIColor whiteColor];
    self.markLab.font=[UIFont systemFontOfSize:10];
    self.markLab.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:self.markLab];
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(self.markLab.right+3, FitRealValue(46), FitRealValue(400), FitRealValue(36))];
    self.nameLab.font=[UIFont systemFontOfSize:16];
    self.nameLab.textColor=[MTool colorWithHexString:@"#212121"];
    [bgView addSubview:self.nameLab];
    
    self.gradeLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+5,self.nameLab.bottom+FitRealValue(20), FitRealValue(480), FitRealValue(24))];
    self.gradeLab.font=[UIFont systemFontOfSize:12];
    self.gradeLab.textColor=[MTool colorWithHexString:@"#888888"];
    [bgView addSubview:self.gradeLab];
    
    self.subjectsLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+5,self.gradeLab.bottom+FitRealValue(20), FitRealValue(480), FitRealValue(24))];
    self.subjectsLab.font=[UIFont systemFontOfSize:12];
    self.subjectsLab.textColor=[MTool colorWithHexString:@"#888888"];
    [bgView addSubview:self.subjectsLab];
    
    self.moneyLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+5,self.subjectsLab.bottom, FitRealValue(480), FitRealValue(40))];
    self.moneyLab.font=[UIFont systemFontOfSize:14];
    self.moneyLab.textColor=[MTool colorWithHexString:@"#FF665B"];
    [bgView addSubview:self.moneyLab];
    
    self.numberBtn=[[PPNumberButton alloc]initWithFrame:CGRectMake(viewW-LeftMargin-btnW, self.subjectsLab.bottom+FitRealValue(20), btnW, btnH)];
    self.numberBtn.increaseImage=[UIImage imageNamed:@"PpNumberAdd"];
    self.numberBtn.decreaseImage=[UIImage imageNamed:@"PpNumberReduce"];
    [bgView addSubview:self.numberBtn];
    self.numberBtn.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
        
//        self.numBlock(number);
    };

    self.bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, bgView.bottom, viewW, bottomViewH)];
    self.bottomView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.bottomView];
    
    UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, 1)];
    lineView.backgroundColor=[MTool colorWithHexString:@"#F3F3F3"];
    [self.bottomView addSubview:lineView];
    
    UILabel*coloLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 0, 300, bottomViewH)];
    coloLab.text=@"颜色选择";
    coloLab.font=[UIFont systemFontOfSize:14];
    coloLab.textColor=[MTool colorWithHexString:@"#212121"];
    [self.bottomView addSubview:coloLab];
    
    UIButton*bottomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame=CGRectMake(viewW-LeftMargin-btnW, 0, btnW, bottomViewH);
    [bottomBtn setTitle:@"选择" forState:UIControlStateNormal];
    [bottomBtn setImage:[UIImage imageNamed:@"buy_rightimg"] forState:UIControlStateNormal];
    [bottomBtn layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleRight imageTitleSpace:3];
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:bottomBtn];
    
}
-(void)setDic:(NSDictionary *)dic{
    
    _dic=dic;
    [self.heardImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"fmimg"]]]];
    if ([dic[@"tip"] isEqualToString:@"赠品"]==YES) {
        self.markLab.backgroundColor=[MTool colorWithHexString:@"#FFA500"];
        self.numberBtn.hidden=YES;
        self.bottomView.hidden=YES;
        self.numberBtn.editing=NO;
        self.markLab.text=dic[@"tip"];


    }
    else{
        self.markLab.backgroundColor=[MTool colorWithHexString:@"#FF8989"];
        self.numberBtn.editing=YES;
        self.bottomView.hidden=NO;
        self.markLab.text=dic[@"type"];
    }
    self.numberBtn.currentNumber=[dic[@"num"] floatValue];
    self.nameLab.text=dic[@"goodsname"];
    self.gradeLab.hidden=YES;
    self.subjectsLab.hidden=YES;
    self.moneyLab.text=[NSString stringWithFormat:@"￥%@",dic[@"price"]];

}
-(void)bottomBtnClick{
    
    self.colorBlock(self.dic[@"guige"]);
}
@end
