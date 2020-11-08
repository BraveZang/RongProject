//
//  PenCell.h
//  RongPenProject
//
//  Created by mac on 8.11.20.
//

#import <UIKit/UIKit.h>
#import "PenModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PenCell : UITableViewCell
@property (nonatomic, strong) UILabel        *titleLab;

@property (nonatomic, strong) CBPeripheral      *periphera;

@property (nonatomic, copy) void(^connectPeripheraBlock)(CBPeripheral* periphera);

@end

NS_ASSUME_NONNULL_END
