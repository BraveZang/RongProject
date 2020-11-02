//
//  OrderLogisticsVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/2.
//

#import "OrderLogisticsVC.h"
#import "OrderLogisticsModel.h"
#import "OKLogisticsView.h"
#import "OKLogisticModel.h"
#import "OKConfigFile.h"
@interface OrderLogisticsVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong)  NetManager                        *net;
@property (nonatomic, strong)  OrderLogisticsModel               *model;
@property (nonatomic, strong)  NSMutableArray                    *titleAry;
@property (nonatomic, strong)  NSMutableArray                    *timeAry;
@property (nonatomic, strong)  NSMutableArray                    *dataArry;

@end

@implementation OrderLogisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"物流信息";
    [self getOrderLogisticsVC];
}

-(void)setOrdersnStr:(NSString *)ordersnStr{
    _ordersnStr=ordersnStr;
}
-(void)setWlordersnStr:(NSString *)wlordersnStr{
    _wlordersnStr=wlordersnStr;
}
-(void)getOrderLogisticsVC{
    self.net.requestId=1001;
//    [self.net Order_logisticsWithWlordersn:_ordersnStr rdersn:_wlordersnStr];
    [self.net Order_logisticsWithWlordersn:@"4308869486134" rdersn:@"RZJY52030416018845041"];

}
#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    
//    [self.tableView.mj_header endRefreshing];
//    [self.tableView.mj_footer endRefreshing];
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        if (request.requestId==1001) {
            NSDictionary*bodyDic=result[@"body"];
            self.model=[OrderLogisticsModel mj_objectWithKeyValues:bodyDic];
            self.timeAry=[NSMutableArray arrayWithCapacity:0];
            self.titleAry=[NSMutableArray arrayWithCapacity:0];
            self.dataArry=[NSMutableArray arrayWithCapacity:0];

            NSArray*listAry=self.model.list;
            for (NSDictionary*dic in listAry) {
                NSString*titleStr=dic[@"status"];
                NSString*timeStr=dic[@"time"];
                [self.titleAry addObject:titleStr];
                [self.timeAry addObject:timeStr];
            }
            for (NSInteger i = self.titleAry.count-1;i>=0 ; i--) {
                
                  OKLogisticModel * model = [[OKLogisticModel alloc]init];
                  model.dsc = [self.titleAry objectAtIndex:i];
                  model.date = [self.timeAry objectAtIndex:i];
                  [self.dataArry addObject:model];
              }
              // 数组倒叙
              self.dataArry = (NSMutableArray *)[[self.dataArry reverseObjectEnumerator] allObjects];
              OKLogisticsView * logis = [[OKLogisticsView alloc]initWithDatas:self.dataArry];
              // 给headView赋值
              logis.wltype=@"已签收";
              logis.number =self.model.number;
              logis.company =self.model.expName;
              logis.phone = @"400-821-6789";
              logis.imageUrl = @"http://pic40.nipic.com/20140420/12064170_201114370112_2.jpg";
              logis.frame = CGRectMake(0, SafeAreaTopHeight, OKScreenWidth, OKScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight);
              [self.view addSubview:logis];
        }
         if (request.requestId==1002) {
            
            
         }
         if (request.requestId==1003) {
             
         }
        
    }
    
}

- (void)requestError:(NetManager *)request error:(NSError*)error{
    
}

- (void)requestStart:(NetManager *)request{
    
}

#pragma mark -lazy
- (NetManager *)net{
    if (!_net) {
        self.net = [[NetManager alloc] init];
        _net.delegate = self;
    }
    return _net;
}

@end
