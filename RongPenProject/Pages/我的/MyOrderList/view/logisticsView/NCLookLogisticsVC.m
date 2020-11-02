//
//  NCLookLogisticsVC.m
//  ElleShop
//
//  Created by xiuchanghui on 2017/7/14.
//  Copyright © 2017年 BeautyFuture. All rights reserved.
//

#import "NCLookLogisticsVC.h"
#import "OKLogisticsView.h"
#import "OKLogisticModel.h"
#import "OKConfigFile.h"

@interface NCLookLogisticsVC ()

@property (nonatomic,strong) NSMutableArray * dataArry;

@end

@implementation NCLookLogisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:nckColor(0xececec)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"物流信息";
    NSArray *titleArr = [NSArray arrayWithObjects:
                         @"您的快件已被 韵达快递站 代签收，地址：王于路与百沙路交叉口东100米，如有疑问请电联快递员：赵海【13371607596】。",
                         @"北京昌平区昌平公司松兰堡分部 快递员 赵海13371607596 正在为您派件【95114\/95121\/9501395546为韵达快递员外呼专属号码，请放心接听】" ,
                         @"已离开 北京昌平区昌平公司；发往 北京昌平区昌平公司松兰堡分部",
                         @"已离开 华北枢纽；发往 北京昌平区昌平公司",
                         @"已到达 华北枢纽",
                         @"【广州市】已离开 广东广州分拨中心；发往 华北枢纽",nil];
    NSArray *timeArr = [NSArray arrayWithObjects:
                        @"2020-10-03 11:04:54",
                        @"2020-10-03 08:41:00",
                        @"2020-10-03 07:27:02",
                        @"2020-10-02 23:19:23",
                        @"2020-10-02 22:30:33",
                        @"2020-10-01 03:17:13",nil];
    
    for (NSInteger i = titleArr.count-1;i>=0 ; i--) {
        OKLogisticModel * model = [[OKLogisticModel alloc]init];
        model.dsc = [titleArr objectAtIndex:i];
        model.date = [timeArr objectAtIndex:i];
        [self.dataArry addObject:model];
    }
    // 数组倒叙
    self.dataArry = (NSMutableArray *)[[self.dataArry reverseObjectEnumerator] allObjects];
    OKLogisticsView * logis = [[OKLogisticsView alloc]initWithDatas:self.dataArry];
    // 给headView赋值
    logis.wltype=@"已签收";
    logis.number = @"3908723967437";
    logis.company = @"韵达快运";
    logis.phone = @"400-821-6789";
    logis.imageUrl = @"http://pic40.nipic.com/20140420/12064170_201114370112_2.jpg";
    logis.frame = CGRectMake(0, 64, OKScreenWidth, OKScreenHeight-64);
    [self.view addSubview:logis];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray *)dataArry {
    if (!_dataArry) {
        _dataArry = [NSMutableArray array];
    }
    return _dataArry;
}

@end
