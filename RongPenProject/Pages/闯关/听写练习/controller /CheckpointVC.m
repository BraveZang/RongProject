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

@property (nonatomic,strong) SDCycleScrollView                *topAdScrollView;//广告轮播控件


@property(nonatomic,strong)   NetManager                        *net;

@property (nonatomic, strong) NSArray                           *answerList;

@property (nonatomic, strong) UIButton                          *subBtn;
@end

@implementation CheckpointVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.toptitle.hidden=NO;
//    self.leftImgBtn.hidden=NO;
    
//    [self creatUI];
}


- (void)creatUI{
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bg.userInteractionEnabled = YES;
    bg.image = [UIImage imageNamed:@"checkPoint_BG"];
    [self.view addSubview:bg];
    
    NSMutableArray * imageArray = [[NSMutableArray alloc] initWithCapacity:self.answerList.count];
    for (NSInteger i = 0; i < self.answerList.count; i++) {
//        UIImage * image = [UIImage imageNamed:@"answerBG"];
        [imageArray addObject:@"answerBG"];
    }
    
    self.topAdScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(APP_WIDTH_6S(8.0),APP_HEIGHT_6S(72.0) + StatusBarHight,APP_WIDTH_6S(359.0),APP_HEIGHT_6S(453.0)) imageNamesGroup:imageArray ];
    self.topAdScrollView.backgroundColor =[UIColor clearColor];
    self.topAdScrollView.autoScrollTimeInterval = 99999999.f;
    self.topAdScrollView.autoScroll = NO;
    self.topAdScrollView.infiniteLoop = NO;
    self.topAdScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleNone;
    self.topAdScrollView.delegate = self;
    self.topAdScrollView.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
    [SDCycleScrollView clearImagesCache];
//    self.topAdScrollView.layer.masksToBounds = YES;
    [bg addSubview:_topAdScrollView];
    
    
    [bg addSubview:self.subBtn];
}

-(void)setModel:(gkModel *)model{
    _model = model;
    
    [self.net Pass_cntoeninfoWithUid:[User getUserID] andBookId:model.bookid Unitid:model.unitid andGqid:model.gqid];
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
        
        [self creatUI];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
