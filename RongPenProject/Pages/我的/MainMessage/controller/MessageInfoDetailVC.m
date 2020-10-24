//
//  MessageInfoDetailVCViewController.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/24.
//

#import "MessageInfoDetailVC.h"
#import "MessageDetailCell.h"

@interface MessageInfoDetailVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property(nonatomic, strong)   UITableView               *tableView;
@property(nonatomic, strong)   NetManager                *net;
@property(nonatomic, strong)   NSDictionary              *allDic;
@property(nonatomic, strong)   NSArray                   *allAry;

@end

@implementation MessageInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=self.titleStr;
    [self initTableView];
    [self getMessageDetailUrl];
    
}

-(void)setTypeStr:(NSString *)typeStr{
    
    _typeStr=typeStr;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr=titleStr;
}
#pragma mark UITableViewDataSource
- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.allAry.count == 0) {
        self.noDataLab.text=@"暂无信息";
        UIView *backgroundImageView = self.noDataView;
        self.tableView.backgroundView = backgroundImageView;
        self.tableView.backgroundView.contentMode = UIViewContentModeCenter;
    } else {
        self.tableView.backgroundView = nil;
    }
    return self.allAry.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MessageDetailCell";
    MessageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MessageDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellH=120*SCREEN_WIDTH/750;
    if (IS_IPAD) {
        return cellH*2/3;
    }
    else{
        return cellH;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString*ketStr=self.allAry[indexPath.row];
    NSString*typeStr;
    if ([ketStr isEqualToString:@"buy"]) {
        typeStr=@"1";
    }
    else if ([ketStr isEqualToString:@"class"]) {
        typeStr=@"2";
    }
    else{
        typeStr=@"3";

    }
    MessageInfoDetailVC*vc=[MessageInfoDetailVC new];
    vc.typeStr=typeStr;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}


#pragma mark === NetManagerDelegate ===

-(void)getMessageDetailUrl{
    
    self.net.requestId=1001;
    [self.net Message_infoWithUid:[User getUserID] andType:self.typeStr];
}
- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        if (self.net.requestId==1001) {
            self.allAry=result[@"body"];
            [self.tableView reloadData];
        }
    }
    
}

- (void)requestError:(NetManager *)request error:(NSError*)error{
    
}

- (void)requestStart:(NetManager *)request{
    
}
- (NetManager *)net{
    if (!_net) {
        self.net = [[NetManager alloc] init];
        _net.delegate = self;
    }
    return _net;
}
@end
