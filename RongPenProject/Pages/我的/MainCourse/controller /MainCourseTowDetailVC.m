//
//  MainCourseTowDetailVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/31.
//

#import "MainCourseTowDetailVC.h"
#import "MainCourseDetailModel.h"
#import "WKPlayerView.h"
#import "VideoTeacherCell.h"
#import "VideoTitleCell.h"
#import "VideoCourseRangeCell.h"
#import "UIAlertView+Block.h"
#import "SureCourSeOrderVC.h"

@interface MainCourseTowDetailVC ()<UIWebViewDelegate, WKPlayerViewDelegate,UITableViewDelegate,UITableViewDataSource,NetManagerDelegate,UIAlertViewDelegate>

@property(nonatomic, strong)   UITableView               *tableView;
@property(nonatomic, strong)   NetManager                *net;
@property(nonatomic, strong)   NSMutableArray            *datAry;
@property(nonatomic, strong)   MainCourseDetailModel     *model;
@property(nonatomic, strong)   WKPlayerView              *palyerView;
@property(nonatomic, strong)   NSArray                   *teacherInfoAry;
@property(nonatomic, strong)   NSArray                   *courserangeInfoAry;
@property(nonatomic, assign)   NSInteger                 currentIndex;
@property(nonatomic, strong)   UIWebView                 *webView;
@property(nonatomic, assign)   CGFloat                   webViewH;

@end

@implementation MainCourseTowDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"直播详情";
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, ScreenWidth, ScreenHeight-SafeAreaBottomHeight-SafeAreaTopHeight)];
    self.webView.delegate=self;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webView.scalesPageToFit = YES;
    self.currentIndex=10000;
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
    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-SafeAreaTopHeight-70) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];
    
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-SafeAreaBottomHeight-SafeAreaTopHeight-100)];
    self.webView.delegate=self;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webView.scalesPageToFit = YES;
    
    UIButton*buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame=CGRectMake(20, ScreenHeight-SafeAreaBottomHeight-60, ScreenWidth-40, 44);
    [buyBtn setBackgroundColor:[MTool colorWithHexString:@"#FF4E4E"]];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    buyBtn.cornerRadius=22;
   [buyBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
}
-(void)sureClick
{
    
    [self getButUrl];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==1) {
        
        return self.teacherInfoAry.count;
        
    }
    else if (section==2) {
        
        return self.courserangeInfoAry.count;
        
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
        tableView.rowHeight=FitRealValue(200);
        cell.nameLab.text=@"直播";
        if (IS_IPAD) {
            tableView.rowHeight=FitRealValue(200)*2/3;
        }
        cell.model=self.model;
        return cell;
    }
    else if (indexPath.section==1) {
        static NSString *cellIdentifier = @"VideoTeacherCell";
        VideoTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[VideoTeacherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSDictionary*dic=self.teacherInfoAry[indexPath.row];
        TeacherInfoModel*model=[TeacherInfoModel mj_objectWithKeyValues:dic];
        cell.model=model;
        tableView.rowHeight=model.cellH+5;
        
        return cell;
    }
    else  if (indexPath.section==2) {
        static NSString *cellIdentifier = @"VideoCourseRangeCell";
        VideoCourseRangeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[VideoCourseRangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        tableView.rowHeight=FitRealValue(80);
        NSDictionary*dic=self.courserangeInfoAry[indexPath.row];
        cell.model=[CourSerAngeModel mj_objectWithKeyValues:dic];
        cell.playImg.hidden=YES;
        if (self.currentIndex==indexPath.row) {
            cell.nameLab.textColor=[MTool colorWithHexString:@"#FF6B6B"];
            cell.titleLab.textColor=[MTool colorWithHexString:@"#FF6B6B"];
            [cell.playImg setImage:[UIImage imageNamed:@"play_stop"]];
        }
        else{
            cell.nameLab.textColor=[MTool colorWithHexString:@"121212"];
            cell.titleLab.textColor=[MTool colorWithHexString:@"#121212"];
            [cell.playImg setImage:[UIImage imageNamed:@"play_stop"]];
            
        }
        if (self.currentIndex==10000) {
            cell.nameLab.textColor=[MTool colorWithHexString:@"#121212"];
            cell.titleLab.textColor=[MTool colorWithHexString:@"#121212"];
            [cell.playImg setImage:[UIImage imageNamed:@"play_img"]];
        }
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        tableView.rowHeight=ScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight-100;
        [cell addSubview:self.webView];
        return cell;
    }
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    float cellH=180*SCREEN_WIDTH/750;
//    if (IS_IPAD) {
//        return cellH*2/3;
//    }
//    else{
//        return cellH;
//    }
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    __weak typeof(self) weakSelf = self;
    if (indexPath.section==2) {
        
        
        self.currentIndex=indexPath.row;
        NSDictionary*dic=self.courserangeInfoAry[indexPath.row];
        CourSerAngeModel*model=[CourSerAngeModel mj_objectWithKeyValues:dic];
        if ([model.istry isEqualToString:@"1"]) {
            self.palyerView.currentTime=YES;
            [self.palyerView playWithViedeoUrl:model.videolink];
            self.palyerView .Block = ^{
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前课程需要购买，是否购买" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"去购买", nil];
                [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                    }
                    else{
                        weakSelf.palyerView.currentTime=NO;
                        weakSelf.currentIndex=10000;
                        [weakSelf.palyerView playWithViedeoUrl:weakSelf.model.videourl];
                        [weakSelf.tableView reloadData];
                    }
                }];
            };
        }
    }
    
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
    if (section==2) {
        lab.text=@"课程大纲";
    }
    if (section==3) {
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
-(void)getButUrl{
    self.net.requestId=1002;
    [self.net Course_buyWithType:self.typeStr Uid:[User getUserID] Id:self.idStr];
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
            self.courserangeInfoAry=self.model.courserange;
            NSURL *url =[NSURL URLWithString:[self.model.details stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [ self.webView loadRequest:[NSURLRequest requestWithURL:url]];
            [self.tableView reloadData];
        }
        
        if (self.net.requestId==1002) {
            
            NSDictionary*body=result[@"body"];
            SureCourSeOrderVC*vc=[SureCourSeOrderVC new];
            vc.idStr=body[@"id"];
            vc.ordersnStr=body[@"ordersn"];
            [self.navigationController pushViewController:vc animated:YES];
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
