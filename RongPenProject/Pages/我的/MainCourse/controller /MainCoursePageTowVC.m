//
//  MainCoursePageOneVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/18.
//

#import "MainCoursePageTowVC.h"
#import "CourseVideoCollCell.h"
@interface MainCoursePageTowVC ()<NetManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView* NoDataView;
    
}
@property (strong, nonatomic) UICollectionView   *ShowCollectionView;
@property (strong, nonatomic) NSMutableArray     *datAry;
@property (nonatomic, strong) NetManager         *net;
@property (nonatomic, assign) NSInteger          page;
@property (nonatomic, assign) BOOL               isfresh;

@end

@implementation MainCoursePageTowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datAry=[NSMutableArray arrayWithCapacity:0];
    [self createCollectionView];
    [self refresh];
}

-(void)createCollectionView{
    
    float viewH=FitRealValue(280);
    float viewW=(ScreenWidth-45)/2;
    float ImgH=FitRealValue(220);
    
    if (IS_IPAD) {
        viewH=viewW*2/3;
        ImgH=ImgH*2/3;
    }
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(viewW, viewH);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _ShowCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(15,0, SCREEN_WIDTH-30,ScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight-50)collectionViewLayout: layout];
    _ShowCollectionView.delegate=self;
    _ShowCollectionView.dataSource=self;
    _ShowCollectionView.tag=101;
    self.ShowCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(void) {
        NSLog(@"下拉刷新");
        [self refresh];
    }];
    self.ShowCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉加载更多");
        [self loadMore];
    }];
    _ShowCollectionView.backgroundColor=[UIColor clearColor];
    [_ShowCollectionView registerClass:[CourseVideoCollCell class] forCellWithReuseIdentifier: @"CourseVideoCollCell"];
    [self.view addSubview:_ShowCollectionView];
    //无数据时候的显示
    NoDataView=[[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT- SafeAreaTopHeight-SafeAreaBottomHeight-300*SCREEN_WIDTH/750)];
    NoDataView.backgroundColor=[UIColor whiteColor];
    UIImageView*img=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-662*SCREEN_WIDTH/750)/2, 300*SCREEN_WIDTH/750, 662*SCREEN_WIDTH/750, 398*SCREEN_WIDTH/750)];
    [img setImage:[UIImage imageNamed:@""]];
    [NoDataView addSubview:img];
    
    UILabel*lab=[MTool quickCreateLabelWithleft:0 top:img.bottom width:SCREEN_WIDTH heigh:50*SCREEN_WIDTH/750 title:@"暂无相关信息~"];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:14];
    lab.textColor=[MTool colorWithHexString:@"999999"];
    [NoDataView addSubview:lab];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.datAry.count == 0) {
        UIView *backgroundImageView = NoDataView;
        self.ShowCollectionView.backgroundView = backgroundImageView;
        self.ShowCollectionView.backgroundView.contentMode = UIViewContentModeCenter;
    } else {
        self.ShowCollectionView.backgroundView = nil;
    }
    return self.datAry.count;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat height=0;
    return CGSizeMake(SCREEN_WIDTH,height);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CourseVideoCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CourseVideoCollCell" forIndexPath:indexPath];
    cell.model=self.datAry[indexPath.item];
    return cell;
}
#pragma mark - UICollectionViewDelegate
// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CourseVideoModel*model=self.datAry[indexPath.item];
    self.tiemClickBlock(model);
   
}



- (void)refresh {
    _page = 1;
    [self getDataArrayFromServerIsRefresh:YES];
}
- (void)loadMore {
    _page = _page + 1;
    [self getDataArrayFromServerIsRefresh:NO];
}
- (void)getDataArrayFromServerIsRefresh:(BOOL)isRefresh {
    self.isfresh=isRefresh;
    self.net.requestId=1001;
    [self.net  Course_indexWithPage:[NSString stringWithFormat:@"%ld",(long)_page] Type:@"直播"];
    
}
#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    
    [self.ShowCollectionView.mj_header endRefreshing];
    [self.ShowCollectionView.mj_footer endRefreshing];
    NSDictionary*headDic=result[@"head"];
    if ([headDic[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:headDic[@"res_msg"] delay:2];
        return;
    }
    else{
        if (self.net.requestId==1001) {
            NSArray*bodyAry=result[@"body"];
            if (self.isfresh==YES) {
                self.datAry=[NSMutableArray arrayWithCapacity:0];
            }
            for(NSDictionary*dic in bodyAry){
                CourseVideoModel*model=[CourseVideoModel mj_objectWithKeyValues:dic];
                [self.datAry addObject:model];
            }
            [self.ShowCollectionView reloadData];
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
