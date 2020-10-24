//
//  ReadInfoFooterView.h
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import <Foundation/Foundation.h>

#import "MainBookModel.h"
#import "ReadInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReadInfoFooterView : UIView


@property (nonatomic, copy) void(^seletedUnitblock)(NSInteger index);



@property (nonatomic, strong) ReadInfoModel     *infoModel;

@end

NS_ASSUME_NONNULL_END
