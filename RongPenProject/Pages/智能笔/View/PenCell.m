//
//  PenCell.m
//  RongPenProject
//
//  Created by mac on 8.11.20.
//

#import "PenCell.h"

@interface PenCell()

@property (nonatomic, strong) UIButton       *footerBtn;


@end
@implementation PenCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(void)createUI{
    self.titleLab = [[UILabel alloc] init];
    _titleLab.frame = CGRectMake(15,0,ScreenWidth-56-30,56);
    _titleLab.textColor = hexColor(212121);
    _titleLab.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLab];
    _titleLab.text = @"12:89:103:1231";
    
    self.footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _footerBtn.frame = CGRectMake(_titleLab.right, 18, 56, 24);
    _footerBtn.backgroundColor = hexColor(FF8181);
    [_footerBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [_footerBtn setBackgroundImage:[UIImage imageNamed:@"chakanBtn"] forState:UIControlStateNormal];
    [_footerBtn setTitle:@"连接" forState:UIControlStateNormal];
    _footerBtn.layer.cornerRadius = 4;
    [self.contentView addSubview:_footerBtn];

    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 55, ScreenWidth-15, 1)];
    lineView.backgroundColor = hexColor(E9E9E9);
    [self.contentView addSubview:lineView];

}


- (void)setPeriphera:(CBPeripheral *)periphera{
    _periphera = periphera;
    self.titleLab.text = periphera.name;
}

- (void)nextClick{
    if (self.connectPeripheraBlock) {
        self.connectPeripheraBlock(_periphera);
    }
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
