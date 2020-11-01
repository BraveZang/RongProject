//
//  CourseTimeCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/1.
//

#import "CourseTimeCell.h"

@implementation CourseTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 0, FitRealValue(500), FitRealValue(84))];
    self.nameLab.textColor=[MTool colorWithHexString:@"#121212"];
    self.nameLab.font=[UIFont systemFontOfSize:14];
    self.nameLab.text=@"录播课";
    [self addSubview: self.nameLab];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(ScreenWidth-LeftMargin-90,0, 90, FitRealValue(84));
    [self.selectBtn setImage:[UIImage imageNamed:@"quan_btn"] forState:UIControlStateNormal];
    [self.selectBtn addTarget:self action:@selector(defualbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectBtn];
    
}
-(void)defualbtnclick:(UIButton*)btn{
    
//    btn.selected = !btn.selected;
//    if (btn.selected==YES) {
//        [self.selectBtn setImage:[UIImage imageNamed:@"quan_btn_s"] forState:UIControlStateNormal];
//     
//    }
//    else{
//        [self.selectBtn setImage:[UIImage imageNamed:@"quan_btn"] forState:UIControlStateNormal];
//       
//    }
    self.Block();
    
}
@end
