//
//  PracticeIndexCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/3.
//

#import "PracticeIndexCell.h"
#import "XFCalendarView.h"


@interface PracticeIndexCell()
@property (nonatomic,strong)UIImageView    *img;
@property (nonatomic,strong)UILabel        *titleLab;
@property (nonatomic,strong)UILabel        *Lab1;
@property (nonatomic,strong)UILabel        *Lab2;
@property (nonatomic,strong)XFCalendarView *calendarView;

@end
@implementation PracticeIndexCell

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

    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,viewW , viewH)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.cornerRadius=5;
    [self addSubview:bgView];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, FitRealValue(36), viewW, FitRealValue(44))];
    self.titleLab.font=[UIFont systemFontOfSize:22];
    self.titleLab.textColor=[MTool colorWithHexString:@"#212121"];
    self.titleLab.text=@"学习记录";
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview: self.titleLab];

    _calendarView = [[XFCalendarView alloc] init];
    _calendarView.frame = CGRectMake(10,self.titleLab.bottom+FitRealValue(40),viewW-20, 310);
    [bgView addSubview:_calendarView];
    
    //设置已经签到的天数日期
    NSMutableArray* _signArray = [[NSMutableArray alloc] init];
    [_signArray addObject:[NSNumber numberWithInt:1]];
    [_signArray addObject:[NSNumber numberWithInt:2]];
    [_signArray addObject:[NSNumber numberWithInt:3]];
    //    [_signArray addObject:[NSNumber numberWithInt:7]];
    //     [_signArray addObject:[NSNumber numberWithInt:14]];
    //    _calendarView.signArray = _signArray;
    
    
    _calendarView.date = [NSDate date];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    //        self.mothstr=[NSString stringWithFormat:@"%ld",(long)[comp month]];
    //        self.yearstr=[NSString stringWithFormat:@"%ld",(long)[comp year]];
    
    
    
    //1.点击日历数字事件
    //日期点击事件
    __weak __typeof(self) weakSelf = self;
    _calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        if ([comp day]==day) {
            //根据自己逻辑条件 设置今日已经签到的style 没有签到不需要写
            //                [weakSelf changStatus];
            [weakSelf.calendarView setStyle_Today_Signed:weakSelf.calendarView.dayButton];

        }
        else{
           [weakSelf.calendarView setStyle_Today:weakSelf.calendarView.dayButton];

        }
    };
    _calendarView.calendarBlock1 = ^(NSInteger month, NSInteger year) {
        [weakSelf.calendarView setStyle_Today_Signed:weakSelf.calendarView.dayButton];
        //            self.mothstr=[NSString stringWithFormat:@"%ld",(long)month];
        //            self.yearstr=[NSString stringWithFormat:@"%ld",(long)year];
        //            [self Geturl1003];
        
        
    };
    
    self.Lab1=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,_calendarView.bottom+5, viewW, FitRealValue(24))];
    self.Lab1.font=[UIFont systemFontOfSize:12];
    self.Lab1.textColor=[MTool colorWithHexString:@"#888888"];
    self.Lab1.text=@"总练习次数：";
    [bgView addSubview: self.Lab1];
    
    self.Lab2=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,self.Lab1.bottom+10, viewW, FitRealValue(24))];
    self.Lab2.font=[UIFont systemFontOfSize:12];
    self.Lab2.textColor=[MTool colorWithHexString:@"#888888"];
    self.Lab2.text=@"最高连续学习天数：";
    [bgView addSubview: self.Lab2];
    
    UIButton*chakanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    chakanBtn.frame=CGRectMake((viewW-btnW)/2, viewH-10-btnH, btnW, btnH);
    [chakanBtn setBackgroundImage:[UIImage imageNamed:@"chakanBtn"] forState:UIControlStateNormal];
    [chakanBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    chakanBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [chakanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgView addSubview: chakanBtn];
    [chakanBtn addTarget:self action:@selector(chakanBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)chakanBtnClick{
    [MTool showText:@"敬请期待" showTime:2];
}
@end
