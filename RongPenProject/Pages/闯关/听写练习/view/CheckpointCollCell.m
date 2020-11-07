//
//  CheckpointCollCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/5.
//

#import "CheckpointCollCell.h"

@interface CheckpointCollCell()<UITextFieldDelegate>

@property (nonatomic,strong)UIImageView    *img;
@property (nonatomic,strong)UILabel        *titleLab;
@property (nonatomic,strong)UIView         *bgView;

@property (nonatomic,strong)UILabel        *Lab1;
@property (nonatomic,strong)UILabel        *Lab2;
@property (nonatomic,strong)UILabel        *Lab3;

@property (nonatomic,strong)UIImageView    *bgImg;

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
               field.enabled=YES;
               field.textAlignment=NSTextAlignmentCenter;
               field.borderWidth=2;
               field.borderColor=[UIColor whiteColor];
               uii
           }
           field.textColor=[MTool colorWithHexString:@"#9A4304"];
           [self.bgView addSubview:field];
           
           recordfield = field;
           
           field.tag = i;
           
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

@end
