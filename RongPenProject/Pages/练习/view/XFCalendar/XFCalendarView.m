//
//  XFCalendarItem.m
//  Calendar
//
//  Created by XiaoFeng on 2016/11/22.
//  Copyright © 2016年 XiaoFeng. All rights reserved.
//

#import "XFCalendarView.h"

@implementation XFCalendarView
{
    UIButton  *_selectButton;
    NSMutableArray *_daysArray;
    UILabel*datalab;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _daysArray = [NSMutableArray arrayWithCapacity:42];
        
        for (int i = 0; i < 42; i++) {
            UIButton *button = [[UIButton alloc] init];
            [self addSubview:button];
            [_daysArray addObject:button];
            
            UIView*topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-LeftMargin*2, 40)];
            topview.backgroundColor=[UIColor whiteColor];
            [self addSubview:topview];
            
            UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(10, 0, 20, 40);
            [btn setImage:[UIImage imageNamed:@"next2_2"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(setupRequestYear) forControlEvents:UIControlEventTouchUpInside];
            [topview addSubview:btn];
            
            UIButton*btn1=[UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame=CGRectMake(SCREEN_WIDTH-LeftMargin*2-20-20-20-20,0, 20, 40);
            [btn1 setImage:[UIImage imageNamed:@"next1"] forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(nextcilci1) forControlEvents:UIControlEventTouchUpInside];
            [topview addSubview:btn1];

            UIButton*btn2=[UIButton buttonWithType:UIButtonTypeCustom];
            btn2.frame=CGRectMake(50, 0, 20, 40);
            [btn2 setImage:[UIImage imageNamed:@"next1_1"] forState:UIControlStateNormal];
            [btn2 addTarget:self action:@selector(nextcilci) forControlEvents:UIControlEventTouchUpInside];
            [topview addSubview:btn2];

            UIButton*btn3=[UIButton buttonWithType:UIButtonTypeCustom];
            btn3.frame=CGRectMake(SCREEN_WIDTH-LeftMargin*2-20-20,0, 20, 40);
            [btn3 setImage:[UIImage imageNamed:@"next2"] forState:UIControlStateNormal];
            [btn3 addTarget:self action:@selector(setupRequestYear1) forControlEvents:UIControlEventTouchUpInside];
            [topview addSubview:btn3];
            
            datalab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-LeftMargin*2, 40)];
            datalab.textAlignment=NSTextAlignmentCenter;
            datalab.font=[UIFont systemFontOfSize:14];
            [topview addSubview:datalab];
        }
    }
    return self;
}
-(void)nextcilci{
    [self setupRequestMonth];
}
-(void)nextcilci1{
    [self setupRequestMonth1];
}
#pragma mark - create View
- (void)setDate:(NSDate *)date{
    _date = date;
    _currentDate=date;
    [self createCalendarViewWith:date];
    
}

- (void)createCalendarViewWith:(NSDate *)date{
    
    if (_currentDate==nil) {
        _currentDate = [NSDate date];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [formatter stringFromDate:_currentDate];
    NSLog(@"date str = %@", dateStr);
    datalab.text=dateStr;
    
    
    CGFloat itemW     = self.frame.size.width / 7;
    CGFloat itemH     = self.frame.size.width / 7;
    
    NSArray *array = @[@"日", @"一", @"2", @"3", @"四", @"五",@"六"];
    UIView *weekBg = [[UIView alloc] init];
    weekBg.backgroundColor = [UIColor whiteColor];
    weekBg.frame = CGRectMake(0, 40, self.frame.size.width, itemH);
    [self addSubview:weekBg];
    
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = array[i];
        week.font     = [UIFont systemFontOfSize:14];
        week.frame    = CGRectMake(itemW * i, 0, itemW, 32);
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
        week.textColor       = [UIColor blackColor];
        [weekBg addSubview:week];
    }
    
    //  3.days (1-31)
    for (int i = 0; i < 42; i++) {
        
        int x = (i % 7) * itemW ;
        int y = (i / 7) * itemH + CGRectGetMaxY(weekBg.frame);
        
        UIButton *dayButton = _daysArray[i];
        dayButton.frame = CGRectMake(x+5, y+5, itemW-10, itemH-10);
        dayButton.cornerRadius=(itemH-10)/2;
        dayButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.tag=i;
        [dayButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        dayButton.backgroundColor=[UIColor whiteColor];
        NSInteger daysInLastMonth = [XFCalendarTool totaldaysInMonth:[XFCalendarTool lastMonth:date]];
        NSInteger daysInThisMonth = [XFCalendarTool totaldaysInMonth:date];
        NSInteger firstWeekday    = [XFCalendarTool firstWeekdayInThisMonth:date];
        
        NSInteger day = 0;
        
        
        if (i < firstWeekday) {
            
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
            
            
        }else{
            day = i - firstWeekday + 1;
            [self setStyle_AfterToday:dayButton];
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];
        
        // this month
        //        if ([XFCalendarTool month:date] == [XFCalendarTool month:[NSDate date]]) {
        //
        //            NSInteger todayIndex = [XFCalendarTool day:date] + firstWeekday - 1;
        
        //            if (i < todayIndex && i >= firstWeekday) {
        
        //                [self setStyle_BeforeToday:dayButton];
        [self setSign:i - (int)firstWeekday + 1 andBtn:dayButton];
        
        //            }
        //                else if(i ==  todayIndex){
        //                [self setStyle_Today:dayButton];
        //                _dayButton = dayButton;
        //            }
        //        }
    }
}

-(void)setupRequestMonth
{
    if (_currentDate==nil) {
        _currentDate = [NSDate date];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:-1];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:_currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    NSLog(@"date str = %@", dateStr);
    datalab.text=dateStr;
    _currentDate=newdate;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_currentDate];
    //    self.calendarBlock(0,[comp month], [comp year]);
    if (self.calendarBlock1) {
        self.calendarBlock1([comp month], [comp year]);
    }
    [self createCalendarViewWith:newdate];
}
-(void)setupRequestMonth1
{
    if (_currentDate==nil) {
        _currentDate = [NSDate date];
    }
    NSDate*tady= [NSDate date];
    if (tady==_currentDate) {
        return;
    }
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:+1];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:_currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    NSLog(@"date str = %@", dateStr);
    datalab.text=dateStr;
    _currentDate=newdate;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_currentDate];
    //    self.calendarBlock(0,[comp month], [comp year]);
    if (self.calendarBlock1) {
        self.calendarBlock1([comp month], [comp year]);
    }
    [self createCalendarViewWith:newdate];
}
-(void)setupRequestYear
{
    if (_currentDate==nil) {
        _currentDate = [NSDate date];
    }
    NSDate*tady= [NSDate date];
    if (tady==_currentDate) {
        return;
    }
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setYear:-1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:_currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    NSLog(@"date str = %@", dateStr);
    datalab.text=dateStr;
    _currentDate=newdate;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_currentDate];
    //    self.calendarBlock(0,[comp month], [comp year]);
    if (self.calendarBlock1) {
        self.calendarBlock1([comp month], [comp year]);
    }
    [self createCalendarViewWith:newdate];
}

-(void)setupRequestYear1
{
    if (_currentDate==nil) {
        _currentDate = [NSDate date];
    }
    NSDate*tady= [NSDate date];
    if (tady==_currentDate) {
        return;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setYear:+1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:_currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    NSLog(@"date str = %@", dateStr);
    datalab.text=dateStr;
    _currentDate=newdate;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_currentDate];
    //    self.calendarBlock(0,[comp month], [comp year]);
    if (self.calendarBlock1) {
        self.calendarBlock1([comp month], [comp year]);
    }
    [self createCalendarViewWith:newdate];
}
#pragma mark 设置已经签到
- (void)setSign:(int)i andBtn:(UIButton*)dayButton{
    [_signArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int now = i;
        int now2 = [obj intValue];
        if (now2== now) {
            [self setStyle_SignEd:dayButton];
        }
    }];
}

-(void)setSignArray:(NSMutableArray *)signArray{
    _signArray=signArray;
    [self createCalendarViewWith:_currentDate];
}
#pragma mark - output date
-(void)logDate:(UIButton *)dayBtn
{
//    _selectButton.selected = NO;
//    [self  setStyle_Today_Signed:dayBtn];
//    dayBtn.selected = YES;
//    _selectButton = dayBtn;
//
//    NSInteger day = [[dayBtn titleForState:UIControlStateNormal] integerValue];
//
//    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
//
//    if (self.calendarBlock) {
//        self.calendarBlock(day, [comp month], [comp year]);
//    }
    
    for (id obj in self.subviews){
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton* theButton = (UIButton*)obj;
            if (theButton.tag==dayBtn.tag) {
                [self  setStyle_Today_Signed:theButton];
            }
            else{
                [self  setStyle_AfterToday:theButton ];
            }
           }}
}


#pragma mark - date button style
//设置不是本月的日期字体颜色   ---白色  看不到
- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    
}

//这个月 今日之前的日期style
- (void)setStyle_BeforeToday:(UIButton *)btn

{
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

//今日已签到
- (void)setStyle_Today_Signed:(UIButton *)btn
{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[MTool colorWithHexString:@"#FF8181"]];
}

//今日没签到
- (void)setStyle_Today:(UIButton *)btn
{
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
}

//这个月 今天之后的日期style
- (void)setStyle_AfterToday:(UIButton *)btn
{
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];

}


//已经签过的 日期style
- (void)setStyle_SignEd:(UIButton *)btn
{
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
}

@end
