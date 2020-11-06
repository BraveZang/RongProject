//
//  CheckpointCollCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/5.
//

#import "CheckpointCollCell.h"
#import <QuestionInputUI/QuestionInputUI.h>

@interface CheckpointCollCell()<UITextFieldDelegate>

@property (nonatomic,strong)UIImageView    *img;
@property (nonatomic,strong)UILabel        *titleLab;
@property (nonatomic,strong)UILabel        *Lab1;
@property (nonatomic,strong)UILabel        *Lab2;
@property (nonatomic,strong)UIImageView    *bgImg;

@property (nonatomic,strong)NSArray         *ary;
@property (nonatomic,strong)InputQuestionContentView *questionView;


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
    
}
-(void)setModel:(AnswerModel *)model{
    
    _model=model;
    NSString*str=model.en;
//    self.ary=[self calculateSubStringCount:str str:@"_"];
//    [self setUI];

    self.ary= [str componentsSeparatedByString:@" "];

        for (int i = 0; i < self.ary.count; i ++)
       {
           
           NSString *name = self.ary[i];
           
           static UITextField *recordfield =nil;
           UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(20, 60, 0, 0)];
           field.font = [UIFont systemFontOfSize:26];
           CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:field.font} context:nil];
           
           CGFloat BtnW = rect.size.width+10 ;
           CGFloat BtnH = rect.size.height+10;
           if ([name isEqualToString:@""]) {
               BtnW=0;
               BtnH=0;
           }
           
           if (i == 0)
           {
               field.frame =CGRectMake(30, 70, BtnW, BtnH);
               
           }else{
               
               CGFloat yuWidth = self.frame.size.width - 30 -recordfield.frame.origin.x -recordfield.frame.size.width;
               
               if (yuWidth >= rect.size.width) {
                   
                   field.frame =CGRectMake(recordfield.frame.origin.x +recordfield.frame.size.width + 10, recordfield.frame.origin.y, BtnW, BtnH);
               }else{
                   
                   field.frame =CGRectMake(30, recordfield.frame.origin.y+recordfield.frame.size.height+10, BtnW, BtnH);
               }
               
           }
           field .text=name;
           if ([name isEqualToString:@"_"]) {
               field.text=@"";
               field.backgroundColor=[MTool colorWithHexString:@"#F9BBA3"];
               field.frame=CGRectMake(field.origin.x+BtnW, field.origin.y, 50, 50);
           }
           field.textColor=[MTool colorWithHexString:@"#9A4304"];
           [self addSubview:field];
           
//           self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width,CGRectGetMaxY(field.frame)+10);
           recordfield = field;
           field.tag = i;
           
           
//         }  [field addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
       
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
-(void)setUI{
    
    float viewW=ScreenWidth-20;
    NSMutableArray*inputLocationAry=[NSMutableArray arrayWithCapacity:0];
    for (NSString*str in self.ary) {
        NSInteger location=[str intValue];
        InputLocationInfoObject*obj=[[InputLocationInfoObject alloc] initWithInputSize:CGSizeMake(70.0f, 30.0f) locationIndex:location];
        [inputLocationAry addObject:obj];
    }
    NSString *string = [self.model.en stringByReplacingOccurrencesOfString:@"_" withString:@""];
    if ( self.questionView==nil) {
    self.questionView = [[InputQuestionContentView alloc]initWithStartPoint:CGPointMake(40.0f, 70.0f) contentWidth:viewW - 80.0f text:string font:[UIFont boldSystemFontOfSize:26.0f] textColor:[MTool colorWithHexString:@"#9A4304"] lineGap:4.0f wordGap:1.0f inputLocations:inputLocationAry];
    [self addSubview:self.questionView];
    }
    
    
}
@end
