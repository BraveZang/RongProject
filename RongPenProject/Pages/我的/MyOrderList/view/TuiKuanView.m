//
//  TuiKuanView.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/1.
//

#import "TuiKuanView.h"

@interface TuiKuanView ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NetManagerDelegate>

@property (nonatomic, strong) NetManager               *net;
@property (nonatomic, assign) NSInteger                sourceType;
@property (nonatomic, strong) NSMutableArray           *imgDataAry;
@property (nonatomic, strong) NSString                 *textViewStr;

@end

@implementation TuiKuanView

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor blackColor];
    color = [color colorWithAlphaComponent:0.6];
    self.view.backgroundColor = color;

    self.imgDataAry=[NSMutableArray arrayWithCapacity:0];
    [self CreateUI];
}
-(void)closeBtnClick{
  
}
-(void)CreateUI{
    UIButton*bgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [bgBtn addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgBtn];
    
    float bgViewW= ScreenWidth-20;
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(10, FitRealValue(200), bgViewW, FitRealValue(800))];
    self.bgView.cornerRadius=5;
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,bgViewW , FitRealValue(120))];
    self.titleLab.text=@"退款原因";
    self.titleLab.font=[UIFont systemFontOfSize:18];
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    [self.bgView addSubview:self.titleLab];
    
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(10, self.titleLab.bottom, bgViewW-20, FitRealValue(320))];
    self.textView.backgroundColor=[UIColor colorWithRed:242/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];
    self.textView.delegate=self;
    [self.bgView addSubview:self.textView];


    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(bgViewW-25-FitRealValue(140), FitRealValue(320)-5-FitRealValue(30), FitRealValue(140), FitRealValue(30))];
    lab.text=@"限制100字符";
    lab.textAlignment=NSTextAlignmentRight;
    lab.font=[UIFont systemFontOfSize:10];
    lab.textColor=[MTool colorWithHexString:@"#BDBDBD"];
    [self.textView addSubview:lab];
    
    
    self.item = [[HDragItem alloc] init];
    self.item.backgroundColor = [UIColor clearColor];
    self.item.image = [UIImage imageNamed:@"ico_jiatupian"];
    self.item.isAdd = YES;
    // 创建标签列表
    self.itemList = [[HDragItemListView alloc] initWithFrame:CGRectMake(0,  self.textView.bottom+10*SCREEN_WIDTH/750, bgViewW, FitRealValue(100))];
    self.itemList.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:self.itemList];
    // 高度可以设置为0，会自动跟随标题计算
    // 设置排序时，缩放比例
    self.itemList.scaleItemInSort = 1.3;
    // 需要排序
    self.itemList.isSort = YES;
    self.itemList.isFitItemListH = YES;
    self.itemList.maxItem=3;
    [self.itemList addItem:self.item];
    
    __weak typeof(self) weakSelf = self;
    
    [self.itemList setClickItemBlock:^(HDragItem *item) {
        if (item.isAdd) {
            NSLog(@"添加");
        [weakSelf creatActionSheet];
            
        }
    }];
    
    self.quxiaoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.quxiaoBtn.frame=CGRectMake(10, self.itemList.bottom+10, FitRealValue(280), FitRealValue(72)) ;
    self.quxiaoBtn.borderWidth=0.5;
    self.quxiaoBtn.borderColor=[MTool colorWithHexString:@"#FF6B6B"];
    self.quxiaoBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.quxiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.quxiaoBtn setTitleColor:[MTool colorWithHexString:@"#FF6B6B"] forState:UIControlStateNormal];
    [self.bgView addSubview:self.quxiaoBtn];
    self.quxiaoBtn.cornerRadius=16;
    [self.quxiaoBtn addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
    self.qudingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.qudingBtn.frame=CGRectMake(bgViewW-FitRealValue(280)-10, self.itemList.bottom+10, FitRealValue(280), FitRealValue(72)) ;
    self.qudingBtn.backgroundColor=[MTool colorWithHexString:@"#FF6B6B"];
    self.qudingBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.qudingBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.qudingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bgView addSubview:self.qudingBtn];
    self.qudingBtn.cornerRadius=16;
    [self.qudingBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];

    
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length>100) {
        return;
    }
    self.textViewStr=textView.text;

}
-(void)creatActionSheet {
  
    
     self.sourceType = 0;
     __weak typeof(self) weakSelf = self;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择处理方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 创建action，这里action1只是方便编写，以后再编程的过程中还是以命名规范为主
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.sourceType=100;
        [weakSelf showUIImagePickerController];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.sourceType=101;
        [weakSelf showUIImagePickerController];

    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    //把action添加到actionSheet里
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [self presentViewController:actionSheet animated:YES completion:nil];

}
#pragma mark - UIImagePickerController
- (void)showUIImagePickerController{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    if (self.sourceType==100) {
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    else if (self.sourceType==101){
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }
  
    controller.navigationBar.translucent=NO;
    controller.delegate = self;
    controller.allowsEditing = YES;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    if (@available(iOS 13, *)) {
           UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
       }
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *imageqqq = info[@"UIImagePickerControllerOriginalImage"];
     UIImage*image=[MTool fixOrientation:imageqqq];
    [picker dismissViewControllerAnimated:YES completion:^{
        HDragItem *item = [[HDragItem alloc] init];
        item.image = image;
       
        // 给头像添加轻拍手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
           // 允许用户交互
        item.userInteractionEnabled = YES;
        [item addGestureRecognizer:tap];
        item.backgroundColor = [UIColor purpleColor];
        [self.itemList addItem:item];
        
        NSData *data = [MTool imageCompressToData:image];
        NSString *encodedImageStr =[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSString*encodingStr=[MTool removeSpaceAndNewline:encodedImageStr];
         NSLog(@"encodedImageStr==%@",encodingStr);
        [self.imgDataAry addObject:encodingStr];
    }];
}
-(void)setOrderidStr:(NSString *)orderidStr{
    
    _orderidStr=orderidStr;
}
-(void)bgBtnClick{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
-(void)sureClick{
    
    [self.net Order_refundWithUid:[User getUserID] orderid:self.orderidStr yunyin:self.textViewStr mobile:[User getUser].mobile pic:self.imgDataAry];
}
#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    
  
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        if (request.requestId==1001) {
       
            [self bgBtnClick];
        }
      
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
@end
