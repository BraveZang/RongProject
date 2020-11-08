//
//  ConnectPenVC.m
//  RongPenProject
//
//  Created by mac on 7.11.20.
//

#import "ConnectPenVC.h"
#import "PenGuideView.h"
#import "PenCell.h"
#import <SmartPenSDK/SmartPenSDK.h>
#import "ConnectPenResultVC.h"
@interface ConnectPenVC ()<UITableViewDelegate,UITableViewDataSource,OnBLEScanListener, TQLPenSignal>
@property (nonatomic, strong)PenGuideView        *headerView;
@property (nonatomic, strong)UIImageView         *IconImgV;

@property (nonatomic, strong)UITableView         *penTable;

@property (nonatomic, strong)NSMutableArray             *penList;

//测试
@property (nonatomic, strong) PenCommAgent       *penCommAgent;



@end

@implementation ConnectPenVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.toptitle.hidden=NO;
    self.leftImgBtn.hidden=NO;
    self.toptitle.text=@"连接蓝牙笔";
    self.view.backgroundColor = hexColor(F3F5F8);
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.IconImgV];
    [self initTableView];
    
    //查找蓝牙设备及连接状态
    [self findAllDevices];
}

- (void)findAllDevices{
    _penCommAgent = [PenCommAgent getInstance];
    _penCommAgent.onBlEScanListener = self;
    _penCommAgent.pensignal = self;
    [_penCommAgent findAllDevices];
}


- (void)initTableView {
    self.penTable=[[UITableView alloc]initWithFrame:CGRectMake(0, self.IconImgV.bottom + 30, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight - self.IconImgV.bottom -30) style:UITableViewStylePlain];
    self.penTable.backgroundColor=[MTool colorWithHexString:@"F3F5F8"];
    self.penTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.penTable.dataSource=self;
    self.penTable.delegate=self;
    
    self.penTable.rowHeight = 56;
    
    [self.view addSubview:self.penTable];
}

- (void)onScanResult:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    [self insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
}

- (void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSLog(@"%@",peripheral);
    NSArray *peripherals = [self.penList valueForKey:@"peripheral"];

    if(![peripherals containsObject:peripheral] ) {

//        && [(NSString *)advertisementData[@"kCBAdvDataManufacturerData"] length] > 10
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:peripherals.count inSection:0];
        [indexPaths addObject:indexPath];
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        [item setValue:peripheral forKey:@"peripheral"];
        [item setValue:RSSI forKey:@"RSSI"];

        [item setValue:advertisementData forKey:@"advertisementData"];
        [self.penList addObject:item];
        [self.penTable insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark-- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.penList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PenCell";
    PenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.connectPeripheraBlock = ^(CBPeripheral * _Nonnull periphera) {
        [self.penCommAgent connect:periphera];
        ConnectPenResultVC * target = [[ConnectPenResultVC alloc] init];
        [self.navigationController pushViewController:target animated:YES];
    };
    
    
    NSDictionary *item = _penList[indexPath.row];
    CBPeripheral *peripheral = item[@"peripheral"];
    NSDictionary *advertisementData = item[@"advertisementData"];
    __unused NSNumber *RSSI = item[@"RSSI"];
    
    NSString *peripheralName;
    //NSLog(@"peripheral=====%@",peripheral.name);
    
    if ([advertisementData objectForKey:@"kCBAdvDataLocalName"] && ![[NSString stringWithFormat:@"%@",[advertisementData objectForKey:@"kCBAdvDataLocalName"]]isEqualToString:@""]) {
        peripheralName = [NSString stringWithFormat:@"%@",[advertisementData objectForKey:@"kCBAdvDataLocalName"]];
      //  NSLog(@"peripheralName=====%@",peripheralName);
    }
    else if(!([peripheral.name isEqualToString:@""] || peripheral.name == nil)){
        peripheralName = peripheral.name;
    }
   
   else{
        peripheralName = [peripheral.identifier UUIDString];
    }
    
    NSData *data = advertisementData[@"kCBAdvDataManufacturerData"];
    NSString *macAdress = [BLEDataTransform getNewMacAdress:data];
    
    cell.periphera = peripheral;
    cell.titleLab.text = peripheralName;
    return cell;
}

- (void)onConnected:(int)forceMax fwVersion:(NSString *)fwVersion {
  
    [DZTools showText:@"连接成功"];
}

- (void)onDisconnected {
    
    [DZTools showText:@"连接失败"];
}


#pragma mark -- lazy



- (PenGuideView *)headerView {
    if (!_headerView) {
        _headerView = [[PenGuideView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, 111)];
        _headerView.titleLab.text = @"2.连接智能笔MAC编号";
        
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString: @"查看尾部MAC编号，连接你的智能笔"];
        [placeholder addAttribute:NSForegroundColorAttributeName value:[MTool colorWithHexString:@"#D12E2E"] range:NSMakeRange(2,7)];
        _headerView.explainLab.attributedText = placeholder;
        
    }
    return _headerView;
}

- (UIImageView *)IconImgV{
    if (!_IconImgV) {
        _IconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH_6S(42.0), self.headerView.bottom +30, APP_WIDTH_6S(291.0), APP_WIDTH_6S(86.0))];
        _IconImgV.image =[UIImage imageNamed:@"pen_mac"];
        
    }
    return _IconImgV;
}

- (NSMutableArray *)penList{
    if (!_penList) {
        _penList = [NSMutableArray new];
        
    }
    return _penList;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
