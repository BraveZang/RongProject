//
//  wuliuListVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/2.
//

#import "wuliuListVC.h"

@interface wuliuListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)  UITableView                       *tableView;

@end

@implementation wuliuListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
}

-(void)setAry:(NSArray *)ary{
    
    _ary=ary;
}
#pragma mark UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
        return 1;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return _ary.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"wuliuListVC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    tableView.rowHeight=FitRealValue(100);
    NSDictionary*dic=self.ary[indexPath.row];
    cell.textLabel.text=dic[@"names"];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   NSDictionary*dic=self.ary[indexPath.row];
   [self.navigationController popoverPresentationController];
    self.ItemBlock(dic);

}
@end
