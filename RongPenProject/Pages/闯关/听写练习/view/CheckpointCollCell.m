//
//  CheckpointCollCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/5.
//

#import "CheckpointCollCell.h"
#import "UIButton+Code.h"
@interface CheckpointCollCell()<UITextFieldDelegate>

@property (nonatomic,strong)UIImageView    *img;
@property (nonatomic,strong)UILabel        *titleLab;
@property (nonatomic,strong)UIView         *bgView;

@property (nonatomic,strong)UILabel        *Lab1;
@property (nonatomic,strong)UILabel        *Lab2;
@property (nonatomic,strong)UILabel        *Lab3;

@property (nonatomic,strong)UIImageView    *labImg;

@property (nonatomic,strong)UIImageView    *bgImg;
@property (nonatomic,strong)UIButton       *timeBtn;

@property (nonatomic,strong)NSArray         *ary;


@end
@implementation CheckpointCollCell

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}
-(void)initView{
    
    float viewW=ScreenWidth-20;
    float viewH=FitRealValue(910);
    self.bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    [self.bgImg setImage:[UIImage imageNamed:@"answerBG"]];
    [self addSubview:self.bgImg];
    
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,viewW,viewH)];
    self.bgView.backgroundColor=[UIColor clearColor];
    [self addSubview:self.bgView];
    
    self.labImg=[[UIImageView alloc]init];
    
    
    self.Lab3=[[UILabel alloc]initWithFrame:CGRectMake(20, 0,viewW-40 , 0)];
    self.Lab3.font=[UIFont systemFontOfSize:20];
    self.Lab3.numberOfLines=0;
    self.Lab3.textColor=[MTool colorWithHexString:@"#9A4304"];
    [self addSubview: self.Lab3];
    
}
-(void)setModel:(AnswerModel *)model{
    float viewW=ScreenWidth-20;
    _model=model;
    NSString*str=model.en;
    [self.bgView removeAllSubviews];
    
    self.ary= [str componentsSeparatedByString:@" "];
    
    for (int i = 0; i < self.ary.count; i ++)
    {
        model.hsaRead=YES;
        NSString *name = self.ary[i];
        
        static UITextField *recordfield =nil;
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(20, 70, 0, 0)];
        field.enabled=NO;
        field.font = [UIFont systemFontOfSize:26];
        CGRect rect = [name boundingRectWithSize:CGSizeMake(viewW -40, 50) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:field.font} context:nil];
        
        CGFloat BtnW = rect.size.width;
        CGFloat BtnH = 50;
        if ([name isEqualToString:@""]) {
            BtnW=0;
            BtnH=0;
        }
        if ([name isEqualToString:@"_"]) {
            BtnW=50;
            BtnH=50;
        }
        
        if (i == 0)
        {
            field.frame =CGRectMake(20, 70, BtnW, BtnH);
            
        }else{
            
            CGFloat yuWidth = viewW - 30 -recordfield.right;
            
            if (yuWidth >= BtnW) {
                
                field.frame =CGRectMake(recordfield.right+10, recordfield.frame.origin.y, BtnW, BtnH);
            }else{
                
                field.frame =CGRectMake(20, recordfield.frame.origin.y+recordfield.frame.size.height+10, BtnW, BtnH);
            }
            
        }
        field .text=name;
        if ([name isEqualToString:@"_"]) {
            field.text=@"";
            field.backgroundColor=[MTool colorWithHexString:@"#F9BBA3"];
            field.textAlignment=NSTextAlignmentCenter;
            
            UIButton*timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [timeBtn setBackgroundColor:[UIColor redColor]];
            [timeBtn addTarget:self action:@selector(timeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [timeBtn setTitleColor:[MTool colorWithHexString:@"#9A4304"] forState:UIControlStateNormal];
            timeBtn.titleLabel.font=[UIFont boldSystemFontOfSize:26];
            timeBtn.layer.borderWidth=2;
            timeBtn.layer.borderColor=[UIColor whiteColor].CGColor;
            timeBtn.tag=i+100;
            timeBtn.frame=CGRectMake(field.origin.x, field.origin.y, 50, 50);
            [self.bgView addSubview:timeBtn];
            
            UIImageView*labImg=[[UIImageView alloc]init];
            labImg.frame=CGRectMake(field.right-22, field.origin.y+22, 20, 20);
            labImg.tag=i+100;
            [field addSubview:labImg];
        }
        field.textColor=[MTool colorWithHexString:@"#9A4304"];
        [self.bgView addSubview:field];
        
        recordfield = field;
        
        field.tag = i;
        self.Lab3.frame=CGRectMake(20, recordfield.bottom+10, viewW-40, 60);
        self.Lab3.text=model.zh;
    }
}

- (NSMutableArray*)calculateSubStringCount:(NSString *)content str:(NSString *)tab {
    int location = 0;
    NSMutableArray *locationArr = [NSMutableArray new];
    NSRange range = [content rangeOfString:tab];
    if (range.location == NSNotFound){
        return locationArr;
    }
    //声明一个临时字符串,记录截取之后的字符串
    NSString * subStr = content;
    while (range.location != NSNotFound) {
        if (location == 0) {
            location += range.location;
        } else {
            location += range.location + tab.length;
        }
        //记录位置
        NSNumber *number = [NSNumber numberWithUnsignedInteger:location];
        [locationArr addObject:number];
        //每次记录之后,把找到的字串截取掉
        subStr = [subStr substringFromIndex:range.location + range.length];
        NSLog(@"subStr %@",subStr);
        range = [subStr rangeOfString:tab];
        NSLog(@"rang %@",NSStringFromRange(range));
    }
    return locationArr;
    
}
-(void)timeBtnClick:(UIButton*)sender{
    
        [sender setCountdown:10 WithStartString:@"" WithEndString:@""];
//        sender.Block = ^{
    //
    //     sender.borderColor=[UIColor redColor];
    //        [self.labImg setImage:[UIImage imageNamed:@"worrong_img"]];
    //
    //        //        self.timeBtn.borderColor=[UIColor greenColor];
    //        //        [self.labImg setImage:[UIImage imageNamed:@"right_img"]];
   
    
    for (UIImageView *v in [self subviews]) {
        if ([v class] == [UIImageView class]||(v.tag==(sender.tag-100))){
            
             [v setImage:[UIImage imageNamed:@"right_img"]];
        }
        
        if ([v isKindOfClass:[UIButton class]] ||(v.tag==(sender.tag-100))) {
            v.borderColor=[UIColor greenColor];
        }
    }
//                 };
    
}
@end
