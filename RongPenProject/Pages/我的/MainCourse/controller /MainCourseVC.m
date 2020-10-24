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

@interface MainCourseVC ()

@property (nonatomic , strong) MCPageView * PageView;

@end

@implementation MainCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.rightImgBtn.hidden=NO;
    [self.rightImgBtn setTitle:@"订单管理" forState:UIControlStateNormal];
    [self.rightImgBtn setTitleColor:[MTool colorWithHexString:@"#3777DE"] forState:UIControlStateNormal];
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
    [controllers addObject:vc1];
    [titles addObject:@"录播课程"];
    
    MainCoursePageTowVC*vc2=[MainCoursePageTowVC new];
    vc2.tiemClickBlock = ^(CourseVideoModel * _Nonnull model) {
        WebViewViewController *webVC = [[WebViewViewController alloc]init];
        webVC.urlStr = model.videofm;
        webVC.titleStr=model.name;
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [controllers addObject:vc2];
    [titles addObject:@"直播课程"];
    [controllers addObject:[MainCoursePageThreeVC new]];
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

@end
