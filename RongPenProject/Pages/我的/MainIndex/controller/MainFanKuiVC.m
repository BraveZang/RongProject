//
//  MainFanKuiVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/22.
//

#import "MainFanKuiVC.h"
#import "MainFanKuiCell.h"
#import "HDragItemListView.h"
#import "HDragItem.h"
@interface MainFanKuiVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)  UITableView                       *tableView;
@property (nonatomic, strong)  HDragItemListView                 *itemList;
@property (nonatomic,assign)   NSInteger                         sourceType;

@end

@implementation MainFanKuiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"反馈";
    [self createPhotoItem];
    [self  initTableView];
}


#pragma mark photocreate

-(void)createPhotoItem{
    
    HDragItem *item = [[HDragItem alloc] init];
    item.backgroundColor = [UIColor clearColor];
    item.image = [UIImage imageNamed:@"add_image"];
    item.isAdd = YES;
    
    // 创建标签列表
    HDragItemListView*itemList = [[HDragItemListView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 0)];
    itemList.itemListCols=4;
    itemList.maxItem=4;
    itemList.backgroundColor = [UIColor clearColor];
    // 高度可以设置为0，会自动跟随标题计算
    // 设置排序时，缩放比例
    itemList.scaleItemInSort = 1.3;
    // 需要排序
    itemList.isSort = YES;
    itemList.isFitItemListH = YES;
    
    [itemList addItem:item];
    self.itemList = itemList;
    __weak typeof(self) weakSelf = self;
    
    [itemList setClickItemBlock:^(HDragItem *item) {
        if (item.isAdd) {
            NSLog(@"添加");
            //               self.groupname=@"other";
            [weakSelf creatActionSheet];
        }
    }];
    
    /**
     * 移除tag 高度变化，得重设
     */
    itemList.deleteItemBlock = ^(HDragItem *item) {
        HDragItem *lastItem = [weakSelf.itemList.itemArray lastObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!lastItem.isAdd) {
                HDragItem *item = [[HDragItem alloc] init];
                item.backgroundColor = [UIColor clearColor];
                item.image = [UIImage imageNamed:@"add_image"];
                item.isAdd = YES;
                [weakSelf.itemList addItem:item];
            }
            
            
        });
    };
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
    //    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    controller.hidesBottomBarWhenPushed=YES;
    if (@available(iOS 13, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage*imageaa=[MTool fixOrientation:image];
        NSData *data = [MTool imageCompressToData:imageaa];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }];
}
#pragma mark UITableViewDataSource
- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-49) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];
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
        }
        if (indexPath.row==1) {
            cell.titleLab.text=@"联系微信：";
        }
        if (indexPath.row==2) {
            cell.titleLab.text=@"反馈类型";
            cell.tagLab.hidden=NO;
            cell.sexView.hidden=NO;
            
        }
        if (indexPath.row==3) {
            float cellH=FitRealValue(300);
            tableView.rowHeight=cellH;
            cell.titleLab.text=@"问题截图";
            cell.tagLab.hidden=NO;
            [cell addSubview:self.itemList];
            
            
        }
    }
    else{
        if (indexPath.row==0) {
            cell.titleLab.text=@"问题描述";
            cell.describeView.hidden=NO;
            float cellH=FitRealValue(400);
            if (IS_IPAD) {
                cellH=cellH*2/3;
            }
            tableView.rowHeight=cellH;
            
        }
    }
    return cell;
}

@end
