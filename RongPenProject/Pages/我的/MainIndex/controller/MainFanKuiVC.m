//
//  MainFanKuiVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/22.
//

#import "MainFanKuiVC.h"
#import "MainFanKuiCell.h"
@interface MainFanKuiVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UITextViewDelegate>

@property (nonatomic, strong)  UITableView                       *tableView;
@property (nonatomic ,assign)  NSInteger                         sourceType;
@property (nonatomic, strong)  NSString                          *phoneStr;
@property (nonatomic, strong)  NSString                          *weChatStr;
@property (nonatomic, strong)  NSString                          *contentStr;
@property (nonatomic, strong)  NSString                          *imgStr;
@property (nonatomic, strong)  NSString                          *questionTypeStr;
@property (nonatomic, strong)  UIImage                           *questionImg;
@property (nonatomic, strong)  UIButton                          *imgBtn;
@property (nonatomic, strong)  UIButton                          *loginBtn;
@property (nonatomic, strong)  NetManager                        *net;



@end

@implementation MainFanKuiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"反馈";
    self.questionTypeStr=@"问题反馈";
    [self  initTableView];
}


#pragma mark photocreate


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
- (void)showUIImagePickerController{
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    if (self.sourceType==100) {
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    else{
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    controller.allowsEditing = YES;
    controller.navigationBar.translucent=NO;
    controller.delegate = self;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    controller.hidesBottomBarWhenPushed=YES;
    if (@available(iOS 13, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    self.questionImg=image;
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage*imageaa=[MTool fixOrientation:image];
        NSData *data = [MTool imageCompressToData:imageaa];
        NSString *encodedImageStr =[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        self.imgStr=[MTool removeSpaceAndNewline:encodedImageStr];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    }];
}
#pragma mark UITableViewDataSource
- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-49-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];
    
    self.imgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.imgBtn.frame=CGRectMake(LeftMargin, FitRealValue(110), FitRealValue(240), FitRealValue(160));
    [self.imgBtn addTarget:self action:@selector(creatActionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame=CGRectMake(30, self.tableView.bottom, ScreenWidth-60, 44);
    [self.loginBtn setBackgroundColor:[MTool colorWithHexString:@"#FF6E1D"]];
    [self.loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    self.loginBtn.cornerRadius=20;
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
}

#pragma mark – Network



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return 4;
    }
    else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 12;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor=RGBA(241, 244, 249, 1);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"MainFanKuiCell";
    MainFanKuiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MainFanKuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    float cellH=FitRealValue(110);
    if (IS_IPAD) {
        cellH=FitRealValue(110)*2/3;
    }
    tableView.rowHeight=cellH;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.titleLab.text=@"联系电话：";
            cell.tagLab.hidden=NO;
            if (self.phoneStr.length>0) {
                cell.contentLab.text=self.phoneStr;
            }
            else{
                cell.contentLab.text=@"请输入联系电话";
                cell.contentLab.textColor=[MTool colorWithHexString:@"999999"];
            }
        }
        if (indexPath.row==1) {
            cell.titleLab.text=@"联系微信：";
            if (self.weChatStr.length>0) {
                cell.contentLab.text=self.weChatStr;
            }
            else{
                cell.contentLab.text=@"请输入微信号码";
                cell.contentLab.textColor=[MTool colorWithHexString:@"999999"];
            }
        }
        if (indexPath.row==2) {
            cell.titleLab.text=@"反馈类型";
            cell.tagLab.hidden=NO;
            cell.sexView.hidden=NO;
            cell.Block = ^(NSString * _Nonnull sexStr) {
                
                self.questionTypeStr=sexStr;
            };
            
        }
        if (indexPath.row==3) {
            float cellH=FitRealValue(300);
            tableView.rowHeight=cellH;
            cell.titleLab.text=@"问题截图";
            cell.tagLab.hidden=NO;
            [cell addSubview:self.imgBtn];
            if (self.questionImg==nil) {
                [self.imgBtn setImage:[UIImage imageNamed:@"questionImg"] forState:UIControlStateNormal];
            }
            else{
                [self.imgBtn setImage:self.questionImg forState:UIControlStateNormal];

            }
            
            
        }
    }
    else{
        if (indexPath.row==0) {
            cell.titleLab.text=@"问题描述";
            cell.tagLab.hidden=NO;
            cell.describeView.hidden=NO;
            cell.describeView.delegate=self;
            float cellH=FitRealValue(400);
            if (IS_IPAD) {
                cellH=cellH*2/3;
            }
            tableView.rowHeight=cellH;
            
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            [self createUIAlertControllerWithMessage:@"请输入联系电话" AlerTag:0];
        }
        if (indexPath.row==1) {
            [self createUIAlertControllerWithMessage:@"请输入微信号码" AlerTag:1];
        }
    }
    
}
-(void)createUIAlertControllerWithMessage:(NSString*)message AlerTag:(NSInteger)alertag{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
        textField.placeholder = message;
    }];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *_Nonnull action){
        
    }]];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *_Nonnull action) {
        //获取第1个输入框；
        UITextField *textField = alertController.textFields.firstObject;
        if (alertag==0) {
            self.phoneStr = textField.text;
            self.phoneStr = [ self.phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        if (alertag==1) {
            self.weChatStr = textField.text;
            self.weChatStr = [ self.weChatStr stringByReplacingOccurrencesOfString:@" " withString:@""];

        }
        [self.tableView reloadData];

    }]];
    [self presentViewController:alertController animated:true completion:nil];
    
}


- (void)textViewDidChange:(UITextView *)textView

{
        self.contentStr=textView.text;
    
}


-(void)loginButtonPressed{
    
    self.net.requestId = 1001;
    [self.net member_feedbackWithUid:[User getUser].uid Mobile:self.phoneStr Weixin:self.weChatStr Type:self.questionTypeStr Image:self.imgStr Content:self.contentStr];
    
}
#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{

    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        if (request.requestId == 1001) {
            NSDictionary*bodyDic=result[@"body"];
            [DZTools showOKHud:code[@"res_msg"] delay:2];

            
        }
        else if (request.requestId == 1002) {
            
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
