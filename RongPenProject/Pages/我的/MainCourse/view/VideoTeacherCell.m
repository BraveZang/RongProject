//
//  VideoTeacherCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import "VideoTeacherCell.h"

@implementation VideoTeacherCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    float viewH=FitRealValue(280);
    float ImgH=FitRealValue(80);
    if (IS_IPAD) {
        ImgH=ImgH/2;
    }
    self.heardImg=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin,10, ImgH, ImgH)];
    self.heardImg.layer.cornerRadius=ImgH/2;
    self.heardImg.layer.masksToBounds=YES;
    [self addSubview:self.heardImg];
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+5, 10, 300, ImgH/2)];
    self.nameLab.font=[UIFont systemFontOfSize:14];
    self.nameLab.text=@"名字";
    [self addSubview:self.nameLab];
    
    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(self.heardImg.right+5, self.nameLab.bottom, ScreenWidth-(self.heardImg.right+5)-LeftMargin, ImgH/2)];
    self.contentLab.numberOfLines=0;
    self.contentLab.textColor=[MTool colorWithHexString:@"#666666"];
    self.contentLab.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.contentLab];
    
}

-(void)setModel:(TeacherInfoModel *)model{
    
    [self.heardImg sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.nameLab.text=model.tname;
    
    CGFloat height = [model.info heightWithText:model.info font:[UIFont systemFontOfSize:14] width:ScreenWidth-(self.heardImg.right+5)-LeftMargin];
    self.contentLab.frame=CGRectMake(self.heardImg.right+5, self.nameLab.bottom, ScreenWidth-(self.heardImg.right+5)-LeftMargin,height);
    model.cellH=self.contentLab.bottom+10;
    self.contentLab.text=model.info;
}
@end
