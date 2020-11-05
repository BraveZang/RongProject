//
//  CheckpointVC.m
//  RongPenProject
//
//  Created by mac on 3.11.20.
//

#import "CheckpointVC.h"
#import "AnswerModel.h"
#import "SDCycleScrollView.h"//广告轮播图

@interface CheckpointVC ()<NetManagerDelegate,SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView                   *topAdScrollView;//广告轮播控件
@property (nonatomic,strong) NetManager                          *net;
@property (nonatomic,strong) NSArray                             *answerList;
@property (nonatomic,strong) UIButton                            *subBtn;
@property (nonatomic,strong) UIProgressView                      *progressView;
@property (nonatomic,strong) UILabel                             *numlab;
@property (nonatomic,strong) UIImageView                         *ximg;
@property (nonatomic,strong) UILabel                             *totallab;


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
    
    self.topAdScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(APP_WIDTH_6S(8.0),APP_HEIGHT_6S(72.0) + StatusBarHight,APP_WIDTH_6S(359.0),FitRealValue(910)) imageNamesGroup:nil ];
    self.topAdScrollView.backgroundColor =[UIColor clearColor];
    self.topAdScrollView.autoScrollTimeInterval = 99999999.f;
    self.topAdScrollView.autoScroll = NO;
    self.topAdScrollView.infiniteLoop = NO;
    self.topAdScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleNone;
    self.topAdScrollView.delegate = self;
    self.topAdScrollView.bannerImageViewContentMode=UIViewContentModeScaleToFill;
    [SDCycleScrollView clearImagesCache];
    //    self.topAdScrollView.layer.masksToBounds = YES;
    [bg addSubview:_topAdScrollView];
    [bg addSubview:self.subBtn];
    
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(30,50,ScreenWidth-60-50, 14)];
    //滑轮左边颜色，如果设置了左边的图片就不会显示
    _progressView.progressTintColor = [MTool colorWithHexString:@"#FF5757"];
    //滑轮右边颜色，如果设置了左边的图片就不会显示
    [_progressView setTrackTintColor:[MTool colorWithHexString:@"#FFDDCF"]];
    _progressView.progressViewStyle = UIProgressViewStyleBar;
    _progressView.progress=0.1;
    [self.topAdScrollView addSubview:self.progressView];
    
    self.ximg=[[UIImageView alloc]initWithFrame:CGRectMake(30+_progressView.size.width/5-24, 40, 24, 24)];
    [ self.ximg setImage:[UIImage imageNamed:@"ximg"]];
    [self.topAdScrollView addSubview: self.ximg];
    
    self.numlab=[[UILabel alloc]initWithFrame:CGRectMake(_progressView.right, 40, 60, 24)];
    self.numlab.textColor=[MTool colorWithHexString:@"#9A4304"];
    self.numlab.font=[UIFont systemFontOfSize:17];
    self.numlab.textAlignment=NSTextAlignmentCenter;
    [self.topAdScrollView addSubview: self.numlab];
    
//    self.totallab=[[UILabel alloc]initWithFrame:CGRectMake(30, self.numlab.bottom+10, self.topAdScrollView.size.width-60, 0)];
//    self.totallab.numberOfLines=0;
//    self.totallab.textColor=[MTool colorWithHexString:@"#9A4304"];
//    self.totallab.font=[UIFont systemFontOfSize:26];
//    [self.topAdScrollView addSubview: self.totallab];

}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    
    self.numlab.text=[NSString stringWithFormat:@"%ld/%ld",index+1,self.answerList.count];
    _progressView.progress =1+index/self.answerList.count;
    self.ximg.frame=CGRectMake(30+_progressView.size.width/self.answerList.count*(index+1)-24, 40, 24, 24);
    NSString*str1=[NSString stringWithFormat:@"%0.1ld",index+1];
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
        NSMutableArray * imageArray = [[NSMutableArray alloc] initWithCapacity:self.answerList.count];
        for (NSInteger i = 0; i < self.answerList.count; i++) {
            [imageArray addObject:@"answerBG"];
            AnswerModel*model=self.answerList[i];
           UILabel*totallab=[[UILabel alloc]initWithFrame:CGRectMake(30, self.numlab.bottom+10, self.topAdScrollView.size.width-60, 0)];
            totallab.numberOfLines=0;
            totallab.textColor=[MTool colorWithHexString:@"#9A4304"];
            totallab.font=[UIFont systemFontOfSize:26];
            [self.topAdScrollView addSubview: self.totallab];
            float height=[model.en heightWithText:model.en font:[UIFont systemFontOfSize:26] width:self.topAdScrollView.size.width-60];
            totallab.frame=CGRectMake(30, self.numlab.bottom+10, self.topAdScrollView.size.width-60, height);
            totallab.text=model.en;
            
        }
        self.topAdScrollView.imageURLStringsGroup=imageArray;
        //        _progressView.progress =1.0/[imageArray.count float] ;
        NSString*str1=@"1";
        NSString*str2=[NSString stringWithFormat:@"%ld",imageArray.count];
        _progressView.progress=str1.floatValue/str2.floatValue;
        self.numlab.text=[NSString stringWithFormat:@"1/%ld",imageArray.count];
        
     

        
        
        
        
        
        
        
        
        
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
        _subBtn.frame=CGRectMake(APP_WIDTH_6S(95.0),self.topAdScrollView.bottom + APP_HEIGHT_6S(10.0), APP_WIDTH_6S(186.0), APP_HEIGHT_6S(48.0));
        [_subBtn setTitle:@"答题完成"forState:UIControlStateNormal];
        [_subBtn setBackgroundImage:[UIImage imageNamed:@"answer_button"] forState:UIControlStateNormal];
        [_subBtn setTitleColor:[MTool colorWithHexString:@"#04847A"] forState:UIControlStateNormal];
        _subBtn.titleLabel.font=[UIFont systemFontOfSize:APP_HEIGHT_6S(20.0)];
        
    }
    return _subBtn;
}



@end
