//
//  MainFanKuiCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/9/22.
//

#import "MainFanKuiCell.h"

@implementation MainFanKuiCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    float viewW=ScreenWidth;
    float viewH=FitRealValue(110);
    float textViewH=FitRealValue(240);

    if (IS_IPAD) {
        viewH=viewH*2/3;
        textViewH=textViewH*2/3;

    }
    
    self.tagLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 0,14,viewH)];
    self.tagLab.font=[UIFont boldSystemFontOfSize:14];
    self.tagLab.textColor=[UIColor redColor];
    self.tagLab.text=@"*";
    self.tagLab.hidden=YES;
    [self addSubview:self.tagLab];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.tagLab.right, 0,viewW-LeftMargin,viewH)];
    self.titleLab.font=[UIFont boldSystemFontOfSize:14];
    self.titleLab.textColor=[MTool colorWithHexString:@"#212121"];
    [self addSubview:self.titleLab];
    
    self.sexView=[[UIView alloc]initWithFrame:CGRectMake(self.titleLab.right+FitRealValue(120), 0, viewW-(self.titleLab.right+FitRealValue(120)-60), viewH)];
    self.sexView.backgroundColor=[UIColor whiteColor];
    self.sexView.hidden=YES;
    [self addSubview:self.sexView];
    
    self.manBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.manBtn.frame=CGRectMake(0,0, 50, viewH);
    [self.manBtn setImage:[UIImage imageNamed:@"sex_s"] forState:UIControlStateNormal];
    [self.manBtn addTarget:self action:@selector(manbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.manBtn setTitle:@"  遇到问题" forState:UIControlStateNormal];
    [self.manBtn setTitleColor:[MTool colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    self.manBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [ self.sexView addSubview:self.manBtn];
    
    self.womanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.womanBtn.frame=CGRectMake(self.manBtn.right+20,0, 50, viewH);
    [self.womanBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [self.womanBtn addTarget:self action:@selector(womanbtnbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.womanBtn setTitle:@"  提出建议" forState:UIControlStateNormal];
    [self.womanBtn setTitleColor:[MTool colorWithHexString:@"666666"] forState:UIControlStateNormal];
    self.womanBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [ self.sexView addSubview:self.womanBtn];
    
    self.describeView=[[UITextView alloc]initWithFrame:CGRectMake(LeftMargin,  self.titleLab.bottom, ScreenWidth-LeftMargin*2, textViewH)];
    self.describeView.hidden=YES;
    self.describeView.backgroundColor=[MTool colorWithHexString:@"#F2F8FF"];
    self.describeView.font=[UIFont systemFontOfSize:14];
    self.describeView.delegate=self;
    [self addSubview:self.describeView];

}

@end
