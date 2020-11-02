//
//  ReadTestVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/24.
//

#import "ReadTestVC.h"
#import "ReadTestHeader.h"
#import "ReadTestFooter.h"
#import "ReadTestCell.h"
#import "TestModel.h"

@interface ReadTestVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong) ReadTestHeader        *headerView;
@property (nonatomic, strong) ReadTestFooter        *footerView;


@property (nonatomic,strong) UITableView                      *wordTable;
@property (nonatomic,strong) NSArray                          *wordArray;//分组

@property(nonatomic,strong)   NetManager                        *net;


@end

@implementation ReadTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toptitle.text=@"测评";
    
    self.toptitle.hidden=NO;
//    self.rightImgBtn.hidden=NO;
    self.leftImgBtn.hidden=NO;
//    self.leftImgBtn.frame=CGRectMake(0, SafeAreaTopHeight-64+(64-15)/2, 80, 30);
//    [self.leftImgBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.leftImgBtn setImage:[UIImage imageNamed:@"Read_guide_Icon"] forState:UIControlStateNormal];
//
//    [self.rightImgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.rightImgBtn setImage:[UIImage imageNamed:@"pen_s"] forState:UIControlStateNormal];
//    self.rightImgBtn.frame=CGRectMake(ScreenWidth-60, SafeAreaTopHeight-64+(64-15)/2, 60, 30);
//    [self.rightImgBtn setTitle:@"未连接" forState:UIControlStateNormal];
//    [self.rightImgBtn layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleRight imageTitleSpace:2];
//    [self.rightImgBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.wordTable=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,  ScreenWidth, ScreenHeight-SafeAreaBottomHeight-SafeAreaTopHeight-APP_HEIGHT_6S(56.0)) style:UITableViewStylePlain];
    self.wordTable.delegate=self;
    self.wordTable.dataSource=self;
    self.wordTable.backgroundColor=[UIColor colorWithHexColorString:@"F3F5F8"];
    self.wordTable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.wordTable.tableHeaderView=self.headerView;
    [self.view addSubview:self.wordTable];
    
    
    [self.view addSubview:self.footerView];
}


- (void)setUnitModel:(UnitModel *)unitModel{
    _unitModel = unitModel;
}

- (void)setMapModel:(MapDataModel *)mapModel{
    _mapModel = mapModel;
    [self.net main_assessWithUnitid:_unitModel.unitid BookId:_unitModel.bookid andZspage:mapModel.zspage];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wordArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return APP_HEIGHT_6S(73.0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ReadTestCell";
    
    ReadTestCell*cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ReadTestCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.model = self.wordArray[indexPath.row];
    cell.backgroundColor = [UIColor colorWithHexColorString:@"F3F5F8"];
    return cell;
    
}



#pragma markr -lazy

- (ReadTestFooter *)footerView{
    if (!_footerView) {
        _footerView = [[ReadTestFooter alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - APP_HEIGHT_6S(56.0) - SafeAreaBottomHeight, KSCREEN_WIDTH, APP_HEIGHT_6S(56.0))];
        _footerView.phoneWriteblock = ^{
            
        };
        _footerView.penWriteblock = ^{
            
        };
    }
    return _footerView;
}

- (ReadTestHeader *)headerView{
    if (!_headerView) {
        _headerView = [[ReadTestHeader alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, APP_HEIGHT_6S(80.0))];
    }
    return _headerView;
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
        NSDictionary * dic = result[@"body"];
        self.wordArray = [TestModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        [self.wordTable reloadData];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
