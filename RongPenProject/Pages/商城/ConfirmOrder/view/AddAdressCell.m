//
//  AddAdressCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/17.
//

#import "AddAdressCell.h"

@implementation AddAdressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView{
    self.btnAry=[NSMutableArray arrayWithCapacity:0];
    self.phoneTF=[[UITextField alloc]initWithFrame:CGRectMake(180*SCREEN_WIDTH/750, 0, 380*SCREEN_WIDTH/750, 84*SCREEN_WIDTH/750)];
    self.phoneTF.textColor=[MTool colorWithHexString:@"333333"];
    self.phoneTF.font=[UIFont systemFontOfSize:14];
    self.phoneTF.delegate=self;
    [self addSubview:self.phoneTF];
    
    self.addressTV=[[UITextView alloc]initWithFrame:CGRectMake(180*SCREEN_WIDTH/750, 6*SCREEN_WIDTH/750, 515*SCREEN_WIDTH/750,  150*SCREEN_WIDTH/750)];
    self.addressTV.textColor=[MTool colorWithHexString:@"333333"];
    self.addressTV.font=[UIFont systemFontOfSize:14];
    self.addressTV.selectedRange=NSMakeRange(0,0) ;//光标起始位置
    //    self.addressTV.text=NSLocalizedString(@"街道/门牌号等", nil);//提示语
    self.addressTV.delegate=self;
    [self addSubview:self.addressTV];
    self.addressTV.hidden=YES;
    
    self.titleLab=[MTool quickCreateLabelWithleft:30*SCREEN_WIDTH/750 top:26*SCREEN_WIDTH/750 width:136*SCREEN_WIDTH/750 heigh:110*SCREEN_WIDTH/750 title:@"详细地址\n街道门牌号"];
    self.titleLab.font=[UIFont systemFontOfSize:14];
    self.titleLab.hidden=YES;
    [self addSubview:self.titleLab];
    
    self.adressbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.adressbtn.backgroundColor=[UIColor clearColor];
    self.adressbtn.frame=CGRectMake(180*SCREEN_WIDTH/750, 0, 380*SCREEN_WIDTH/750, 84*SCREEN_WIDTH/750);
    [self.adressbtn addTarget:self action:@selector(adressbtnclick) forControlEvents:UIControlEventTouchUpInside];
    self.adressbtn.hidden=YES;
    [self addSubview: self.adressbtn];
    
    self.swi = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-(60+60)*SCREEN_WIDTH/750, (156-60)/2*SCREEN_WIDTH/750, 60*SCREEN_WIDTH/750, 40*SCREEN_WIDTH/750)];
    self.swi.cornerRadius=15;
    // 设置控件开启状态填充色
    self.swi.onTintColor = [MTool colorWithHexString:@"4eb5b4"];
    // 设置控件关闭状态填充色
    self.swi.tintColor = [MTool colorWithHexString:@"edeff2"];
    self.swi.backgroundColor=[MTool colorWithHexString:@"eeeeee"];
    // 设置控件开关按钮颜色
    [self.swi addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventValueChanged];
    self.swi.thumbTintColor = [UIColor whiteColor];
    self.swi.hidden=YES;
    [self addSubview:self.swi];
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    //获取输入的内容
    
    NSString *content = [textView text];
    self.textfieldStrBlock(content);
}
-(void) textFieldDidEndEditing:(UITextField *)textField

{ //获取输入的内容
    
    NSString *content = [textField text];
    self.textfieldStrBlock(content);
}
-(void)adressbtnclick{
    
    self.textfieldStrBlock(@"");
    
}
-(void)biaoqianclick:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected==YES) {
        NSLog(@"点击了%@", sender.titleLabel.text);
        self.textfieldStrBlock(sender.titleLabel.text);
    }
    
    for (NSInteger j = 0; j < [self.btnAry count]; j++) {
        UIButton *btn = self.btnAry[j] ;
        if (sender.tag == j) {
            btn.selected = sender.selected;
            btn.backgroundColor = [MTool colorWithHexString:@"4eb5b4"];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.borderWidth=0;
            
        } else {
            btn.selected = NO;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[MTool colorWithHexString:@"666666" ] forState:UIControlStateNormal];
            
            btn.layer.borderWidth=1;
            
        }
    }
    
}
-(void)changeColor:(UISwitch *)swi{
    if(swi.isOn){
        self.textfieldStrBlock(@"on");
    }else{
        self.textfieldStrBlock(@"off");
        
    }
}
-(void)setModel:(AddressModel *)model{
    _model=model;
    if ([model.isdefault intValue]==0) {
        self.swi.on=NO;
    }
    else{
        self.swi.on=YES;
    }
}

@end
