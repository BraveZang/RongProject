//
//  ReadTestHeader.m
//  RongPenProject
//
//  Created by mac on 1.11.20.
//

#import "ReadTestHeader.h"

@interface ReadTestHeader()

@property (nonatomic, strong) UILabel           *UnitLab;
@property (nonatomic, strong) UILabel           *pageLab;
@property (nonatomic, strong) UILabel           *wordLab;


@end

@implementation ReadTestHeader
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.UnitLab=[[UILabel alloc]initWithFrame:CGRectMake(0, APP_HEIGHT_6S(15.0), KSCREEN_WIDTH, APP_HEIGHT_6S(20.0))];
    self.UnitLab.text=@"更换教材";
    self.UnitLab.font=[UIFont systemFontOfSize:APP_HEIGHT_6S(16.0)];
    self.UnitLab.textAlignment = NSTextAlignmentCenter;
    self.UnitLab.textColor=[MTool colorWithHexString:@"#212121"];
    [self addSubview:self.UnitLab];
    
    
    self.pageLab=[[UILabel alloc]initWithFrame:CGRectMake(0, APP_HEIGHT_6S(10.0) + self.UnitLab.bottom, KSCREEN_WIDTH, APP_HEIGHT_6S(15.0))];
    self.pageLab.text=@"英语三年级上册 · 第48页";
    self.pageLab.font=[UIFont systemFontOfSize:APP_HEIGHT_6S(12.0)];
    self.pageLab.textAlignment = NSTextAlignmentCenter;
    self.pageLab.textColor=[MTool colorWithHexString:@"#888888"];
    [self addSubview:self.pageLab];
    
    
    self.wordLab=[[UILabel alloc]initWithFrame:CGRectMake(0, APP_HEIGHT_6S(5.0) + self.pageLab.bottom, KSCREEN_WIDTH, APP_HEIGHT_6S(15.0))];
    self.wordLab.text=@"英语第48页";
    self.wordLab.font=[UIFont systemFontOfSize:APP_HEIGHT_6S(12.0)];
    self.wordLab.textAlignment = NSTextAlignmentCenter;
    self.wordLab.textColor=[MTool colorWithHexString:@"#888888"];
    [self addSubview:self.wordLab];
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
