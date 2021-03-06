//
//  CheckpointListVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "CheckpointListVC.h"
#import "CheckpointListCell.h"
#import "CheckpointResultVC.h"
#import "gkModel.h"
#import "CheckpointVC.h"
@interface CheckpointListVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong)  UITableView          *tableView;

@property(nonatomic,strong)   NetManager                        *net;
@property (nonatomic, strong) NSArray                           *gkList;
@end

@implementation CheckpointListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toptitle.hidden=NO;
    self.leftImgBtn.hidden=NO;
    [self initTableView];
}

- (void)setConfirmType:(NSInteger)confirmType{
    _confirmType = confirmType;
    if (confirmType == 0) {
        self.toptitle.text=@"听写练习";
    }else{
        self.toptitle.text=@"中英互译";
    }
}

- (void)setUnitModel:(UnitModel *)unitModel{
    _unitModel = unitModel;
    
    
    if (_confirmType == 0) {
        //听写闯关
        [self.net Pass_gqlistWithUid:[User getUserID] andBookId:unitModel.bookid andUnitid:unitModel.unitid];
    }else{
        //中英互译
        [self.net Pass_cntoenlistWithUid:[User getUserID] andBookId:unitModel.bookid andUnitid:unitModel.unitid];
    }
    
    
}


#pragma mark UITableViewDataSource
- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    float cellH=FitRealValue(560);
    if (IS_IPAD) {
        cellH=cellH*2/3;
    }
    self.tableView.rowHeight = cellH;
    [self.view addSubview:self.tableView];
}

#pragma mark – Network



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.gkList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CheckpointListCell";
    CheckpointListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CheckpointListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model = self.gkList[indexPath.section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CheckpointVC*vc=[CheckpointVC new];
    vc.model = self.gkList[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        
        //辅材列表
        NSArray * dataArray = result[@"body"];

        self.gkList = [gkModel mj_objectArrayWithKeyValuesArray:dataArray];
        
        [self.tableView reloadData];
        
       
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

- (NSArray *)gkList{
    if (!_gkList) {
        _gkList = [[NSArray alloc] init];
    }
    return _gkList;
}

@end
