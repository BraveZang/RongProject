//
//  MainSetVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/22.
//

#import "MainSetVC.h"
#import "MainSetCell.h"
#import "WebViewViewController.h"
@interface MainSetVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong)  UITableView          *tableView;
@property (nonatomic, strong)  NetManager           *net;

@end

@implementation MainSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"设置";
    [self  initTableView];
}

#pragma mark UITableViewDataSource
- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-49) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    float cellH=FitRealValue(110);
    if (IS_IPAD) {
        cellH=FitRealValue(110)*2/3;
    }
    self.tableView.rowHeight = cellH;
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];
}

#pragma mark – Network



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return 3;
    }
    else{
        return 2;
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
    
    static NSString *cellIdentifier = @"MainSetCell";
    MainSetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MainSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.titleLab.text=@"最新版本";
            cell.contentLab.text=@"当前已是最新版本";
            cell.contentLab.hidden=NO;
            
        }
        if (indexPath.row==1) {
            cell.titleLab.text=@"清除缓存";
            cell.contentLab.hidden=NO;
            float size_m = [self cacheFilesSize]/(1000*1000);
            cell.contentLab.text = [NSString stringWithFormat:@"%.2fM",size_m];
            
        }
        if (indexPath.row==2) {
            cell.titleLab.text=@"关于我们";
            cell.contentLab.hidden=YES;
            
        }
    }
    else{
        if (indexPath.row==0) {
            cell.titleLab.text=@"荣知教育用户协议";
            cell.contentLab.hidden=YES;
            
        }
        if (indexPath.row==1) {
            cell.titleLab.text=@"荣知教育隐私协议";
            cell.contentLab.hidden=YES;
            
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //            cell.titleLab.text=@"版本更新";
            //            cell.contentLab.text=@"当前已是最新版本";
            
        }
        if (indexPath.row==1) {
            [self qingchuhuancunClick];
            
        }
        if (indexPath.row==2) {
            
            [self getmember_aboutWithNoParamUrl];
        }
    }
    else{
        if (indexPath.row==0) {
            
            [self clickAgreementWithUrlStr:@"http://api.bclc.com.cn/agreement/UserAgreement.html" TitleStr:@"荣知教育用户协议"];
            
        }
        if (indexPath.row==1) {
            
            [self clickAgreementWithUrlStr:@"http://api.bclc.com.cn/agreement/PrivacyAgreement.html" TitleStr:@"荣知教育隐私协议"];
            
        }
    }
}

#pragma ---cache
- (void)qingchuhuancunClick{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    NSLog(@"files :%lu",(unsigned long)[files count]);
    for (NSString *p in files) {
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
    //    [self.view makeToast:@"清除緩存成功"]
    [MTool showText:@"清除緩存成功"];
    [self.tableView reloadData];
}

- (float)cacheFilesSize{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *manager = [NSFileManager defaultManager];
    //    SFun_Log(@"cachPath = %@",cachPath);
    if (![manager fileExistsAtPath:cachPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cachPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [cachPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}
- (long long) fileSizeAtPath:(NSString *) filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//member_aboutWithNoParam
-(void)getmember_aboutWithNoParamUrl{
    self.net.requestId=1001;
    [self.net member_aboutWithNoParam];
    
}


- (void)clickAgreementWithUrlStr:(NSString *)urlStr TitleStr:(NSString *)title{
    
    WebViewViewController *webVC = [[WebViewViewController alloc]init];
    webVC.urlStr =urlStr;
    webVC.titleStr=title;
    [self presentViewController:webVC animated:YES completion:nil];
    
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
            NSString*urlStr=bodyDic[@"url"];
            [self clickAgreementWithUrlStr:urlStr TitleStr:@"关于我们"];
            
            
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
