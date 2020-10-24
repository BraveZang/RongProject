//
//  ZRInfoPickerView.m
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import "ZRInfoPickerView.h"
@interface ZRInfoPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView      *pickerView;
@property (nonatomic, strong) NSArray           *dataSouce;

@property (nonatomic, strong) NSString          *selectedStr;

@end

@implementation ZRInfoPickerView


- (instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray *)dataArray;
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.dataSouce = dataArray;
        [self creatViewWithFrame:frame];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatViewWithFrame:frame];
    }
    return self;
}

- (void)updateDataArray:(NSArray *)dataArray{
    self.dataSouce = dataArray;
    
    self.selectedStr = _dataSouce[0];
    
    [self.pickerView reloadAllComponents];
}

- (void)showZRInfoPickerView{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.8 animations:^{
        self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    });
   
}
- (void)hiddenZRInfoPickerView{
    self.backgroundColor = [UIColor clearColor];

    [UIView animateWithDuration:0.8 animations:^{
        self.frame = CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT);
    }];
    

}

- (void)keyboardHide:(UITapGestureRecognizer*)tap{
    self.backgroundColor = [UIColor clearColor];

    [UIView animateWithDuration:0.8 animations:^{
        self.frame = CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT);
    }];
}


- (void)creatViewWithFrame:(CGRect )frame{
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];

    [self addGestureRecognizer:tapGestureRecognizer];
    
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - 220, KSCREEN_WIDTH, 220)];
    bg.backgroundColor = [UIColor whiteColor];
    [self addSubview:bg];

   
    
    //完成
    UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame = CGRectMake(KSCREEN_WIDTH - 80, 0, 60, 39);
    [finishBtn addTarget:self action:@selector(finishBtnClicked)
        forControlEvents:UIControlEventTouchUpInside];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor colorWithHexColorString:@"4A90E2"] forState:UIControlStateNormal];
    [bg addSubview:finishBtn];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, finishBtn.bottom, KSCREEN_WIDTH, 1)];
    lineView2.backgroundColor =  [UIColor colorWithHexColorString:@"E9E9E9"];
    [bg addSubview:lineView2];
    
    
    
    self.pickerView.frame = CGRectMake(0, 40, KSCREEN_WIDTH, 40+30*6);
    
//    [self.durationPickerselectRow:0inComponent:0animated:YES];//每次显示picker的时候都选中第一行
    [bg addSubview:self.pickerView];

//    [self.pickerView selectRow:_dataSouce.count/2 inComponent:0 animated:YES];
    
    
}

- (void)finishBtnClicked{
    
    if (self.didSelectRowBlock) {
        self.didSelectRowBlock(_selectedStr);
    }
    
    [self hiddenZRInfoPickerView];
}


#pragma mark - lazy loading

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        //        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
    
}



#pragma mark - dataSouce
//有几行
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
//行中有几列
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSouce.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

//列显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    return self.dataSouce[row];
}

#pragma mark - delegate
// 选中某一组的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectedStr = self.dataSouce[row];
   
    
    
}


@end
