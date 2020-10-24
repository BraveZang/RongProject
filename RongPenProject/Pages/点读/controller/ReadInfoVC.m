//
//  ReadInfoVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/24.
//

#import "ReadInfoVC.h"
#import "ReadInfoModel.h"
#import "MapModel.h"
#import "MapDataModel.h"
#import "RightSlidingMenuView.h"
#import "ReadInfoFooterView.h"
#import "SDCycleScrollView.h"//广告轮播图

@interface ReadInfoVC ()<NetManagerDelegate>

@property(nonatomic,strong)   RightSlidingMenuView              *rightslidingmenuview;

@property(nonatomic,strong)   ReadInfoFooterView              *footerView;

@property (nonatomic,strong) SDCycleScrollView                *topAdScrollView;//广告轮播控件


@property (nonatomic,strong)   NetManager                        *net;

@property (nonatomic,strong) ReadInfoModel                  *currentModel;
@end

@implementation ReadInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toptitle.text=@"点读";
    
    self.toptitle.hidden=NO;
    self.leftImgBtn.hidden=NO;
    self.leftImgBtn.hidden=NO;
    [self.rightImgBtn setImage:[UIImage imageNamed:@"toprightbtnimg"] forState:UIControlStateNormal];
    self.rightImgBtn.frame=CGRectMake(ScreenWidth-30, SafeAreaTopHeight-64+(64-15)/2, 30, 30);
    [self.rightImgBtn addTarget:self action:@selector(showRightAction) forControlEvents:UIControlEventTouchUpInside];
    
//    [self creatView];
}


- (void)creatView{
    UIView * bg = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, KSCREEN_WIDTH, KSCREEN_HEIGHT - SafeAreaTopHeight - APP_HEIGHT_6S(56.0))];
    bg.backgroundColor = [MTool colorWithHexString:@"#D3D3D3"];
    [self.view addSubview:bg];

}


-(void)CreatcycleScrollView{
    
    UIView * bg = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, KSCREEN_WIDTH, KSCREEN_HEIGHT - SafeAreaTopHeight - APP_HEIGHT_6S(56.0))];
    bg.backgroundColor = [MTool colorWithHexString:@"#D3D3D3"];
    [self.view addSubview:bg];
    
    //计算屏幕宽高
    float screenWidth = SCREEN_WIDTH - APP_WIDTH_6S(40.0);
    float screenHeight = SCREEN_HEIGHT - SafeAreaTopHeight - APP_HEIGHT_6S(56.0) - APP_HEIGHT_6S(60.0) - APP_HEIGHT_6S(20.0);
    
    //计算宽高比例
    float scaleWidth = _currentModel.width.floatValue/screenWidth;
    float scaleHeight = _currentModel.heigth.floatValue/screenHeight;
    
    //执行比例
    float scale = _currentModel.width.floatValue/screenWidth > _currentModel.heigth.floatValue/screenHeight?_currentModel.width.floatValue/screenWidth:_currentModel.heigth.floatValue/screenHeight;


    //根据宽高比例   计算地图在屏幕上的尺寸
    
    float heardViewW = _currentModel.width.floatValue/scale;
    float heardViewH = _currentModel.heigth.floatValue/scale;

   
    
    
    //组装图片数组
    NSMutableArray * imageArray = [[NSMutableArray alloc] initWithCapacity:_currentModel.list.count];
    for (NSInteger i = 0; i < _currentModel.list.count; i++) {
        MapModel * model = _currentModel.list[i];
        [imageArray addObject:model.ditu];
    }
    
    
    
    self.topAdScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(APP_WIDTH_6S(20.0),APP_HEIGHT_6S(20.0),heardViewW,heardViewH) imageNamesGroup:imageArray ];
    
    self.topAdScrollView.autoScrollTimeInterval = 99999999.f;
    self.topAdScrollView.autoScroll = NO;
    self.topAdScrollView.infiniteLoop = NO;
    self.topAdScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleNone;
    self.topAdScrollView.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
    [SDCycleScrollView clearImagesCache];
    self.topAdScrollView.layer.masksToBounds = YES;
    
    [bg addSubview:_topAdScrollView];
    
    [self.topAdScrollView makeScrollViewScrollToIndex:7];

    
}


- (void)setUnitModel:(UnitModel *)unitModel{
    _unitModel = unitModel;
    //测试数据 待调整
    [self.net getMain_jfinfoWithUid:[User getUserID] Unitid:unitModel.unitid andBookId:unitModel.bookid];
}

- (void)setBookModel:(MainBookModel *)bookModel{
    _bookModel = bookModel;
    self.rightslidingmenuview.unitList = bookModel.unitlist;
}


- (void)showRightAction
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.rightslidingmenuview];
}


#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        NSDictionary*body=result[@"body"];
        self.currentModel = [ReadInfoModel mj_objectWithKeyValues:body];
        self.footerView.infoModel = _currentModel;
        [self CreatcycleScrollView];
    }
    
}

- (void)requestError:(NetManager *)request error:(NSError*)error{
    
}

- (void)requestStart:(NetManager *)request{
    
}

#pragma mark  -lazy

- (RightSlidingMenuView *)rightslidingmenuview {
    if (!_rightslidingmenuview) {
        _rightslidingmenuview = [[RightSlidingMenuView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _rightslidingmenuview.type = 2;
        _rightslidingmenuview.seletedUnitblock = ^(UnitModel * _Nonnull unitModel) {
            
            [self.net getMain_jfinfoWithUid:[User getUserID] Unitid:unitModel.bookid andBookId:unitModel.unitid];
        
        };
    }
    return _rightslidingmenuview;
}

- (ReadInfoFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[ReadInfoFooterView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - APP_HEIGHT_6S(56.0), KSCREEN_WIDTH, APP_HEIGHT_6S(56.0))];
        _footerView.seletedUnitblock = ^(NSInteger index) {
            [self.topAdScrollView makeScrollViewScrollToIndex:index];
        };
        [self.view addSubview:_footerView];
    }
    return _footerView;
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
