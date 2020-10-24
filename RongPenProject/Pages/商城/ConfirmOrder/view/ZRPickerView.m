//
//  ZRPickerView.m
//  ZRPickerView
//
//  Created by mac on 21/06/2019.
//  Copyright © 2019 ZrteC. All rights reserved.
//

#import "ZRPickerView.h"
@interface ZRPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView      *pickerView;
@property (nonatomic, strong) NSArray           *dataSouce;

@property (nonatomic, assign) NSInteger         proIndex;

@property (nonatomic, strong) AreaModel          *currentProvinceModel;
@property (nonatomic, strong) AreaModel          *currentCityModel;
@property (nonatomic, strong) AreaModel          *currentAreaModel;



@end

@implementation ZRPickerView


- (instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray *)dataArray;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSouce = dataArray;
        [self creatViewWithFrame:frame];
    }
    return self;
}


- (void)setPickerRow:(NSInteger)pickerRow{
    _pickerRow = pickerRow;
    [self.pickerView reloadAllComponents];

}


- (void)creatViewWithFrame:(CGRect )frame{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor =  [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [self addSubview:lineView];
    
    //完成
    UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 1, 60, 38);
    [finishBtn addTarget:self action:@selector(finishBtnClicked)
        forControlEvents:UIControlEventTouchUpInside];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:finishBtn];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    lineView2.backgroundColor =  [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [self addSubview:lineView2];
    
    
    
    self.pickerView.frame = CGRectMake(0, 40, SCREEN_WIDTH, 40+30*6);
//    [self.durationPickerselectRow:0inComponent:0animated:YES];//每次显示picker的时候都选中第一行
    [self addSubview:self.pickerView];

    self.currentProvinceModel = self.dataSouce[0];
    self.currentCityModel = _currentProvinceModel.second[0];
    self.currentAreaModel = _currentCityModel.second[0];
}

- (void)finishBtnClicked{
    
    if (self.didSelectRowBlock) {
        self.didSelectRowBlock(_currentProvinceModel,_currentCityModel,_currentAreaModel);
    }
    CGRect fame1 = self.frame;
    fame1.origin.y = SCREEN_HEIGHT;
    
    [UIView animateWithDuration:0.8 animations:^{
        self.frame = fame1;
    }];
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
    return _pickerRow;
    return 3;//省、市、区
}
//行中有几列
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.dataSouce.count;
    }else if (component == 1){
        AreaModel *province = self.dataSouce[_proIndex];
        return province.second.count;
    }else{
        AreaModel * shengModel = self.dataSouce[_proIndex];
        NSInteger cityIndex = [_pickerView selectedRowInComponent:1];
        AreaModel * areaModel = shengModel.second[cityIndex];
        
        return areaModel.second.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

//列显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    
    if (component == 0) {
        AreaModel * shengModel = self.dataSouce[row];
        return shengModel.name;
    }else if (component == 1){
        AreaModel * shengModel = self.dataSouce[_proIndex];
        AreaModel * shiModel = shengModel.second[row];
        return shiModel.name;
    }else{
        AreaModel * shengModel = self.dataSouce[_proIndex];
        NSInteger cityIndex = [_pickerView selectedRowInComponent:1];
        AreaModel * shiModel = shengModel.second[cityIndex];
        AreaModel * areaModel = shiModel.second[row];
        return areaModel.name;
    }
 
}

#pragma mark - delegate
// 选中某一组的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        _proIndex = [pickerView selectedRowInComponent:0];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        [pickerView reloadAllComponents];
    }else if (component == 1){
        [pickerView selectRow:0 inComponent:2 animated:NO];
        [pickerView reloadAllComponents];
    }
    //获取选中省会
    self.currentProvinceModel = self.dataSouce[_proIndex];
    //获取选择城市
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    self.currentCityModel = _currentProvinceModel.second[cityIndex];

    //获取选中县区
    if (_pickerRow == 3) {
        NSInteger areaIndex = [pickerView selectedRowInComponent:2];
        self.currentAreaModel = _currentCityModel.second[areaIndex];
    }
    

//    if (self.didSelectRowBlock) {
//        self.didSelectRowBlock(_currentProvinceModel,_currentCityModel,_currentAreaModel);
//    }
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
