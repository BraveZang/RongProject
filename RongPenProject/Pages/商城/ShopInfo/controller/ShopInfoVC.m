//
//  ShopInfoVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/10.
//

#import "ShopInfoVC.h"
#import "SDCycleScrollView.h"
#import "ShopInfoModel.h"
#import "HaveBuyView.h"
#import "ShopInfoCell.h"

@interface ShopInfoVC ()<UIWebViewDelegate,NetManagerDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property(nonatomic,strong)   UITableView                       *tableview;
@property(nonatomic,strong)   NSMutableArray                    *datAry;
@property(nonatomic,strong)   NetManager                        *net;
@property(nonatomic,strong)   UIView                            *heardview;
@property(nonatomic,strong)   UIView                            *instructionsView;
@property(nonatomic,strong)   UIView                            *footView;
@property(nonatomic,strong)   UILabel                           *moneyLab;
@property(nonatomic,strong)   UILabel                           *nameLab;
@property(nonatomic,strong)   UILabel                           *contentLab;
@property(nonatomic,strong)   UIWebView                         *webView;
@property(nonatomic,strong)   HaveBuyView                       *haveBuyView;
@property(nonatomic,strong)   SDCycleScrollView                 *cycleScrollView;
@property(nonatomic,strong)   ShopInfoModel                     *model;
@property(nonatomic,strong)   NSArray                           *unitlistAry;
@property(nonatomic,strong)   NSArray                           *glteachingAry;
@property(nonatomic,strong)   NSArray                           *googAry;

@end

@implementation ShopInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"商品详情";
    [self initablView];
    [self getData];
}

-(void)setShopindexmodel:(ShopIndexModel *)shopindexmodel{
    _shopindexmodel=shopindexmodel;
}
//-(HaveBuyView*)haveBuyView{
//
//    _haveBuyView=[[HaveBuyView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    return _haveBuyView;
//}
#pragma mark - tableview
-(void)initablView{
    UIButton*buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame=CGRectMake(0, ScreenHeight-SafeAreaBottomHeight-50, ScreenWidth, 50);
    [buyBtn setBackgroundColor:[MTool colorWithHexString:@"#FF4E4E"]];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
    
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,  SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight-50) style:UITableViewStylePlain];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.tableFooterView=[UIView new];
    [self.view addSubview:self.tableview];
    
    
    self.heardview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (540+224)*SCREEN_WIDTH/750+self.tableview.frame.size.height)];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_WIDTH/750*540) imageNamesGroup:nil ];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.autoScrollTimeInterval = 3.f;
    self.cycleScrollView.showPageControl = YES;
    //    self.cycleScrollView.bannerImageViewContentMode=UIViewContentModeScaleAspectFit;
    [SDCycleScrollView clearImagesCache];
    [self.heardview addSubview:self.cycleScrollView];
    
    self.instructionsView=[[UIView alloc]initWithFrame:CGRectMake(0, self.cycleScrollView.bottom, ScreenWidth, FitRealValue(224))];
    self.instructionsView.backgroundColor=[UIColor whiteColor];
    [self.heardview addSubview:self.instructionsView];
    
    self.moneyLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 30*SCREEN_WIDTH/750,ScreenWidth-30, FitRealValue(40))];
    self.moneyLab.font=[UIFont systemFontOfSize:18];
    self.moneyLab.textColor=[MTool colorWithHexString:@"#D12E2E"];
    [self.instructionsView addSubview:self.moneyLab];
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(15, self.moneyLab.bottom+15, ScreenWidth-30,FitRealValue(30))];
    self.nameLab.font=[UIFont systemFontOfSize:14];
    self.nameLab.textColor=[MTool colorWithHexString:@"#212121"];
    [self.instructionsView  addSubview:self.nameLab];
    
    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(15, self.nameLab.bottom+15, ScreenWidth-30,FitRealValue(20))];
    self.contentLab.font=[UIFont systemFontOfSize:12];
    self.contentLab.textColor=[MTool colorWithHexString:@"#888888"];
    [self.instructionsView  addSubview:self.contentLab];
    
    self.footView=[[UIView alloc]initWithFrame:CGRectMake(0, self.instructionsView.bottom,ScreenWidth, self.tableview.frame.size.height)];
    
    UIView*lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    lineview.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    [self.footView addSubview:lineview];
    
    UILabel*footNameLab =[[UILabel alloc]initWithFrame:CGRectMake(5,lineview.bottom, ScreenWidth-10,50)];
    footNameLab.font=[UIFont systemFontOfSize:18];
    footNameLab.textColor=[MTool colorWithHexString:@"#212121"];
    footNameLab.text=@"商品介绍";
    [self.footView  addSubview:footNameLab];
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, footNameLab.bottom, ScreenWidth, ScreenHeight-SafeAreaBottomHeight-SafeAreaTopHeight-100)];
    self.webView.delegate=self;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webView.scalesPageToFit = YES;
    [self.footView addSubview:self.webView];
    [self.heardview addSubview:self.footView];
    self.tableview.tableHeaderView=self.heardview;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.unitlistAry.count;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.unitlistAry.count>0) {
        return FitRealValue(80+90);
    }
    else{
        return 0.01;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.unitlistAry.count>0) {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FitRealValue(80+90))];
        view.backgroundColor=[MTool colorWithHexString:@"#F3F5F8"];
        //buypencilImg
        UIButton*topbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        topbtn.frame=CGRectMake(0, 0, ScreenWidth, FitRealValue(90));
        [topbtn setTitle:@"智能笔购买" forState:UIControlStateNormal];
        [topbtn setTitleColor:[MTool colorWithHexString:@"#F65555"] forState:UIControlStateNormal];
        topbtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [topbtn setImage:[UIImage imageNamed:@"buypencilImg"] forState:UIControlStateNormal];
        [topbtn layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleRight imageTitleSpace:2];
        [view addSubview:topbtn];
        
        UIView*bottomView=[[UIView alloc]initWithFrame:CGRectMake(0,topbtn.bottom, SCREEN_WIDTH, 80*SCREEN_WIDTH/750)];
        bottomView.backgroundColor=[UIColor whiteColor];
        UILabel*celltitlelab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 0, 300, 80*SCREEN_WIDTH/750)];
        celltitlelab.font=[UIFont systemFontOfSize:17];
        celltitlelab.textColor=[MTool colorWithHexString:@"#282828"];
        celltitlelab.text=@"试用章节";
        [bottomView addSubview:celltitlelab];
        [view addSubview:bottomView];
        return view;
    }
    else{
        return nil;
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellIdentifier = @"ShopInfoCell";
    ShopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ShopInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    tableView.rowHeight=90*SCREEN_WIDTH/750;
    NSDictionary*dic=self.unitlistAry[indexPath.row];
    cell.nameLab.text=[NSString stringWithFormat:@"%@",dic[@"name"]];
    cell.moneyLab.text=@"体验点读";
    
    
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
}
#pragma mark === buyBtnClick ===

-(void)buyBtnClick{
    
    __weak typeof(self) weakSelf = self;
    if (self.glteachingAry.count>0) {
        _haveBuyView=[[HaveBuyView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _haveBuyView.click = ^(NSArray * _Nonnull goodAry) {
         weakSelf.googAry=goodAry;
        [weakSelf getOrdersn];
        };
        self.haveBuyView.glteachingAry=self.glteachingAry;
        self.haveBuyView.model=self.model;
        [self.view addSubview: self.haveBuyView];
    }
    else{
        [self getOrdersn];
    }
   
    
}
#pragma mark === NetManagerDelegate ===

- (void)getData{
    
    self.net.requestId=1001;
    [self.net Shop_infoWithId:self.shopindexmodel.id Type:self.shopindexmodel.type];
}

-(void)getOrdersn{
    self.net.requestId=1002;
    User*user=[User getUser];
    [self.net Shop_buyWithUid:user.uid Total:self.model.sprice Goods:self.googAry];
    
}

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    
    NSDictionary*heardDic=result[@"head"];
    NSDictionary*bodyDic=result[@"body"];
    
    if ([heardDic[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:result[@"res_msg"] delay:2];
        return;
    }
    else{
        if (request.requestId==1001) {//
            self.model=[ShopInfoModel mj_objectWithKeyValues:bodyDic];
            self.cycleScrollView.imageURLStringsGroup = self.model.image;
            self.moneyLab.text=[NSString stringWithFormat:@"¥%@",self.model.sprice];
            self.nameLab.text=self.model.name;
            NSURL *url =[NSURL URLWithString:[self.model.details stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [ self.webView loadRequest:[NSURLRequest requestWithURL:url]];
            self.unitlistAry=self.model.unitlist;
            self.glteachingAry=self.model.glteaching;
            
            NSDictionary*dic=@{@"goodsid":self.model.id,
                          @"goodsname":self.model.name,
                          @"price":self.model.sprice,
                          @"type":self.model.type,
              };
            self.googAry=[NSArray arrayWithObject:dic];
            [self.tableview reloadData];
        }
         if (request.requestId==1002) {//
             NSString*idStr=bodyDic[@"id"];
             NSString*ordersnStr=bodyDic[@"ordersn"];

             
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
