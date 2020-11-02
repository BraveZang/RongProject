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
#import "MainBookModel.h"
#import "UnitModel.h"
#import "BannerModel.h"
#import "ReadInfoVC.h"
@interface ReadIndexVC ()<NetManagerDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SDCycleScrollView                *topAdScrollView;//广告轮播控件
@property (nonatomic,strong) UITableView                      *tableView;
@property (nonatomic,strong) UIView                           *heardView;
@property (nonatomic,strong) NSArray                          *titleTestArray;//分组
@property (nonatomic,strong) NSMutableArray                   *selectedArr;//存储需要展开的cell组
@property (nonatomic,strong) NSMutableArray                   *listDataAry;//存储需要展开的cell组
@property (nonatomic,strong) UIButton                         *cellRightBtn;

@property(nonatomic,strong)   NetManager                        *net;
@property(nonatomic,strong)   NetManager                        *bannerNet;



@property (nonatomic, strong) NSArray                           *bookList;
@property (nonatomic, strong) NSArray                           *bannerList;

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
    
//    [self CreatcycleScrollView];
    [self initableviewView];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)getData{
    self.net.requestId = 1001;
    [self.net getMain_buybookWithUid:[User getUserID]];
    
    //
    [self.bannerNet main_banner];
}


#pragma mark - tableview
-(void)initableviewView{
    
    self.selectedArr =[NSMutableArray arrayWithCapacity:0];
    self.listDataAry =[NSMutableArray arrayWithCapacity:0];
    
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
    
    return self.bookList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *sectionStr = [NSString stringWithFormat:@"%ld",(long)section];
    NSInteger num ;
    //如果selectedArr不包含section，该分组返回number为0；
    if ([self.selectedArr containsObject:sectionStr]) {
        MainBookModel * model = self.bookList[section];

        self.listDataAry = [NSMutableArray arrayWithArray:model.unitlist];
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
    MainBookModel * model = self.bookList[section];
    titleLab.text = model.goodsname;
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
    cell.backgroundColor = [UIColor colorWithHexColorString:@"F3F5F8"];
    UnitModel * unitModel = self.listDataAry[indexPath.row];

    cell.textLabel.text=unitModel.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReadInfoVC*vc=[ReadInfoVC new];
    vc.unitModel = self.listDataAry[indexPath.row];
    NSInteger seletedSection = [self.selectedArr[0] intValue];
    vc.bookModel = self.bookList[seletedSection];
    vc.hidesBottomBarWhenPushed=YES;
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
        
        if (request == _bannerNet) {
            //轮播图
            NSArray * dataArray = result[@"body"];
            self.bannerList = [BannerModel mj_objectArrayWithKeyValuesArray:dataArray];
            //组装图片数组
            NSMutableArray * imageArray = [[NSMutableArray alloc] initWithCapacity:_bannerList.count];
            for (NSInteger i = 0; i < _bannerList.count; i++) {
                BannerModel * model = _bannerList[i];
                [imageArray addObject:model.imgurl];
            }
            self.topAdScrollView.imageURLStringsGroup = imageArray;
        }else if (request == _net) {
//            if (self.net.requestId==1001) {
                //辅材列表
                NSArray * dataArray = result[@"body"];
                self.bookList = [MainBookModel mj_objectArrayWithKeyValuesArray:dataArray];
                [self.tableView reloadData];
//            }
        }
        
        
        
    }
    
}

- (void)requestError:(NetManager *)request error:(NSError*)error{
    
}

- (void)requestStart:(NetManager *)request{
    
}

#pragma mark  -lazy
- (NetManager *)net{
    if (!_net) {
        self.net = [[NetManager alloc] init];
        _net.delegate = self;
    }
    return _net;
}

- (NetManager *)bannerNet{
    if (!_bannerNet) {
        _bannerNet = [[NetManager alloc] init];
        _bannerNet.delegate = self;
    }
    return _bannerNet;
}

- (NSArray *)bookList{
    if (!_bookList) {
        _bookList = [[NSArray alloc] init];
    }
    return _bookList;
}




@end
