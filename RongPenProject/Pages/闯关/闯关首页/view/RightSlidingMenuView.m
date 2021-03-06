//
//  RightSlidingMenuView.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/21.
//

#import "RightSlidingMenuView.h"
#import "RightSlidingMenuViewCell.h"
@interface RightSlidingMenuView()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectIndex;

}
@property (nonatomic,strong)UIView       *contentView;
@property (nonatomic,strong)UILabel      *contentTitleLab;
@property (nonatomic,strong)UIButton     *bgBtn;
@property (nonatomic,strong)UIButton     *clocseBtn;
@property (nonatomic,strong)UITableView  *tableview;
@property (nonatomic,strong)UIView       *lineView;

@end
@implementation RightSlidingMenuView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        _selectIndex = 0;
        [self createUI];
        [self initTableView];
    }
    return self;
}
-(void)createUI{
    
    self.bgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bgBtn.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.bgBtn setBackgroundColor:[UIColor blackColor]];
    self.bgBtn.alpha=0.5;
    [self.bgBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.bgBtn];

    float contentViewW=ScreenWidth-FitRealValue(230);
    self.contentView=[[UIView alloc]initWithFrame:CGRectMake(FitRealValue(230), 0, ScreenWidth-FitRealValue(230), ScreenHeight)];
    self.contentView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.contentView];
    
    self.contentTitleLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 0, contentViewW, FitRealValue(128))];
    self.contentTitleLab.text=@"更换教材";
    self.contentTitleLab.font=[UIFont systemFontOfSize:14];
    self.contentTitleLab.textColor=[MTool colorWithHexString:@"#444444"];
    [self.contentView addSubview:self.contentTitleLab];
    
    self.clocseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.clocseBtn.frame=CGRectMake(contentViewW-FitRealValue(60), (FitRealValue(128)-FitRealValue(30))/2, FitRealValue(30), FitRealValue(30));
    [self.clocseBtn setImage:[UIImage imageNamed:@"rightclose"] forState:UIControlStateNormal];
    [self.clocseBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.clocseBtn];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.contentTitleLab.bottom, contentViewW, 0.5)];
    self.lineView.backgroundColor=[MTool colorWithHexString:@"#EEEEEE"];
    [self.contentView addSubview:self.lineView];
}

#pragma mark - tableview
-(void)initTableView{
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,self.lineView.bottom,  ScreenWidth-FitRealValue(230), SCREEN_HEIGHT-self.lineView.bottom-SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.tableFooterView=[UIView new];
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    [self.contentView addSubview:self.tableview];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_type == 1) {
        //教辅
        return self.bookList.count;
    }else if (_type == 2) {
        //单元
        return self.unitList.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellIdentifier = @"RightSlidingMenuViewCell";
    RightSlidingMenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[RightSlidingMenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row==1) {
        cell.yellowView.hidden=NO;
    }
    tableView.rowHeight=FitRealValue(60);
    
    if (_type == 1) {
        //教辅
        MainBookModel * model = self.bookList[indexPath.row];
        cell.name.text=model.goodsname;
    }else if (_type == 2) {
        //单元
        UnitModel * model = self.unitList[indexPath.row];
        cell.name.text=model.name;
    }
    
    
    return cell;
        
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_type == 1) {
        //教辅
        if (self.seletedBookblock) {
            self.seletedBookblock(self.bookList[indexPath.row]);
        }
    }else if (_type == 2) {
        //单元
        if (self.seletedUnitblock) {
            self.seletedUnitblock(self.unitList[indexPath.row]);
        }
    }
    
    
    
    [self removeFromSuperview];
    
}
-(void)closeBtnClick{
    
   [self removeFromSuperview];
    
}
@end
