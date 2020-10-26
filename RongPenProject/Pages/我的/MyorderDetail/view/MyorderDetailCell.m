//
//  MyorderDetailCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import "MyorderDetailCell.h"

@implementation MyorderDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    self.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    return self;
}
-(void)initView{
    
    float viewH=FitRealValue(620);
    float viewW=ScreenWidth-LeftMargin*2;
    float imgH=FitRealValue(160);
    float imgW=FitRealValue(200);
    float btnW=FitRealValue(160);
    float btnH=FitRealValue(60);
    float bottomH=FitRealValue(90);
    if (IS_IPAD) {
        viewH=viewH*2/3;
        imgH=imgH*2/3;
        btnH=btnH*2/3;
        bottomH=bottomH*2/3;
    }
    
    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin, 0, viewW, viewH)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    self.timeLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,0, FitRealValue(400), FitRealValue(72))];
    self.timeLab.font=[UIFont systemFontOfSize:16];
    self.timeLab.textColor=[MTool colorWithHexString:@"#212121"];
    self.timeLab.text=@"商品信息";
    [bgView addSubview:self.timeLab];
    
    self.statusLab=[[UILabel alloc]initWithFrame:CGRectMake(viewW-FitRealValue(400)-LeftMargin,0, FitRealValue(400), FitRealValue(72))];
    self.statusLab.textAlignment=NSTextAlignmentRight;
    self.statusLab.font=[UIFont systemFontOfSize:12];
    self.statusLab.textColor=[MTool colorWithHexString:@"#FF8D8D"];
    [bgView addSubview:self.statusLab];
    
    UIView*lineview=[[UIView alloc]initWithFrame:CGRectMake(0, FitRealValue(72), viewW, 1)];
    lineview.backgroundColor=[MTool colorWithHexString:@"F3F3F3"];
    [bgView addSubview:lineview];
    
    
    self.heardImg=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin,LeftMargin+lineview.bottom, imgW, imgH)];
    [bgView addSubview:self.heardImg];
    
    self.markLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+8,LeftMargin+lineview.bottom+5, FitRealValue(40), FitRealValue(20))];
    self.markLab.textColor=[UIColor whiteColor];
    self.markLab.font=[UIFont systemFontOfSize:10];
    self.markLab.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:self.markLab];
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(self.markLab.right+3,LeftMargin+lineview.bottom, FitRealValue(400), FitRealValue(36))];
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
    
    
    UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0,self.heardImg.bottom+LeftMargin, viewW, 1)];
    lineView.backgroundColor=[MTool colorWithHexString:@"#F3F3F3"];
    [bgView addSubview:lineView];
    
    UILabel*moneyTitleLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,lineView.bottom, FitRealValue(480), FitRealValue(80))];
    moneyTitleLab.text=@"商品价格";
    moneyTitleLab.font=[UIFont systemFontOfSize:14];
    moneyTitleLab.textColor=[MTool colorWithHexString:@"#666666"];
    [bgView addSubview:moneyTitleLab];
    
    self.moneyLab=[[UILabel alloc]initWithFrame:CGRectMake(viewW-LeftMargin-200,lineView.bottom, 200, FitRealValue(80))];
    self.moneyLab.font=[UIFont systemFontOfSize:14];
    self.moneyLab.textAlignment=NSTextAlignmentRight;
    self.moneyLab.textColor=[MTool colorWithHexString:@"#666666"];
    [bgView addSubview:self.moneyLab];
    
    UILabel*yunfeiTitleLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,moneyTitleLab.bottom, FitRealValue(480), FitRealValue(80))];
    yunfeiTitleLab.text=@"运费";
    yunfeiTitleLab.font=[UIFont systemFontOfSize:14];
    yunfeiTitleLab.textColor=[MTool colorWithHexString:@"#666666"];
    [bgView addSubview:yunfeiTitleLab];
    
    self.yunfeiLab=[[UILabel alloc]initWithFrame:CGRectMake(viewW-LeftMargin-200,moneyTitleLab.bottom, 200, FitRealValue(80))];
    self.yunfeiLab.font=[UIFont systemFontOfSize:14];
    self.yunfeiLab.textAlignment=NSTextAlignmentRight;
    self.yunfeiLab.textColor=[MTool colorWithHexString:@"#666666"];
    [bgView addSubview:self.yunfeiLab];
    
    UIView*lineView1=[[UIView alloc]initWithFrame:CGRectMake(0,self.yunfeiLab.bottom, viewW, 1)];
    lineView1.backgroundColor=[MTool colorWithHexString:@"#F3F3F3"];
    [bgView addSubview:lineView1];
    
    
    self.totaleMoneyLab=[[UILabel alloc]initWithFrame:CGRectMake(viewW-LeftMargin-400,lineView1.bottom, 400, bottomH)];
    self.totaleMoneyLab.font=[UIFont systemFontOfSize:14];
    self.totaleMoneyLab.textAlignment=NSTextAlignmentRight;
    self.totaleMoneyLab.textColor=[MTool colorWithHexString:@"#121212"];
    [bgView addSubview:self.totaleMoneyLab];


}
-(void)setModel:(MyorderDetailModel *)model{
    _model=model;
    self.statusLab.text=model.orderstatus;
    NSDictionary*dic=model.lists;
    [self.heardImg sd_setImageWithURL:[NSURL URLWithString:dic[@"fmimg"]]];
    NSString*typeStr=dic[@"type"];
    if ([typeStr isEqualToString:@"录播"]) {
        self.markLab.backgroundColor=[MTool colorWithHexString:@"#FFA500"];
    }
    else{
        self.markLab.backgroundColor=[MTool colorWithHexString:@"#FF8989"];

    }
    self.markLab.text=typeStr;
    self.nameLab.text=dic[@"goodsname"];
    self.moneyLab.text=dic[@"price"];
    self.yunfeiLab.text=model.kdprice;
    self.totaleMoneyLab.text=[NSString stringWithFormat:@"实付款:%@", model.total];
    
}
@end
