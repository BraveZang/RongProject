//
//  HaveBuyView.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import "HaveBuyView.h"
#import "HaveBuyCell.h"


@interface HaveBuyView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView             *tableView;
@property(nonatomic,strong)UILabel                 *titleLab;
@property(nonatomic,assign)CGFloat                 viewH;
@property(nonatomic,strong)UIView                  *footView;
@property(nonatomic,assign)NSInteger               indexPathRow;
@property(nonatomic,strong)NSDictionary            *dic1;//商品
@property(nonatomic,strong)NSDictionary            *dic2;//赠品

@end

@implementation HaveBuyView


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
        UIButton*bgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        bgBtn.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [bgBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgBtn];
        self.indexPathRow=0;
        [self CreateUI];
        
    }
    return self;
}
-(void)CreateUI{
    
    UIButton*buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame=CGRectMake(0, ScreenHeight-SafeAreaBottomHeight-50, ScreenWidth, 50);
    [buyBtn setBackgroundColor:[MTool colorWithHexString:@"#FF4E4E"]];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [buyBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buyBtn];
    
    [self initableviewView];
    
}
#pragma mark - tableview
-(void)initableviewView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,ScreenHeight-SafeAreaBottomHeight-50-FitRealValue(1000),  ScreenWidth,FitRealValue(1000)) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    else{
        return self.glteachingAry.count;

    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return FitRealValue(80);
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80*SCREEN_WIDTH/750)];
    view.backgroundColor=[UIColor whiteColor];
    UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(ScreenWidth-FitRealValue(40)-FitRealValue(40), 12, FitRealValue(40), FitRealValue(80));
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    [btn setTitleColor:[MTool colorWithHexString:@"#5C5C5C"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"viewclosed"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=section+100;
    btn.hidden=YES;
    [view addSubview:btn];
    if (section==0) {
        btn.hidden=NO;
        
    }
    UILabel*celltitlelab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 0, 300, 80*SCREEN_WIDTH/750)];
    celltitlelab.font=[UIFont systemFontOfSize:17];
    celltitlelab.textColor=[MTool colorWithHexString:@"#282828"];
    if (section==0) {
        celltitlelab.text=@"已选择购买";
    }
    else{
        celltitlelab.text=@"选择赠品";
        
    }
    [view addSubview:celltitlelab];
    return view;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString *CellIdentifier =@"HaveBuyCell";
    HaveBuyCell*cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HaveBuyCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    tableView.rowHeight= FitRealValue(90);
    if (indexPath.section==0) {
        tableView.allowsSelection=NO;
        cell.nameLab.text=self.model.name;
        cell.moneyLab.text=[NSString stringWithFormat:@"¥%@",self.model.sprice];
        cell.bgView.backgroundColor=[MTool colorWithHexString:@"#FF9B9B"];
        cell.bgView.borderWidth=1;
        cell.bgView.borderColor=[MTool colorWithHexString:@"#FF4E4E"];
    }
    else{
        tableView.allowsSelection=YES;
        NSDictionary*dic=self.glteachingAry[indexPath.row];
        cell.nameLab.text=dic[@"name"];
        cell.moneyLab.text=@"¥0.00";
        cell.bgView.backgroundColor=[MTool colorWithHexString:@"#EFEFEF"];
        if (indexPath.row==self.indexPathRow) {
            
            if (cell.select==NO) {
                cell.select=YES;
            }
            else{
                cell.select=NO;
                
            }
        }
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section==1) {
        self.indexPathRow=indexPath.row;
        NSDictionary*dic=self.glteachingAry[indexPath.row];

        self.dic2=@{@"goodsid":[NSString stringWithFormat:@"%@",dic[@"id"]],
                    @"goodsname":[NSString stringWithFormat:@"%@",dic[@"name"]],
                    @"price":@"0",
                    @"type":[NSString stringWithFormat:@"%@",dic[@"type"]],
        };
        [self.tableView reloadData];
        
    }
    
}
-(void)closeBtnClick{
    [self removeFromSuperview];
}
-(void)sureClick{
    NSArray*ary=[NSArray arrayWithObjects:self.dic1,self.dic2, nil];
    self.click(ary);
}
-(void)setGlteachingAry:(NSArray *)glteachingAry{
    _glteachingAry=glteachingAry;
    NSDictionary*dic=self.glteachingAry[0];
    self.dic2=@{@"goodsid":[NSString stringWithFormat:@"%@",dic[@"id"]],
                @"goodsname":[NSString stringWithFormat:@"%@",dic[@"name"]],
                @"price":@"0",
                @"type":[NSString stringWithFormat:@"%@",dic[@"type"]],
    };
}
-(void)setModel:(ShopInfoModel *)model{
    _model=model;
    self.dic1=@{@"goodsid":model.id,
                @"goodsname":model.name,
                @"price":model.sprice,
                @"type":model.type,
    };
    [self.tableView reloadData];
}
@end
