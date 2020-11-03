//
//  PracticeIndexVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//

#import "PracticeIndexVC.h"
#import "PracticeIndexCell.h"
#import "PracticeIndex1Cell.h"
#import "PracticeIndex2Cell.h"

@interface PracticeIndexVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) UICollectionView       *ShowCollectionView;

@end

@implementation PracticeIndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topview.hidden=NO;
    self.view.backgroundColor=rgb(243, 245, 248);
    // Do any additional setup after loading the view.
    [self CreateCollectionView];
}
-(void)CreateCollectionView{
    
    
    
    
    float viewW=ScreenWidth-LeftMargin*2;
    float viewH=ScreenHeight-FitRealValue(80)*2-SafeAreaBottomHeight-SafeAreaTopHeight-49;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(viewW,viewH);
    layout.minimumLineSpacing = LeftMargin;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
    
    _ShowCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(LeftMargin,SafeAreaTopHeight+FitRealValue(80), ScreenWidth-LeftMargin*2,viewH)collectionViewLayout:layout];
    _ShowCollectionView.delegate=self;
    _ShowCollectionView.dataSource=self;
    _ShowCollectionView.tag=101;
    _ShowCollectionView.showsHorizontalScrollIndicator = NO;
    _ShowCollectionView.backgroundColor=[UIColor clearColor];
    [_ShowCollectionView registerClass:[PracticeIndexCell class] forCellWithReuseIdentifier: @"PracticeIndexCell"];
    [_ShowCollectionView registerClass:[PracticeIndex1Cell class] forCellWithReuseIdentifier: @"PracticeIndex1Cell"];
    [_ShowCollectionView registerClass:[PracticeIndex2Cell class] forCellWithReuseIdentifier: @"PracticeIndex2Cell"];
    
    [self.view addSubview:_ShowCollectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item==0) {
        
        PracticeIndexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PracticeIndexCell" forIndexPath:indexPath];
        return cell;
    }
    else  if (indexPath.item==1){
        
        PracticeIndex1Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PracticeIndex1Cell" forIndexPath:indexPath];
        return cell;
    }
    else{
        
        PracticeIndex2Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PracticeIndex2Cell" forIndexPath:indexPath];
        return cell;
    }
    
    
}
// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end
