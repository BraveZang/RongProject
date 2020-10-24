//
//  MainCourseDetailVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/24.
//

#import "MainCourseDetailVC.h"
#import "MainCourseDetailModel.h"
#import "WKPlayerView.h"
#import "VideoTeacherCell.h"
#import "VideoTitleCell.h"

@interface MainCourseDetailVC ()<WKPlayerViewDelegate,UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property(nonatomic, strong)   UITableView               *tableView;
@property(nonatomic, strong)   NetManager                *net;
@property(nonatomic, strong)   NSMutableArray            *datAry;
@property(nonatomic, strong)   MainCourseDetailModel     *model;
@property(nonatomic, strong)   WKPlayerView              *palyerView;
@property(nonatomic, strong)   NSArray                   *teacherInfoAry;

@end

@implementation MainCourseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"荣知课程";
    [self initTableView];
    [self getVideoDetailUrl];
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
   
   
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==1) {
        
    return self.teacherInfoAry.count;
        
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        static NSString *cellIdentifier = @"VideoTitleCell";
        VideoTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[VideoTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        tableView.rowHeight=FitRealValue(250);
        cell.model=self.model;
        return cell;
    }
    if (indexPath.section==1) {
        static NSString *cellIdentifier = @"VideoTeacherCell";
        VideoTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[VideoTeacherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        tableView.rowHeight=FitRealValue(250);
        NSDictionary*dic=self.teacherInfoAry[indexPath.row];
        cell.model=[TeacherInfoModel mj_objectWithKeyValues:dic];
        tableView.rowHeight=cell.model.cellH;
        
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }
    
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
    if (section==0) {
        return 0;
    }
    else{
    return 12+40;
        
    }
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
    if (section==1) {
        lab.text=@"授课教师";
    }
    if (section==1) {
        lab.text=@"课程大纲";
    }
    if (section==2) {
        lab.text=@"课程介绍";
    }
    if (section==0) {
        return nil;
    }
    else{
    return view;
    }
    
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
    [self.net Course_infoWithId:self.idStr Type:self.typeStr];
}
- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        if (self.net.requestId==1001) {
            
          NSDictionary*body=result[@"body"];
            self.model=[MainCourseDetailModel mj_objectWithKeyValues:body];
            self.palyerView .frame=CGRectMake(0, SafeAreaTopHeight, ScreenWidth, FitRealValue(500));
            NSData *data = [NSData  dataWithContentsOfURL:[NSURL URLWithString:self.model.videofm]];
            UIImage *image =  [UIImage imageWithData:data];
            self.palyerView.coverImage=image;
            self.palyerView.name=self.model.name;
//            [self.view addSubview:self.palyerView];
            self.tableView.tableHeaderView=self.palyerView;
            [self.palyerView playWithViedeoUrl:self.model.videourl];
            self.teacherInfoAry=self.model.teacherinfo;
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
