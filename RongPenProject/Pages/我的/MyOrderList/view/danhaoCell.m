//
//  danhaoCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/1.
//

#import "danhaoCell.h"

@implementation danhaoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    self.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    return self;
}
-(void)initView{
    
    float viewW=ScreenWidth-10*2;
    float viewH=FitRealValue(260);
    
    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, viewW, viewH)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.cornerRadius=5;
    [self addSubview:bgView];
    
    UILabel*titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10,0, FitRealValue(400), FitRealValue(96))];
    titleLab.font=[UIFont systemFontOfSize:16];
    titleLab.textColor=[MTool colorWithHexString:@"#212121"];
    titleLab.text=@"输入快递单号：";
    [bgView addSubview:titleLab];
    
    UITextField*field=[[UITextField alloc]initWithFrame:CGRectMake(LeftMargin, titleLab.bottom, viewW-LeftMargin*2, FitRealValue(80))];
    field.delegate=self;
    field.backgroundColor=[MTool colorWithHexString:@"#ECECEC"];
    [bgView addSubview:field];
    
    UILabel*contentLab=[[UILabel alloc]initWithFrame:CGRectMake(10,field.bottom,viewW-20, FitRealValue(84))];
    contentLab.font=[UIFont systemFontOfSize:12];
    contentLab.textColor=[MTool colorWithHexString:@"#888888"];
    contentLab.text=@"注：快递单号与物品一致，否则按违规处理";
    [bgView addSubview:contentLab];
    
}
-(void) textFieldDidEndEditing:(UITextField *)textField

{ //获取输入的内容
    
    NSString *content = [textField text];
    self.textfieldStrBlock(content);
}
@end
