//
//  CheckpointVC.m
//  RongPenProject
//
//  Created by mac on 3.11.20.
//

#import "CheckpointVC.h"
#import "AnswerModel.h"
//#import <QuestionInputUI/QuestionInputUI.h>
#import "CheckpointCollCell.h"

@interface CheckpointVC ()<NetManagerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NetManager                          *net;
@property (nonatomic,strong) NSArray                             *answerList;
@property (nonatomic,strong) UIButton                            *subBtn;
@property (nonatomic,strong) UIProgressView                      *progressView;
@property (nonatomic,strong) UILabel                             *numlab;
@property (nonatomic,strong) UIImageView                         *ximg;
@property (nonatomic,strong) UILabel                             *totallab;
@property (strong,nonatomic) UICollectionView                    *ShowCollectionView;
@property (assign,nonatomic) NSInteger                           currentIndex;

@end

@implementation CheckpointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self getUrlData];
}

- (void)creatUI{
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bg.userInteractionEnabled = YES;
    bg.image = [UIImage imageNamed:@"checkPoint_BG"];
    [self.view addSubview:bg];
    
    self.leftImgBtn.hidden=NO;
    self.leftImgBtn.frame=CGRectMake(10, SafeAreaTopHeight-64+(64-30)/2, 60, 30);
    [self.leftImgBtn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [self.view addSubview:self.leftImgBtn];
    
    UILabel*titleLab=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-284, SafeAreaTopHeight-64+30, 300, 36)];
    titleLab.cornerRadius=20;
    titleLab.backgroundColor=rgb(242, 154, 92);
    titleLab.text=@"     点击空格在纸上书写内容～";
    titleLab.textColor=[MTool colorWithHexString:@"#9A4304"];
    titleLab.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:titleLab];
    
    [self CreateCollectionView];
    [bg addSubview:self.subBtn];

    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(30,APP_HEIGHT_6S(72.0) + StatusBarHight+50,ScreenWidth-60-50, 14)];
    //滑轮左边颜色，如果设置了左边的图片就不会显示
    _progressView.progressTintColor = [MTool colorWithHexString:@"#FF5757"];
    //滑轮右边颜色，如果设置了左边的图片就不会显示
    [_progressView setTrackTintColor:[MTool colorWithHexString:@"#FFDDCF"]];
    _progressView.progressViewStyle = UIProgressViewStyleBar;
    _progressView.progress=0.1;
    [self.view addSubview:self.progressView];

    self.ximg=[[UIImageView alloc]initWithFrame:CGRectMake(30+_progressView.size.width/5-24,_progressView.origin.y-10, 24, 24)];
    [ self.ximg setImage:[UIImage imageNamed:@"ximg"]];
    [self.view addSubview: self.ximg];

    self.numlab=[[UILabel alloc]initWithFrame:CGRectMake(_progressView.right, APP_HEIGHT_6S(72.0) + StatusBarHight+40, 60, 24)];
    self.numlab.textColor=[MTool colorWithHexString:@"#9A4304"];
    self.numlab.font=[UIFont systemFontOfSize:17];
    self.numlab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview: self.numlab];

}

-(void)CreateCollectionView{

    float viewW=ScreenWidth-10*2;
    float viewH=FitRealValue(910);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(viewW,viewH);
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
    
    _ShowCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(10,APP_HEIGHT_6S(72.0) + StatusBarHight,ScreenWidth-20,FitRealValue(910))collectionViewLayout:layout];
    _ShowCollectionView.delegate=self;
    _ShowCollectionView.dataSource=self;
    _ShowCollectionView.tag=101;
    _ShowCollectionView.showsHorizontalScrollIndicator = NO;
    _ShowCollectionView.backgroundColor=[UIColor clearColor];
    [_ShowCollectionView registerClass:[CheckpointCollCell class] forCellWithReuseIdentifier: @"CheckpointCollCell"];
   
    
    [self.view addSubview:_ShowCollectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  self.answerList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CheckpointCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CheckpointCollCell" forIndexPath:indexPath];
  
    cell.model=self.answerList[indexPath.row];
        return cell;
    
}
// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    //1.根据偏移量判断一下应该显示第几个item
    CGFloat offSetX = targetContentOffset->x;

    CGFloat itemWidth = ScreenWidth-20;

    //item的宽度+行间距 = 页码的宽度
    NSInteger pageWidth = itemWidth + 10;

    //根据偏移量计算是第几页
    NSInteger pageNum = (offSetX+pageWidth/2)/pageWidth;

    //2.根据显示的第几个item，从而改变偏移量
    targetContentOffset->x = pageNum*pageWidth;

    self.currentIndex = pageNum;

    self.numlab.text=[NSString stringWithFormat:@"%ld/%ld",self.currentIndex+1,self.answerList.count];
       _progressView.progress =1+self.currentIndex/self.answerList.count;
       self.ximg.frame=CGRectMake(30+_progressView.size.width/self.answerList.count*(self.currentIndex+1)-24,_progressView.origin.y-10, 24, 24);
       NSString*str1=[NSString stringWithFormat:@"%0.1ld",self.currentIndex+1];
       NSString*str2=[NSString stringWithFormat:@"%ld",self.answerList.count];
       _progressView.progress=str1.floatValue/str2.floatValue;
}

-(void)setModel:(gkModel *)model{
    _model = model;
    
    //    [self.net Pass_cntoeninfoWithUid:[User getUserID] andBookId:model.bookid Unitid:model.unitid andGqid:model.gqid];
    
}
-(void)getUrlData{
    
    [self.net Pass_cntoeninfoWithUid:@"1" andBookId:@"3" Unitid:@"1" andGqid:@"6"];
}
#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        
        //填空列表
        NSArray * dataArray = result[@"body"];
        self.answerList = [AnswerModel mj_objectArrayWithKeyValuesArray:dataArray];
        [self.ShowCollectionView reloadData];

        NSString*str1=@"1";
        NSString*str2=[NSString stringWithFormat:@"%ld", self.answerList.count];
        _progressView.progress=str1.floatValue/str2.floatValue;
        self.numlab.text=[NSString stringWithFormat:@"1/%ld", self.answerList.count];
    }
    
}

- (void)requestError:(NetManager *)request error:(NSError*)error{
    
}

- (void)requestStart:(NetManager *)request{
    
}

#pragma mark -lazy
- (NetManager *)net{
    if (!_net) {
        self.net = [[NetManager alloc] init];
        _net.delegate = self;
    }
    return _net;
}

- (UIButton *)subBtn{
    if (!_subBtn) {
        _subBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _subBtn.frame=CGRectMake(APP_WIDTH_6S(95.0),self.ShowCollectionView.bottom + APP_HEIGHT_6S(10.0), APP_WIDTH_6S(186.0), APP_HEIGHT_6S(48.0));
        [_subBtn setTitle:@"答题完成"forState:UIControlStateNormal];
        [_subBtn setBackgroundImage:[UIImage imageNamed:@"answer_button"] forState:UIControlStateNormal];
        [_subBtn setTitleColor:[MTool colorWithHexString:@"#04847A"] forState:UIControlStateNormal];
        _subBtn.titleLabel.font=[UIFont systemFontOfSize:APP_HEIGHT_6S(20.0)];
        
    }
    return _subBtn;
}



@end
