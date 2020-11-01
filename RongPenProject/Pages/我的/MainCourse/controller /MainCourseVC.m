//
//  MainCourseVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/18.
//


#import "MainCourseVC.h"
#import "MCPageView.h"
#import "MainCoursePageOneVC.h"
#import "MainCoursePageThreeVC.h"
#import "MainCoursePageTowVC.h"
#import "WebViewViewController.h"
#import "MainCourseDetailVC.h"
#import "MyOrderListVC.h"
#import "MainCourseTowDetailVC.h"
#import "MainCourseThreeDetailVC.h"

@interface MainCourseVC ()

@property (nonatomic , strong) MCPageView * PageView;

@end

@implementation MainCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.rightImgBtn.hidden=NO;
    [self.rightImgBtn setImage:nil forState:UIControlStateNormal];
    [self.rightImgBtn setTitle:@"订单管理" forState:UIControlStateNormal];
    [self.rightImgBtn setTitleColor:[MTool colorWithHexString:@"#3777DE"] forState:UIControlStateNormal];
    [self.rightImgBtn  addTarget:self action:@selector(goMyOrderListVC) forControlEvents:UIControlEventTouchUpInside];
    self.topview.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"荣知课程";
    self.lineview.hidden=NO;
    [self createTopView];
}

-(void)createTopView{
    
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *controllers = [NSMutableArray array];
    
    MainCoursePageOneVC*vc1=[MainCoursePageOneVC new];
    vc1.tiemClickBlock = ^(CourseVideoModel * _Nonnull model) {
        MainCourseDetailVC*vc=[MainCourseDetailVC new];
        vc.idStr=model.id;
        vc.typeStr=model.type;
        [self.navigationController pushViewController:vc animated:YES];
    };
    [controllers addObject:vc1];
    [titles addObject:@"录播课程"];
    
    MainCoursePageTowVC*vc2=[MainCoursePageTowVC new];
    vc2.tiemClickBlock = ^(CourseVideoModel * _Nonnull model) {
        
        MainCourseTowDetailVC*vc=[MainCourseTowDetailVC new];
        vc.idStr=model.id;
        vc.typeStr=model.type;
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    [controllers addObject:vc2];
    [titles addObject:@"直播课程"];
    
    MainCoursePageThreeVC*vc3=[MainCoursePageThreeVC new];
    vc3.tiemClickBlock = ^(GoodsModel * _Nonnull model) {
        if ([model.type isEqualToString:@"直播"]) {
            WebViewViewController*vc=[WebViewViewController new];
            vc.titleStr=model.goodsname;
            vc.urlStr=model.livelink;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            MainCourseThreeDetailVC*vc=[MainCourseThreeDetailVC new];
            vc.goodsIdStr=model.goodsid;
            vc.ordersnStr=model.ordersn;
            vc.typeStr=model.type;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    [controllers addObject:vc3];
    [titles addObject:@"已购课程"];
    
    
    
    self.PageView = [[MCPageView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, self.view.frame.size.width,ScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight) titles:titles controllers:controllers];
    self.PageView.titleButtonWidth = 60;
    self.PageView.lineWitdhScale = 0.2;
    self.PageView.selectTitleFont = [UIFont boldSystemFontOfSize:16];
    self.PageView.defaultTitleFont = [UIFont boldSystemFontOfSize:16];
    self.PageView.defaultTitleColor = [MTool colorWithHexString:@"#666666"];
    self.PageView.selectTitleColor = [UIColor redColor];
    [self.view addSubview:self.PageView];
}
-(void)goMyOrderListVC{
    
    MyOrderListVC*vc=[MyOrderListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
