//
//  MainInfoSettingVC.m
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#define INFO_CELL       @"InfoCell"
#define INFOHEAD_CELL   @"InfoHeadCell"

#import "MainInfoSettingVC.h"
#import "MainInfoModel.h"
#import "MainInfoHeadCell.h"
#import "MainInfoCell.h"
#import "ZRAlertController.h"
#import "User.h"
#import "InfoModel.h"
#import "ZRInfoPickerView.h"
@interface MainInfoSettingVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NetManagerDelegate>

@property (nonatomic, strong) UITableView              *infoTable;
@property (nonatomic,   copy) NSArray                  *dataArray;
@property (nonatomic, strong) NetManager               *net;
@property (nonatomic, strong) UIImage                  *headIMG;
@property (nonatomic, strong) ZRInfoPickerView         *zrPickerView;
// 修改信息类型    1=性别  2=年级 3=年龄
@property (nonatomic, assign) NSInteger                zrpickerViwType;
@end

@implementation MainInfoSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toptitle.hidden=NO;
    self.toptitle.text=@"个人信息";
    self.leftImgBtn.hidden=NO;
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getData];
    [self.infoTable reloadData];
}
- (void)creatUI{
    
    self.infoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, KSCREEN_WIDTH, KSCREEN_HEIGHT - SafeAreaTopHeight) style:UITableViewStyleGrouped];
    _infoTable.delegate=self;
    _infoTable.dataSource=self;
    //    _infoTable.separatorColor = [UIColor colorWithHexColorString:@"F2F2F2"];
    _infoTable.backgroundColor = [UIColor colorWithHexColorString:@"F3F5F8"];
    _infoTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_infoTable];
    
}
- (void)getData{
    
    User *userModel = [User getUser];
    InfoModel * model1 = [[InfoModel alloc] initWithTitle:@"头像" Content:userModel.avatar andalert:@"请选择"];
    InfoModel * model2 = [[InfoModel alloc] initWithTitle:@"昵称" Content:userModel.nickname andalert:@"为自己定个昵称吧"];
    
    NSString * sex = @"";
    if ([userModel.sex isEqualToString:@"1"]) {
        sex = @"男";
    }else if ([userModel.sex isEqualToString:@"0"]) {
        sex = @"女";
    }else{
        sex = @"未设置";
    }
    InfoModel * model3 = [[InfoModel alloc] initWithTitle:@"性别" Content:sex andalert:@"请选择"];
    InfoModel * model4 = [[InfoModel alloc] initWithTitle:@"年级" Content:[MTool getGradeNameWithGradeCode:userModel.grade] andalert:@"请选择"];
    InfoModel * model5 = [[InfoModel alloc] initWithTitle:@"年龄" Content:[NSString stringWithFormat:@"%@岁",userModel.age] andalert:@"请选择"];
    InfoModel * model6 = [[InfoModel alloc] initWithTitle:@"设置密码" Content:@"" andalert:@""];
    self.dataArray = @[@[model1,model2,model3],@[model4,model5,model6]];
    
    
}


#pragma mark - Action



#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return APP_HEIGHT_6S(20.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    //line
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return APP_HEIGHT_6S(50.0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * tempArray = _dataArray[section];
    return tempArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //头像
    User*user=[User getUser];
    if (indexPath.row == 0 && indexPath.section == 0) {
        MainInfoHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:INFOHEAD_CELL];
        if (!cell) {
            cell = [[MainInfoHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INFOHEAD_CELL];
        }
        //        cell.model = _dataArray[0][0];
        [cell.headView sd_setImageWithURL:[NSURL URLWithString: user.avatar] placeholderImage:[UIImage imageNamed:@"defaultimg"]];
        return cell;
    }
    //信息
    MainInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:INFO_CELL];
    if (!cell) {
        cell = [[MainInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INFO_CELL];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.model = _dataArray[indexPath.section][indexPath.row];
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //修改信息
    NSString *title;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //上传头像
            
            ZRAlertController * alert = [ZRAlertController initZRAlerControllerWithTitle:nil message:nil style:@"0" titleArr:[NSMutableArray arrayWithObjects:@"拍照",@"相册",@"取消",nil] alerAction:^(NSInteger index) {
                [self openCameraOrphotoSelecte:index];
            }];
            [alert showWBAler];
        }else if (indexPath.row == 1){
            //账号不可编辑
            return;
        }else{
            //性别
            self.zrpickerViwType = 1;
            [self.zrPickerView updateDataArray:@[@"女",@"男"]];
            [self.zrPickerView showZRInfoPickerView];
        }
        
    }else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            //年级 1.一年级 2.二年级 3.三年级 4.四年级 5.五年级 6.六年级 7.初一 8.初二 9.初三 10.高一11.高二 12.高三
            self.zrpickerViwType = 2;
            [self.zrPickerView updateDataArray:[MTool getGradeList]];
            [self.zrPickerView showZRInfoPickerView];
        }else if (indexPath.row == 1){
            //年龄
            self.zrpickerViwType = 3;
            
            NSMutableArray *ageArray = [[NSMutableArray alloc] init];
            for (NSInteger i = 1; i < 100; i++) {
                [ageArray addObject:[NSString stringWithFormat:@"%ld岁",i]];
            }
            [self.zrPickerView updateDataArray:ageArray];
            [self.zrPickerView showZRInfoPickerView];
        }else{
            //设置密码
        }
        
    }
    
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
            //更新会员信息
            self.net.requestId = 1002;
            [self.net login_renewingWithUid:[User getUserID]];
        }else if (request.requestId == 1002) {
            //更新会员信息
            NSDictionary*bodyDic=result[@"body"];
            User *user = [User mj_objectWithKeyValues:bodyDic];
            [User saveUser:user];
            [self getData];
            [self.infoTable reloadData];
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



#pragma mark -lazy

- (ZRInfoPickerView *)zrPickerView{
    __weak typeof(self) weakSelf = self;
    
    if (!_zrPickerView) {
        _zrPickerView = [[ZRInfoPickerView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _zrPickerView.didSelectRowBlock = ^(NSString * _Nonnull selectDataStr) {
            User *user = [User getUser];
            weakSelf.net.requestId = 1001;
            if (weakSelf.zrpickerViwType == 1) {
                //性别  1.男  0女
                [weakSelf.net member_usereditWithUid:[User getUserID] Avatar:user.avatar NicName:user.nickname Grade:user.grade Age:user.age andSex:[selectDataStr isEqualToString:@"男"]?@"1":@"0"];
            }else if (weakSelf.zrpickerViwType == 2) {
                //年级
                [weakSelf.net member_usereditWithUid:[User getUserID] Avatar:user.avatar NicName:user.nickname Grade:[MTool getGradeCodeWithGradeName:selectDataStr] Age:user.age andSex:user.sex];
            }else if (weakSelf.zrpickerViwType == 3) {
                //年龄
                [weakSelf.net member_usereditWithUid:[User getUserID] Avatar:user.avatar NicName:user.nickname Grade:user.grade Age:selectDataStr andSex:user.sex];
            }
        };
        [self.view addSubview:_zrPickerView];
    }
    
    return _zrPickerView;
}




#pragma mark - 打开相机或打开相册
- (void)openCameraOrphotoSelecte:(NSInteger)index
{
    
    NSUInteger sourceType = 0;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        switch (index) {
            case 0:
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
                
            case 1:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                // 取消
                return;
        }
    }
    else {
        if (index == 0) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    
    
    // 跳转到相机或相册页面
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    
    controller.navigationBar.translucent=NO;
    controller.delegate = self;
    controller.allowsEditing = YES;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    if (@available(iOS 13, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    [self presentViewController:controller animated:YES completion:nil];
}




#pragma mark - UIImagePickerViewDelegate
// 当得到照片或者视频后，调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
{
    
    NSLog(@"info--->成功：%@", info);
    
    // 获取用户拍摄的是照片还是视频
    
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    // 判断获取类型：图片
    UIImage *theImage =nil;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        // 判断，图片是否允许修改
        
        if ([picker allowsEditing])
            
        {
            // 获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
            
        }else {
            // 获取原始的照片
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            
        }
        // 保存图片到相册中
        //        UIImageWriteToSavedPhotosAlbum(theImage,self,nil,nil);
        
        
        
    }
    self.headIMG = theImage;
    
    //    //上传图片
    [self uploadImage:theImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 上传图片
- (void)uploadImage:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    //上传参数
    User *user = [User getUser];
    self.net.requestId = 1001;
    [self.net member_userHeaderEditWithUid:[User getUserID] Avatar:imageData NicName:user.nickname Grade:user.grade Age:user.age andSex:user.sex];
    
    
    
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
