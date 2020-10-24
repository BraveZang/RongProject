//
//  MessageInfoDetailVCViewController.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/24.
//

#import "MessageInfoDetailVC.h"
#import "MessageDetailCell.h"
#import "MessageDetailModel.h"

@interface MessageInfoDetailVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property(nonatomic, strong)   UITableView               *tableView;
@property(nonatomic, strong)   NetManager                *net;
@property(nonatomic, strong)   NSMutableArray            *datAry;
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    if (self.datAry.count == 0) {
        self.noDataLab.text=@"暂无信息";
        UIView *backgroundImageView = self.noDataView;
        self.tableView.backgroundView = backgroundImageView;
        self.tableView.backgroundView.contentMode = UIViewContentModeCenter;
    } else {
        self.tableView.backgroundView = nil;
    }
    return self.datAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MessageDetailCell";
    MessageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MessageDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.model=self.datAry[indexPath.section];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellH=180*SCREEN_WIDTH/750;
    if (IS_IPAD) {
        return cellH*2/3;
    }
    else{
        return cellH;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =[UIColor colorWithRed:243/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    return view;
    
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
            
          NSArray*body=result[@"body"];
            self.datAry=[NSMutableArray arrayWithCapacity:0];
            for(NSDictionary*dic in body){
                MessageDetailModel*model=[MessageDetailModel mj_objectWithKeyValues:dic];
                [self.datAry addObject:model];
            }
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
