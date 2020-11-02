//
//  ReadTestCell.m
//  RongPenProject
//
//  Created by mac on 1.11.20.
//

#import "ReadTestCell.h"

@interface ReadTestCell()

@property (nonatomic, strong) UILabel           *ELab;
@property (nonatomic, strong) UILabel           *CLab;
@property (nonatomic, strong) UIButton          *playBtn;


@end

@implementation ReadTestCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    
    
    self.ELab=[[UILabel alloc]initWithFrame:CGRectMake(APP_WIDTH_6S(15.0), APP_HEIGHT_6S(15.0),APP_WIDTH_6S(200.0),APP_HEIGHT_6S(25.0))];
    self.ELab.font=[UIFont systemFontOfSize:APP_HEIGHT_6S(20.0)];
    self.ELab.textColor=[MTool colorWithHexString:@"#D12E2E"];
    [self addSubview:self.ELab];
    
    self.CLab=[[UILabel alloc]initWithFrame:CGRectMake(APP_WIDTH_6S(15.0), APP_HEIGHT_6S(8.0) + _ELab.bottom,APP_WIDTH_6S(200.0),APP_HEIGHT_6S(20.0))];
    self.CLab.font=[UIFont systemFontOfSize:APP_HEIGHT_6S(14.0)];
    self.CLab.textColor=[MTool colorWithHexString:@"#666666"];
    [self addSubview:self.CLab];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_playBtn setImage:[UIImage imageNamed:@"trumpet"] forState:UIControlStateNormal];
    _playBtn.frame = CGRectMake(APP_WIDTH_6S(335.0), APP_HEIGHT_6S(15.0), APP_HEIGHT_6S(25.0), APP_HEIGHT_6S(25.0));
    [self addSubview:_playBtn];
    
    UILabel * lab =[[UILabel alloc]initWithFrame:CGRectMake(APP_WIDTH_6S(310.0), APP_HEIGHT_6S(8.0) + _playBtn.bottom,APP_WIDTH_6S(50.0),APP_HEIGHT_6S(20.0))];
    lab.font=[UIFont systemFontOfSize:APP_HEIGHT_6S(14.0)];
    lab.textAlignment = NSTextAlignmentRight;
    lab.textColor=[MTool colorWithHexString:@"#666666"];
    lab.text = @"发音";
    [self addSubview:lab];
    
    
}

- (void)setModel:(TestModel *)model{
    self.ELab.text = model.word;
    self.CLab.text = model.fanyi;
}


- (void)playBtnClick{
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
