//
//  readIndexVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//

#import "ReadIndexVC.h"
#import "LoginVC.h"
#import "SDCycleScrollView.h"//广告轮播图
#import "ShopIndexVC.h"
@interface ReadIndexVC ()<NetManagerDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SDCycleScrollView                *topAdScrollView;//广告轮播控件
@property (nonatomic,strong) UITableView                      *tableView;
@property (nonatomic,strong) UIView                           *heardView;
@property (nonatomic,strong) NSArray                          *titleTestArray;//分组
@property (nonatomic,strong) NSMutableArray                   *selectedArr;//存储需要展开的cell组
@property (nonatomic,strong) NSMutableArray                   *listDataAry;//存储需要展开的cell组
@property (nonatomic,strong) UIButton                         *cellRightBtn;
@end

@implementation ReadIndexVC




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.topview.hidden=NO;
    self.toptitle.hidden=NO;
    self.rightImgBtn.hidden=NO;
    self.leftImgBtn.hidden=NO;
    self.leftImgBtn.frame=CGRectMake(0, SafeAreaTopHeight-64+(64-15)/2, 80, 30);
    [self.leftImgBtn setTitle:@" 智能笔" forState:UIControlStateNormal];
    [self.leftImgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftImgBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.leftImgBtn setImage:[UIImage imageNamed:@"pen_s"] forState:UIControlStateNormal];
    [self.rightImgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightImgBtn setImage:[UIImage imageNamed:@"shopimg"] forState:UIControlStateNormal];
    self.rightImgBtn.frame=CGRectMake(ScreenWidth-60, SafeAreaTopHeight-64+(64-15)/2, 60, 30);
    [self.rightImgBtn setTitle:@"商城" forState:UIControlStateNormal];
    [self.rightImgBtn layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleRight imageTitleSpace:2];
    [self.rightImgBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self initData];
    [self CreatcycleScrollView];
    [self initableviewView];
    
}
-(void)initData{
    
    self.titleTestArray = [NSArray arrayWithObjects:@"一年级test", @"二年级test",@"三年级test",@"四年级test",@"五年级test",nil];
    
    self.selectedArr =[NSMutableArray arrayWithCapacity:0];
    self.listDataAry =[NSMutableArray arrayWithCapacity:0];
    [self.listDataAry addObjectsFromArray:self.titleTestArray];
    
}
#pragma mark - tableview
-(void)initableviewView{
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,  ScreenWidth, ScreenHeight-SafeAreaBottomHeight-SafeAreaTopHeight-49) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableHeaderView=self.topAdScrollView;
    [self.view addSubview:self.tableView];
    
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(void) {
    //        NSLog(@"下拉刷新");
    //        [self  updataurldata];
    //    }];
    //    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(void) {
    //        [self  uprefreshurldata];
    //    }];
    
}

#pragma mark - buttonClick

-(void)rightAction{
    
    ShopIndexVC*vc=[ShopIndexVC new];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CreatcycleScrollView
-(void)CreatcycleScrollView{
    
    float heardViewH=FitRealValue(360);
    if (IS_IPAD) {
        heardViewH=heardViewH*2/3;
    }
    NSArray*imgary=@[@"detailViewDefaultGaussImage",@"detailViewDefaultGaussImage"];
    self.topAdScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(LeftMargin,0,ScreenWidth-LeftMargin*2,heardViewH) imageNamesGroup:imgary ];
    self.topAdScrollView.delegate = self;
    self.topAdScrollView.autoScrollTimeInterval = 3.f;
    self.topAdScrollView.showPageControl = YES;
    self.topAdScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleNone;
    self.topAdScrollView.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
    [SDCycleScrollView clearImagesCache];
    self.topAdScrollView.layer.masksToBounds = YES;
    
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //    NSDictionary *dict = self.AdAry[index];
    //    WebViewViewController *viewController=[[WebViewViewController alloc]init];
    //    viewController.urlStr = dict[@"appurl"];
    //    viewController.titleStr = dict[@"title"];
    //    viewController.hidesBottomBarWhenPushed=YES;
    //    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titleTestArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *sectionStr = [NSString stringWithFormat:@"%ld",(long)section];
    NSInteger num ;
    //如果selectedArr不包含section，该分组返回number为0；
    if ([self.selectedArr containsObject:sectionStr]) {
        
        num = self.listDataAry.count ;
    }else{
        num = 0;
    }
    return num;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (IS_IPAD) {
        return FitRealValue(100)*2/3;
    }
    else{
        return FitRealValue(100);
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float topViewH=FitRealValue(100);
    if (IS_IPAD) {
        topViewH= FitRealValue(100)*2/3;
    }
    UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,topViewH)];
    topView.backgroundColor=[UIColor whiteColor];
    
    UILabel*nameLab=[MTool quickCreateLabelWithleft:30*SCREEN_WIDTH/750 top:0 width:30 heigh:topViewH title:@"英语"];
    nameLab.font=[UIFont systemFontOfSize:14];
    nameLab.textColor=[MTool colorWithHexString:@"#212121"];
    [topView addSubview:nameLab];
    
    UILabel*titleLab=[MTool quickCreateLabelWithleft:nameLab.right+20*SCREEN_WIDTH/750 top:0 width:SCREEN_WIDTH/750*200 heigh:topViewH title:@""];
    titleLab.font=[UIFont systemFontOfSize:12];
    titleLab.text = self.titleTestArray[section];
    titleLab.textColor=[MTool colorWithHexString:@"#888888"];
    [topView addSubview:titleLab];
    //添加点击事件
    self.cellRightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    self.cellRightBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, topViewH);
    self.cellRightBtn.tag = 100+section;
    [self.cellRightBtn setImageEdgeInsets:UIEdgeInsetsMake(10, SCREEN_WIDTH-(30+34)*SCREEN_WIDTH/750, FitRealValue(30), FitRealValue(30))];
    [self.cellRightBtn setImage:[UIImage imageNamed:@"cellright"] forState:UIControlStateNormal];
    [self.cellRightBtn addTarget:self action:@selector(viewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.cellRightBtn];
    //分割线
    UIView*lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [MTool colorWithHexString:@"#edeff2"];
    [topView addSubview:lineView];
    return topView;
    
}

- (void)viewBtnClick:(UIButton *)btn{
    NSString *string = [NSString stringWithFormat:@"%ld",btn.tag - 100];//点击哪个section
    //    [btn setImage:[UIImage imageNamed:@"attend_ico_up"] forState:UIControlStateNormal];
    
    if (self.selectedArr.count==0){
        [self.selectedArr addObject:string];//为空添加展示cell
        self.tableView.scrollEnabled=YES;
    }
    else if (self.selectedArr.count !=0){
        
        if ([self.selectedArr firstObject]==string ){
            [self.selectedArr removeObjectAtIndex:0];//不为空收回本次cell
            self.tableView.scrollEnabled=NO;
            
        }else{
            [self.selectedArr replaceObjectAtIndex:0 withObject:string];//不为空展示cell
            self.tableView.scrollEnabled=YES;
            
        }
    }
    
    NSLog(@"selectedArr:%@",self.selectedArr);
    [self.tableView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中之后的cell的高度
    
    
    return FitRealValue(80);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell*cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.textLabel.text=self.listDataAry[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"123");
}
@end
