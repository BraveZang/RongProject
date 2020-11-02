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
#import "VoiceModel.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ReadInfoItemView.h"
#import "ReadTestVC.h"
@interface ReadInfoVC ()<NetManagerDelegate,SDCycleScrollViewDelegate>

@property(nonatomic,strong)   RightSlidingMenuView              *rightslidingmenuview;


@property(nonatomic,strong)   ReadInfoItemView                *itemView;

@property(nonatomic,strong)   ReadInfoFooterView              *footerView;

@property (nonatomic,strong) SDCycleScrollView                *topAdScrollView;//广告轮播控件

@property (nonatomic, assign) float scale;
@property (nonatomic, assign) float mapViewW;
@property (nonatomic, assign) float mapViewH;
@property (nonatomic,strong) UIView                      *PointView;
@property (nonatomic,strong) NSMutableArray              *pointArray;




@property (nonatomic,strong)   NetManager                        *net;

@property (nonatomic,strong)   NetManager                        *voiceNet;


@property (nonatomic,strong) ReadInfoModel                  *currentModel;
@property (nonatomic,strong) MapDataModel                   *currentMapModel;

@property (nonatomic,strong) NSArray                        *voiceList;
@property (nonatomic,strong) NSMutableArray                        *voiceUrlList;

@property (nonatomic,assign) NSInteger                      currentPage;



@property (nonatomic, strong) AVPlayer          *player;
@end

@implementation ReadInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toptitle.text=@"点读";
    
    self.toptitle.hidden=NO;
    self.leftImgBtn.hidden=NO;
    self.rightImgBtn.hidden=NO;
    [self.rightImgBtn setImage:[UIImage imageNamed:@"toprightbtnimg"] forState:UIControlStateNormal];
    self.rightImgBtn.frame=CGRectMake(ScreenWidth-30, SafeAreaTopHeight-64+(64-15)/2, 30, 30);
    [self.rightImgBtn addTarget:self action:@selector(showRightAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.currentPage = 0;
}



-(void)CreatcycleScrollView{
    
    UIView * bg = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, KSCREEN_WIDTH, KSCREEN_HEIGHT - SafeAreaTopHeight - APP_HEIGHT_6S(56.0))];
    bg.backgroundColor = [MTool colorWithHexString:@"#D3D3D3"];
    [self.view addSubview:bg];
    
    //计算屏幕宽高
    float screenWidth = SCREEN_WIDTH - APP_WIDTH_6S(40.0);
    float screenHeight = SCREEN_HEIGHT - SafeAreaTopHeight - APP_HEIGHT_6S(56.0) - APP_HEIGHT_6S(60.0) - APP_HEIGHT_6S(20.0);
    
//    //计算宽高比例
//    float scaleWidth = _currentModel.width.floatValue/screenWidth;
//    float scaleHeight = _currentModel.heigth.floatValue/screenHeight;
    
    //执行比例
    self.scale = _currentModel.width.floatValue/screenWidth > _currentModel.heigth.floatValue/screenHeight?_currentModel.width.floatValue/screenWidth:_currentModel.heigth.floatValue/screenHeight;


    //根据宽高比例   计算地图在屏幕上的尺寸
    
    self.mapViewW = _currentModel.width.floatValue/_scale;
    self.mapViewH = _currentModel.heigth.floatValue/_scale;

   
    
    
    //组装图片数组
    NSMutableArray * imageArray = [[NSMutableArray alloc] initWithCapacity:_currentModel.list.count];
    for (NSInteger i = 0; i < _currentModel.list.count; i++) {
        MapModel * model = _currentModel.list[i];
        [imageArray addObject:model.ditu];
    }
    
    if (_pointArray.count == 0) {
        self.topAdScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(APP_WIDTH_6S(20.0),APP_HEIGHT_6S(20.0),_mapViewW,_mapViewH) imageNamesGroup:imageArray ];
        self.topAdScrollView.autoScrollTimeInterval = 99999999.f;
        self.topAdScrollView.autoScroll = NO;
        self.topAdScrollView.infiniteLoop = NO;
        self.topAdScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleNone;
        self.topAdScrollView.delegate = self;
        self.topAdScrollView.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
        [SDCycleScrollView clearImagesCache];
        self.topAdScrollView.layer.masksToBounds = YES;
        [bg addSubview:_topAdScrollView];
    }
    
    if (self.itemView == nil) {
        self.itemView = [[ReadInfoItemView alloc] initWithFrame:CGRectMake(0, bg.height - APP_HEIGHT_6S(60.0), KSCREEN_WIDTH, APP_HEIGHT_6S(60.0))];
        _itemView.playBtnblock = ^{
            [[DDAVPlayer shareInstance] playWithUrlStr:@"http://39.98.227.235/Uploads/mp3/5.mp3"];

        };
        _itemView.helpBtnblock = ^{

        };
        
        _itemView.readBtnblock = ^{
            ReadTestVC *testVC = [[ReadTestVC alloc] init];
            testVC.unitModel = _unitModel;
            testVC.mapModel = _currentMapModel;
            [self.navigationController pushViewController:testVC animated:YES];
        };
        
        [bg addSubview:_itemView];
    }
    
    self.topAdScrollView.imageURLStringsGroup = imageArray;
    
    
    
}

- (void)readClick:(UIButton *)sender{
    MapModel * model1 = _currentModel.list[_currentPage];
    self.currentMapModel = model1.data[sender.tag - 100];
 
    for (VoiceModel * voiceModel in self.voiceList) {
        NSString * voiceId = [voiceModel.name substringToIndex:[voiceModel.name rangeOfString:@"."].location];
        if ([voiceId isEqualToString:_currentMapModel.dianduid]) {
            //播放音频
            [[DDAVPlayer shareInstance] playWithUrlStr:voiceModel.url];
            break;;
        }
    }
    
    
}



- (void)updateMap{
    
//    [self.topAdScrollView removeAllSubviews];
    
    if (self.pointArray.count > 0) {
        for (NSInteger i = 0; i < _pointArray.count; i++) {
           UIButton * btn = [self.topAdScrollView viewWithTag:[self.pointArray[i]integerValue]];
            [btn removeFromSuperview];
        }
    }
    [self.pointArray removeAllObjects];
    
    
    MapModel * mapModel = _currentModel.list[_currentPage];
    for (NSInteger i = 0; i < mapModel.data.count; i++) {
        MapDataModel * mapDataModel = mapModel.data[i];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(readClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(mapDataModel.x.floatValue/_scale, mapDataModel.y.floatValue/_scale, mapDataModel.w.floatValue/_scale, mapDataModel.h.floatValue/_scale);
        btn.tag = 100+i;
        [self.pointArray addObject:[NSString stringWithFormat:@"%d",btn.tag]];
        btn.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:1 alpha:0.5];
        [self.topAdScrollView addSubview:btn];
    }
}



- (void)setUnitModel:(UnitModel *)unitModel{
    _unitModel = unitModel;

    [self getUnitData];

}

- (void)setBookModel:(MainBookModel *)bookModel{
    _bookModel = bookModel;
    self.rightslidingmenuview.unitList = bookModel.unitlist;
}





/// 获取单元数据及音频
- (void)getUnitData{
    [self.net getMain_jfinfoWithUid:[User getUserID] Unitid:_unitModel.unitid andBookId:_unitModel.bookid];
    [self.voiceNet main_downMP3urlWithUnitid:_unitModel.unitid andBookId:_unitModel.bookid];
}

- (void)showRightAction
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.rightslidingmenuview];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.currentPage = index;
    [self updateMap];
}


#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{

        if (request == _net) {
            NSDictionary*body=result[@"body"];
            self.currentModel = [ReadInfoModel mj_objectWithKeyValues:body];
            self.currentPage = 0;
            MapModel * model1 = _currentModel.list[0];
            self.currentMapModel = model1.data[0];
            self.footerView.infoModel = _currentModel;
            [self CreatcycleScrollView];
            [self updateMap];
        }else if (request == _voiceNet) {
            NSArray * dataArray = result[@"body"];
            self.voiceList = [VoiceModel mj_objectArrayWithKeyValuesArray:dataArray];
            self.voiceUrlList = [[NSMutableArray alloc] initWithCapacity:_voiceList.count];
            for (VoiceModel * model in self.voiceList) {
                [self.voiceUrlList addObject:model.url];
            }
        }
        
       
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
            
            [self getUnitData];
        
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

- (NetManager *)voiceNet{
    if (!_voiceNet) {
        _voiceNet = [[NetManager alloc] init];
        _voiceNet.delegate = self;
    }
    return _voiceNet;
}


- (NSArray *)voiceList{
    if (!_voiceList) {
        _voiceList = [[NSArray alloc] init];
    }
    return _voiceList;
}

- (NSMutableArray *)pointArray{
    if (!_pointArray) {
        _pointArray = [[NSMutableArray alloc] init];
    }
    return _pointArray;
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
