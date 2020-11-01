//
//  MyOrderListCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import "MyOrderListCell.h"

@implementation MyOrderListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    self.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    return self;
}
-(void)initView{
    
    float viewH=FitRealValue(436);
    float viewW=ScreenWidth-LeftMargin*2;
    
    float imgH=FitRealValue(160);
    float imgW=FitRealValue(200);
    
    float btnW=FitRealValue(160);
    float btnH=FitRealValue(60);
    if (IS_IPAD) {
        viewH=viewH*2/3;
        imgH=imgH*2/3;
        btnH=btnH*2/3;
    }
    
    
    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin, 0, viewW, viewH)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    self.timeLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,0, FitRealValue(400), FitRealValue(72))];
    self.timeLab.font=[UIFont systemFontOfSize:12];
    self.timeLab.textColor=[MTool colorWithHexString:@"#888888"];
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
    
    self.markLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+5,LeftMargin+lineview.bottom, FitRealValue(60), FitRealValue(25))];
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
    
    self.moneyLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+5,self.gradeLab.bottom, FitRealValue(480), FitRealValue(40))];
    self.moneyLab.font=[UIFont systemFontOfSize:14];
    self.moneyLab.textColor=[MTool colorWithHexString:@"#FF665B"];
    [bgView addSubview:self.moneyLab];
    
    
    UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0,self.heardImg.bottom+LeftMargin, viewW, 1)];
    lineView.backgroundColor=[MTool colorWithHexString:@"#F3F3F3"];
    [bgView addSubview:lineView];
    
    
    self.bottomBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn2.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
    self.bottomBtn2.titleLabel.font=[UIFont systemFontOfSize:14];
    self.bottomBtn2.cornerRadius=3;
    [self.bottomBtn2 setTitle:@"查看物流" forState:UIControlStateNormal];
    [self.bottomBtn2 setTitleColor:[MTool colorWithHexString:@"#FF6B6B"] forState:UIControlStateNormal];
    self.bottomBtn2.borderWidth=1;
    self.bottomBtn2.hidden=YES;
    self.bottomBtn2.tag=200;
    [self.bottomBtn2 addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomBtn2.borderColor=[MTool colorWithHexString:@"#FF6B6B"];
    [bgView addSubview:self.bottomBtn2];
    
    
    self.bottomBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn1.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
    self.bottomBtn1.titleLabel.font=[UIFont systemFontOfSize:14];
    self.bottomBtn1.cornerRadius=3;
    [self.bottomBtn1 setTitle:@"查看订单" forState:UIControlStateNormal];
    [self.bottomBtn1 setTitleColor:[MTool colorWithHexString:@"#FF6B6B"] forState:UIControlStateNormal];
    self.bottomBtn1.borderWidth=1;
    self.bottomBtn1.hidden=YES;
    self.bottomBtn1.tag=100;
    [self.bottomBtn1 addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomBtn1.borderColor=[MTool colorWithHexString:@"#FF6B6B"];
    [bgView addSubview:self.bottomBtn1];
    
    self.bottomBtn3=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn3.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
    self.bottomBtn3.titleLabel.font=[UIFont systemFontOfSize:14];
    self.bottomBtn3.cornerRadius=3;
    [self.bottomBtn3 setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.bottomBtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomBtn3 setBackgroundColor:[MTool colorWithHexString:@"#FF6B6B"]];
    self.bottomBtn3.hidden=YES;
    self.bottomBtn3.tag=300;
    [self.bottomBtn3 addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.bottomBtn3];
    
    self.bottomBtn4=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn4.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
    self.bottomBtn4.titleLabel.font=[UIFont systemFontOfSize:14];
    self.bottomBtn4.cornerRadius=3;
    [self.bottomBtn4 setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.bottomBtn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomBtn4 setBackgroundColor:[MTool colorWithHexString:@"#FF6B6B"]];
    self.bottomBtn4.hidden=YES;
    self.bottomBtn4.tag=400;
    [self.bottomBtn4 addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.bottomBtn4];
    
    self.bottomBtn10=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn10.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
    self.bottomBtn10.titleLabel.font=[UIFont systemFontOfSize:14];
    self.bottomBtn10.cornerRadius=3;
    [self.bottomBtn10 setTitle:@"去付款" forState:UIControlStateNormal];
    [self.bottomBtn10 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomBtn10 setBackgroundColor:[MTool colorWithHexString:@"#FF6B6B"]];
    self.bottomBtn10.hidden=YES;
    self.bottomBtn10.tag=400;
    [self.bottomBtn10 addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.bottomBtn10];
    
    
    self.bottomBtn5=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn5.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
    self.bottomBtn5.titleLabel.font=[UIFont systemFontOfSize:14];
    self.bottomBtn5.cornerRadius=3;
    [self.bottomBtn5 setTitle:@"退  款" forState:UIControlStateNormal];
    [self.bottomBtn5 setTitleColor:[MTool colorWithHexString:@"#FF6B6B"] forState:UIControlStateNormal];
    self.bottomBtn5.borderWidth=1;
    self.bottomBtn5.hidden=YES;
    self.bottomBtn5.tag=500;
    [self.bottomBtn5 addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomBtn5.borderColor=[MTool colorWithHexString:@"#FF6B6B"];
    [bgView addSubview:self.bottomBtn5];
    
    self.bottomBtn6=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn6.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
    self.bottomBtn6.titleLabel.font=[UIFont systemFontOfSize:14];
    self.bottomBtn6.cornerRadius=3;
    [self.bottomBtn6 setTitle:@"退  款" forState:UIControlStateNormal];
    [self.bottomBtn6 setTitleColor:[MTool colorWithHexString:@"#FF6B6B"] forState:UIControlStateNormal];
    self.bottomBtn6.borderWidth=1;
    self.bottomBtn6.hidden=YES;
    self.bottomBtn6.tag=600;
    [self.bottomBtn6 addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomBtn6.borderColor=[MTool colorWithHexString:@"#FF6B6B"];
    [bgView addSubview:self.bottomBtn6];
    
    
    self.bottomBtn7=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn7.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
    self.bottomBtn7.titleLabel.font=[UIFont systemFontOfSize:14];
    self.bottomBtn7.cornerRadius=3;
    [self.bottomBtn7 setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.bottomBtn7 setTitleColor:[MTool colorWithHexString:@"#FF6B6B"] forState:UIControlStateNormal];
    self.bottomBtn7.borderWidth=1;
    self.bottomBtn7.borderColor=[MTool colorWithHexString:@"#FF6B6B"];
    self.bottomBtn7.hidden=YES;
    self.bottomBtn7.tag=700;
    [self.bottomBtn7 addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomBtn6.borderColor=[MTool colorWithHexString:@"#FF6B6B"];
    [bgView addSubview:self.bottomBtn7];
    
}
-(void)setModel:(MyOrderListModel *)model{
    _model=model;
    float viewH=FitRealValue(436);
    float viewW=ScreenWidth-LeftMargin*2;
    
    float imgH=FitRealValue(160);
    float imgW=FitRealValue(200);
    
    float btnW=FitRealValue(160);
    float btnH=FitRealValue(60);
    if (IS_IPAD) {
        viewH=viewH*2/3;
        imgH=imgH*2/3;
        btnH=btnH*2/3;
    }
    self.timeLab.text=[MTool dateStringFromString:model.addtime toFormat:@"YYYY-MM-dd HH:mm:ss"];
    if ([model.type isEqualToString:@"录播"]) {
        self.markLab.backgroundColor=[MTool colorWithHexString:@"#FFA500"];
    }
    else if ([model.type isEqualToString:@"直播"]) {
        self.markLab.backgroundColor=[MTool colorWithHexString:@"#FF8989"];
    }
    else{
        self.markLab.hidden=YES;
        self.nameLab.frame=CGRectMake(self.heardImg.right+5,LeftMargin+FitRealValue(98), FitRealValue(400), FitRealValue(36));
    }
    self.markLab.text=model.type;
    [self.heardImg sd_setImageWithURL:[NSURL URLWithString:model.fmpic]];
    self.nameLab.text=model.goodsname;
    self.moneyLab.text=[NSString stringWithFormat:@"¥%@",model.price];
    self.statusLab.text=model.orderstatus;
    if ([model.orderstatus isEqualToString:@"待付款"]) {
        self.bottomBtn10.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn10.hidden=NO;
        self.bottomBtn1.frame=CGRectMake(viewW-(LeftMargin+btnW)*2,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn1.hidden=NO;
        self.bottomBtn7.frame=CGRectMake(viewW-(LeftMargin+btnW)*3,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn7.hidden=NO;
        
        
        self.bottomBtn2.hidden=YES;
        self.bottomBtn3.hidden=YES;
        self.bottomBtn4.hidden=YES;
        self.bottomBtn6.hidden=YES;
        
    }
    if ([model.orderstatus isEqualToString:@"已付款"]) {
        self.bottomBtn1.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        
        self.bottomBtn1.hidden=NO;
        self.bottomBtn5.frame=CGRectMake(viewW-(LeftMargin+btnW)*2,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn5.hidden=NO;
        
        self.bottomBtn2.hidden=YES;
        self.bottomBtn3.hidden=YES;
        self.bottomBtn4.hidden=YES;
        self.bottomBtn6.hidden=YES;
        self.bottomBtn7.hidden=YES;
        self.bottomBtn10.hidden=YES;
        
    }
    if ([model.orderstatus isEqualToString:@"“已完成"]) {
        self.bottomBtn1.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        
        self.bottomBtn1.hidden=NO;
        self.bottomBtn5.frame=CGRectMake(viewW-(LeftMargin+btnW)*2,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn5.hidden=NO;
        
        self.bottomBtn2.hidden=YES;
        self.bottomBtn3.hidden=YES;
        self.bottomBtn4.hidden=YES;
        self.bottomBtn6.hidden=YES;
        self.bottomBtn7.hidden=YES;
        self.bottomBtn10.hidden=YES;
        
    }
    if ([model.orderstatus isEqualToString:@"已失效"]) {
        self.bottomBtn1.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        
        self.bottomBtn2.hidden=YES;
        self.bottomBtn3.hidden=YES;
        self.bottomBtn4.hidden=YES;
        self.bottomBtn5.hidden=YES;
        self.bottomBtn6.hidden=YES;
        self.bottomBtn7.hidden=YES;
        self.bottomBtn10.hidden=YES;
        self.bottomBtn1.hidden=NO;
        
    }
    if ([model.orderstatus isEqualToString:@"“已发货"]) {
        self.bottomBtn4.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        
        self.bottomBtn4.hidden=NO;
        self.bottomBtn2.frame=CGRectMake(viewW-(LeftMargin+btnW)*2,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn2.hidden=NO;
        self.bottomBtn1.frame=CGRectMake(viewW-(LeftMargin+btnW)*3,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn1.hidden=NO;
        
        
        self.bottomBtn3.hidden=YES;
        self.bottomBtn5.hidden=YES;
        self.bottomBtn6.hidden=YES;
        self.bottomBtn7.hidden=YES;
        self.bottomBtn10.hidden=YES;
        
    }
    if ([model.orderstatus isEqualToString:@"退款申请中"]) {
        self.bottomBtn1.frame=CGRectMake(viewW-(LeftMargin+btnW),viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn1.hidden=NO;
        self.bottomBtn2.hidden=YES;
        self.bottomBtn3.hidden=YES;
        self.bottomBtn4.hidden=YES;
        self.bottomBtn5.hidden=YES;
        self.bottomBtn6.hidden=YES;
        self.bottomBtn7.hidden=YES;
        self.bottomBtn10.hidden=YES;
        
    }
    if ([model.orderstatus isEqualToString:@"“退款审核通过"]) {
        self.bottomBtn6.frame=CGRectMake(viewW-LeftMargin-btnW,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        [self.bottomBtn6 setTitle:@"提交物流信息" forState:UIControlStateNormal];
        
        self.bottomBtn2.hidden=NO;
        self.bottomBtn1.frame=CGRectMake(viewW-(LeftMargin+btnW)*2,viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn1.hidden=NO;
        
        self.bottomBtn3.hidden=YES;
        self.bottomBtn4.hidden=YES;
        self.bottomBtn5.hidden=YES;
        self.bottomBtn6.hidden=YES;
        self.bottomBtn7.hidden=YES;
        self.bottomBtn10.hidden=YES;
        
    }
    if ([model.orderstatus isEqualToString:@"拒绝退款"]) {
        self.bottomBtn1.frame=CGRectMake(viewW-(LeftMargin+btnW),viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn1.hidden=NO;
        self.bottomBtn2.hidden=YES;
        self.bottomBtn3.hidden=YES;
        self.bottomBtn4.hidden=YES;
        self.bottomBtn5.hidden=YES;
        self.bottomBtn6.hidden=YES;
        self.bottomBtn7.hidden=YES;
        self.bottomBtn10.hidden=YES;
        
    }
    if ([model.orderstatus isEqualToString:@"退款中"]) {
        self.bottomBtn1.frame=CGRectMake(viewW-(LeftMargin+btnW),viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn1.hidden=NO;
        self.bottomBtn2.hidden=YES;
        self.bottomBtn3.hidden=YES;
        self.bottomBtn4.hidden=YES;
        self.bottomBtn5.hidden=YES;
        self.bottomBtn6.hidden=YES;
        self.bottomBtn7.hidden=YES;
        self.bottomBtn10.hidden=YES;
    }
    if ([model.orderstatus isEqualToString:@"退款完成"]) {
        self.bottomBtn1.frame=CGRectMake(viewW-(LeftMargin+btnW),viewH-FitRealValue(98)+(FitRealValue(98)-btnH)/2 , btnW, btnH);
        self.bottomBtn1.hidden=NO;
        self.bottomBtn2.hidden=YES;
        self.bottomBtn3.hidden=YES;
        self.bottomBtn4.hidden=YES;
        self.bottomBtn5.hidden=YES;
        self.bottomBtn6.hidden=YES;
        self.bottomBtn7.hidden=YES;
        self.bottomBtn10.hidden=YES;
    }
}
-(void)bottomBtnClick:(UIButton*)sender{
    
    if (sender.tag==100) {
        self.Block(@"查看订单");
    }
    if (sender.tag==200) {
        self.Block(@"查看物流");
    }
    if (sender.tag==300) {
        self.Block(@"确认收货");
    }
    if (sender.tag==400) {
        self.Block(@"去付款");
    }
    if (sender.tag==500) {
        self.Block(@"退款");
    }
    if (sender.tag==600) {
        self.Block(@"提交物流信息");
    }
    if (sender.tag==700) {
        self.Block(@"取消订单");
    }
    
}
@end
