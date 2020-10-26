//
//  MainInfoHeadCell.m
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import "MainInfoHeadCell.h"

@interface MainInfoHeadCell()

@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) UILabel           *alertLabel;


@end
@implementation MainInfoHeadCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self creatCell];
    }
    return self;
    
}

- (void)creatCell{
            
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH_6S(20.0), APP_HEIGHT_6S(18.0), APP_WIDTH_6S(80.0), APP_HEIGHT_6S(20.0))];
        _titleLabel.textColor = hexColor(2E2F31);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"头像";
        _titleLabel.font = [UIFont systemFontOfSize:APP_HEIGHT_6S(16.0)];
        [self.contentView addSubview:_titleLabel];
        
        //头像
        self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH_6S(305.0), APP_HEIGHT_6S(9.0), APP_HEIGHT_6S(32.0), APP_HEIGHT_6S(32.0))];
        _headView.image = [UIImage imageNamed:@"RR_defaultHead"];
        _headView.cornerRadius = APP_HEIGHT_6S(16.0);
        [self.contentView addSubview:_headView];
        
        self.alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headView.right, APP_HEIGHT_6S(18.0), KSCREEN_WIDTH - 30 -APP_WIDTH_6S(132.0), APP_HEIGHT_6S(20.0))];
        _alertLabel.textColor = [UIColor colorWithHexColorString:@"C1C1C1"];
        _alertLabel.textAlignment = NSTextAlignmentRight;
        _alertLabel.font = [UIFont systemFontOfSize:APP_HEIGHT_6S(14.0)];
        [self.contentView addSubview:_alertLabel];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_HEIGHT_6S(50.0)-1, KSCREEN_WIDTH, 1)];
        lineView.backgroundColor = [UIColor colorWithHexColorString:@"E9E9E9"];
        [self.contentView addSubview:lineView];
        
}

- (void)setModel:(InfoModel *)model{
    
    _titleLabel.text = model.title;
    [_headView sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
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
