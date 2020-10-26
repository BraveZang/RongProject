//
//  MyorderDetailTowCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import <UIKit/UIKit.h>
#import "MyorderDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyorderDetailTowCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)  UITableView                       *tableView;
@property (nonatomic, strong)  MyorderDetailModel                *model;
@property (nonatomic, strong)  NSString                          *str1;
@property (nonatomic, strong)  NSString                          *str2;
@property (nonatomic, strong)  NSString                          *str3;
@property (nonatomic, strong)  NSString                          *str4;
@property (nonatomic, strong)  UILabel                           *contentLab;


@end

NS_ASSUME_NONNULL_END
