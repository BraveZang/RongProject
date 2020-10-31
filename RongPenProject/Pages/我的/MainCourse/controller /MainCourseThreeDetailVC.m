//
//  MainCourseThreeDetailVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/31.
//

#import "MainCourseThreeDetailVC.h"
#import "MainCourseDetailModel.h"
#import "WKPlayerView.h"
#import "VideoTeacherCell.h"
#import "VideoTitleCell.h"
#import "VideoCourseRangeCell.h"
#import "UIAlertView+Block.h"
#import "RecordeDetailModel.h"
@interface MainCourseThreeDetailVC ()<WKPlayerViewDelegate,UITableViewDelegate,UITableViewDataSource,NetManagerDelegate,UIAlertViewDelegate>

@property(nonatomic, strong)   UITableView               *tableView;
@property(nonatomic, strong)   NetManager                *net;
@property(nonatomic, strong)   NSMutableArray            *datAry;
@property(nonatomic, strong)   MainCourseDetailModel     *model;
@property(nonatomic, strong)   WKPlayerView              *palyerView;
@property(nonatomic, strong)   NSArray                   *teacherInfoAry;
@property(nonatomic, strong)   NSArray                   *courserangeInfoAry;
@property(nonatomic, assign)   NSInteger                 currentIndex;

@end

@implementation MainCourseThreeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.currentIndex=0;
    self.toptitle.text=@"荣知课程";
    [self initTableView];
    [self getVideoDetailUrl];
    self.view.backgroundColor=[MTool colorWithHexString:@"#F3F5F8"];
}
#pragma mark - Getter


- (WKPlayerView *)palyerView {
    if (!_palyerView) {
        _palyerView = [[WKPlayerView alloc] init];
        _palyerView.delegate = self;
    }
    return _palyerView;
}
-(void)setIdStr:(NSString *)idStr{
    _idStr=idStr;
}
-(void)setTypeStr:(NSString *)typeStr{
    
    _typeStr=typeStr;
}
#pragma mark UITableViewDataSource
- (void)initTableView {
    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.datAry.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier = @"VideoCourseRangeCell";
    VideoCourseRangeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VideoCourseRangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    tableView.rowHeight=FitRealValue(80);
    cell.recordeModel=self.datAry[indexPath.row];
    cell.playImg.hidden=NO;
    if (self.currentIndex==indexPath.row) {
        cell.nameLab.textColor=[MTool colorWithHexString:@"#FF6B6B"];
        cell.titleLab.textColor=[MTool colorWithHexString:@"#FF6B6B"];
        [cell.playImg setImage:[UIImage imageNamed:@"play_stop"]];
    }
    else{
        cell.nameLab.textColor=[MTool colorWithHexString:@"121212"];
        cell.titleLab.textColor=[MTool colorWithHexString:@"#121212"];
        [cell.playImg setImage:[UIImage imageNamed:@"play_img"]];
        
    }
   
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.currentIndex=indexPath.row;
    RecordeDetailModel*model=self.datAry[indexPath.row];
    self.palyerView.currentTime=YES;
    [self.palyerView playWithViedeoUrl:model.videolink];
    self.palyerView .Block = ^{
        
    };
    [self.tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 12+40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 52)];
    view.backgroundColor=[UIColor whiteColor];
    UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    lineView.backgroundColor =[UIColor colorWithRed:243/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    [view addSubview:lineView];
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 12, ScreenWidth-LeftMargin*2, 40)];
    lab.font=[UIFont systemFontOfSize:16];
    lab.textColor=[MTool colorWithHexString:@"#121212"];
    [view addSubview:lab];
    lab.text=@"课程大纲";
    return view;
}
- (UIViewController *)getpresentViewController {
    return self.navigationController;
}
- (UIView *)getPlayerSuperView {
    return self.view;
}
#pragma mark === NetManagerDelegate ===

-(void)getVideoDetailUrl{
    
    self.net.requestId=1001;
    [self.net Course_autoplayWithGoodsid:self.goodsIdStr Uid:[User getUserID] Ordersn:self.ordersnStr Type:self.typeStr];
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
                RecordeDetailModel*model=[RecordeDetailModel mj_objectWithKeyValues:dic];
                [self.datAry addObject:model];
            }
            RecordeDetailModel*firstModel=self.datAry.firstObject;
            self.palyerView .frame=CGRectMake(0, SafeAreaTopHeight, ScreenWidth, FitRealValue(500));
            self.tableView.tableHeaderView=self.palyerView;
            [self.palyerView playWithViedeoUrl:firstModel.videolink];
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

