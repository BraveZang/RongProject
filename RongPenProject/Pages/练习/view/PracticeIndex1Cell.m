//
//  PracticeIndex1Cell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/4.
//

#import "PracticeIndex1Cell.h"

@interface PracticeIndex1Cell()
@property (nonatomic,strong)UIImageView    *img;
@property (nonatomic,strong)UILabel        *titleLab;
@property (nonatomic,strong)UILabel        *Lab1;
@property (nonatomic,strong)UILabel        *Lab2;
@property (nonatomic,strong)UILabel        *Lab3;

@property (nonatomic,strong) UIProgressView        *progressView;

@end
@implementation PracticeIndex1Cell
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}
-(void)initView{
    float viewW=ScreenWidth-LeftMargin*2;
    float viewH=ScreenHeight-FitRealValue(80)*2-SafeAreaBottomHeight-SafeAreaTopHeight-49;
    float btnW=FitRealValue(320);
    float btnH=FitRealValue(80);
    float imgW=FitRealValue(290);
    float imgH=FitRealValue(408);
    
    
    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,viewW , viewH)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.cornerRadius=5;
    [self addSubview:bgView];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, FitRealValue(36), viewW, FitRealValue(44))];
    self.titleLab.font=[UIFont systemFontOfSize:22];
    self.titleLab.textColor=[MTool colorWithHexString:@"#212121"];
    self.titleLab.text=@"3500词英汉互译练习册";
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview: self.titleLab];
    
    
    self.img=[[UIImageView alloc]initWithFrame:CGRectMake((viewW-imgW)/2, self.titleLab.bottom+FitRealValue(30), imgW, imgH)];
    [self.img setImage:[UIImage imageNamed:@"bgimhaa"]];
    [bgView addSubview:self.img];
    
    self.Lab1=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,self.img.bottom+18, FitRealValue(120), FitRealValue(28))];
    self.Lab1.font=[UIFont systemFontOfSize:14];
    self.Lab1.textColor=[MTool colorWithHexString:@"#212121"];
    self.Lab1.text=@"完成进度";
    [bgView addSubview: self.Lab1];
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(self.Lab1.right+5, self.img.bottom+22,viewW-(self.Lab1.right+5)*2, 14)];
    //滑轮左边颜色，如果设置了左边的图片就不会显示
    _progressView.progressTintColor = [MTool colorWithHexString:@"#F65555"];
    //滑轮右边颜色，如果设置了左边的图片就不会显示
    _progressView.trackTintColor = [MTool colorWithHexString:@"#F1F1F1"];
    _progressView.progressViewStyle = UIProgressViewStyleBar;
    [bgView addSubview:self.progressView];
    
    self.Lab2=[[UILabel alloc]initWithFrame:CGRectMake(_progressView.right+5,self.img.bottom+18, FitRealValue(120), FitRealValue(28))];
    self.Lab2.font=[UIFont systemFontOfSize:14];
    self.Lab2.textColor=[MTool colorWithHexString:@"#F65555"];
    self.Lab2.text=@"56%";
    _progressView.progress = 0.56;
    [bgView addSubview: self.Lab2];
    
    self.Lab3=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,self.Lab1.bottom+15, FitRealValue(120), FitRealValue(28))];
    self.Lab3.font=[UIFont systemFontOfSize:14];
    self.Lab3.textColor=[MTool colorWithHexString:@"#212121"];
    self.Lab3.text=@"正确率:";
    [bgView addSubview: self.Lab3];
    
    UIButton*chakanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    chakanBtn.frame=CGRectMake((viewW-btnW)/2, viewH-50-btnH, btnW, btnH);
    [chakanBtn setBackgroundImage:[UIImage imageNamed:@"chakanBtn"] forState:UIControlStateNormal];
    [chakanBtn setTitle:@"开始练习" forState:UIControlStateNormal];
    chakanBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [chakanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgView addSubview: chakanBtn];
    [chakanBtn addTarget:self action:@selector(chakanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton*chakanBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    chakanBtn1.frame=CGRectMake(0, chakanBtn.bottom+5, viewW, btnH);
    [chakanBtn1 setTitle:@"查看书写详情" forState:UIControlStateNormal];
    chakanBtn1.titleLabel.font=[UIFont systemFontOfSize:16];
    [chakanBtn1 setTitleColor:[MTool colorWithHexString:@"#F65555"] forState:UIControlStateNormal];
    [bgView addSubview: chakanBtn1];
    chakanBtn1.titleLabel.font=[UIFont systemFontOfSize:14];
    [chakanBtn1 addTarget:self action:@selector(chakanBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)chakanBtnClick{
    [MTool showText:@"敬请期待" showTime:2];
}
@end
