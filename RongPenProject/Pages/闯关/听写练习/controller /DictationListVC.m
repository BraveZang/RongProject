//
//  DictationVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "DictationListVC.h"
#import "DictationListCell.h"
#import "CheckpointListVC.h"
#import "UnitModel.h"
@interface DictationListVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong)  UITableView          *tableView;

@property(nonatomic,strong)   NetManager                        *net;


@property (nonatomic, strong) NSArray                           *unitList;

@end

@implementation DictationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toptitle.hidden=NO;
    self.toptitle.text=@"听写练习";
    self.leftImgBtn.hidden=NO;
    [self initTableView];
}



- (void)setBookModel:(MainBookModel *)bookModel{
    _bookModel = bookModel;
    //测试数据 待调整
    [self.net Pass_txWithUid:[User getUserID] andBookId:@"3"];
}

- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    float cellH=FitRealValue(300);
    if (IS_IPAD) {
        cellH=cellH*2/3;
    }
    self.tableView.rowHeight = cellH;
    
    [self.view addSubview:self.tableView];
}


#pragma mark UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.unitList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 12;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"DictationListCell";
    DictationListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DictationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.unitModle = self.unitList[indexPath.section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CheckpointListVC*vc=[CheckpointListVC new];
    vc.unitModel = self.unitList[indexPath.section];
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

        self.unitList = [UnitModel mj_objectArrayWithKeyValuesArray:dataArray];
        
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

- (NSArray *)unitList{
    if (!_unitList) {
        _unitList = [[NSArray alloc] init];
    }
    return _unitList;
}

@end
