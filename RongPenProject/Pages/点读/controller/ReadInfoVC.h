//
//  ReadInfoVC.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/24.
//

#import "DZBaseViewController.h"
#import "UnitModel.h"
#import "MainBookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReadInfoVC : DZBaseViewController

@property (nonatomic, strong) UnitModel         *unitModel;
@property (nonatomic, strong) MainBookModel     *bookModel;

@end

NS_ASSUME_NONNULL_END
