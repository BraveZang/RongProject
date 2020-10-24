//
//  MainInfoCell.m
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import "MainInfoCell.h"
@interface MainInfoCell()

@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UITextField   *contentTextField;
@property (nonatomic, strong) UILabel       *alertLabel;

@end

@implementation MainInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self CreatCell];
    }
    return self;
}


- (void)CreatCell{
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH_6S(20.0), APP_HEIGHT_6S(18.0), APP_WIDTH_6S(80.0), APP_HEIGHT_6S(20.0))];
    _titleLabel.textColor = [UIColor colorWithHexColorString:@"212121"];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:APP_HEIGHT_6S(16.0)];
    [self.contentView addSubview:_titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.right, APP_HEIGHT_6S(18.0), APP_WIDTH_6S(100.0), APP_HEIGHT_6S(20.0))];
    _contentLabel.textColor = [UIColor colorWithHexColorString:@"212121"];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.font = [UIFont systemFontOfSize:APP_HEIGHT_6S(16.0)];
    [self.contentView addSubview:_contentLabel];
    
    self.contentTextField = [[UITextField alloc] initWithFrame:CGRectMake(_titleLabel.right, APP_HEIGHT_6S(18.0), APP_WIDTH_6S(100.0), APP_HEIGHT_6S(20.0))];
    _contentTextField.textColor = [UIColor colorWithHexColorString:@"212121"];
    _contentTextField.textAlignment = NSTextAlignmentLeft;
    _contentTextField.font = [UIFont systemFontOfSize:APP_HEIGHT_6S(16.0)];
    _contentTextField.hidden = YES;
    [self.contentView addSubview:_contentTextField];
    
    
    self.alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(_contentLabel.right, APP_HEIGHT_6S(18.0), KSCREEN_WIDTH - 30 -APP_WIDTH_6S(200.0), APP_HEIGHT_6S(20.0))];
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
    _alertLabel.text = model.alert;
    
    
    if ([model.title isEqualToString:@"昵称"]) {
        self.contentTextField.hidden = NO;
        self.contentLabel.hidden = YES;
        self.contentTextField.text = model.content;
    }else{
        self.contentTextField.hidden = YES;
        self.contentLabel.hidden = NO;
        _contentLabel.text = model.content;
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
