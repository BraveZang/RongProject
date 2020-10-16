//
//  ShopIndexVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/10.
//

#import "ShopIndexVC.h"
#import "ShopIndexCell.h"
#import "ShopIndexModel.h"
#import "ShopInfoVC.h"

@interface ShopIndexVC ()<NetManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView   *ShowCollectionView;
@property (strong, nonatomic) NSMutableArray     *datAry;
@property (nonatomic, strong) NetManager         *net;

@end

@implementation ShopIndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[MTool colorWithHexString:@"#F3F5F8"];
    self.leftImgBtn.hidden=NO;
    [self.leftImgBtn setImage:nil forState:UIControlStateNormal];
    [self.leftImgBtn setTitle:@"订单管理" forState:UIControlStateNormal];
    [self.leftImgBtn setTitleColor:[MTool colorWithHexString:@"#3777DE"] forState:UIControlStateNormal];
    self.leftImgBtn.frame=CGRectMake(10, SafeAreaTopHeight-64+(64-15)/2, 60, 30);

    [self.rightImgBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    self.rightImgBtn.hidden=NO;
    self.topview.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"荣知商城";
    self.datAry=[NSMutableArray arrayWithCapacity:0];
    [self createCollectionView];
    [self getUrlData];
}

-(void)createCollectionView{
    
    float viewH=FitRealValue(212*2);
    float viewW=(ScreenWidth-30)/2;
//    if (IS_IPAD) {
//        viewH=viewW*2/3;
//    }
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(viewW, viewH);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _ShowCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(10,SafeAreaTopHeight+10, SCREEN_WIDTH-20,ScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight-10)collectionViewLayout: layout];
    _ShowCollectionView.delegate=self;
    _ShowCollectionView.dataSource=self;
    _ShowCollectionView.tag=101;
    _ShowCollectionView.backgroundColor=[UIColor clearColor];
    [_ShowCollectionView registerClass:[ShopIndexCell class] forCellWithReuseIdentifier: @"ShopIndexCell"];
    [self.view addSubview:_ShowCollectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.datAry.count;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat height=0;
    return CGSizeMake(SCREEN_WIDTH,height);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopIndexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopIndexCell" forIndexPath:indexPath];
    cell.model=self.datAry[indexPath.item];
    return cell;
}
#pragma mark - UICollectionViewDelegate
// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopIndexModel*model=self.datAry[indexPath.item];
    ShopInfoVC*vc=[ShopInfoVC new];
    vc.shopindexmodel=model;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)getUrlData{
    
    [self.net  Shop_indexWithNoParam];
}
#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    NSDictionary*headDic=result[@"head"];
    if ([headDic[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:headDic[@"res_msg"] delay:2];
        return;
    }
    else{
        NSArray*bodyAry=result[@"body"];
        for(NSDictionary*dic in bodyAry){
            ShopIndexModel*model=[ShopIndexModel mj_objectWithKeyValues:dic];
            [self.datAry addObject:model];
        }
        [self.ShowCollectionView reloadData];
     
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
