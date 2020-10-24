//
//  gkModel.h
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface gkModel : NSObject

@property (nonatomic, strong)NSString       *gqid;
@property (nonatomic, strong)NSString       *unitid;
@property (nonatomic, strong)NSString       *bookid;
@property (nonatomic, strong)NSString       *gqnum;
@property (nonatomic, strong)NSString       *gqname;
/// 用时
@property (nonatomic, strong)NSString       *timelen;

/// 成绩
@property (nonatomic, strong)NSString       *start;

@end

NS_ASSUME_NONNULL_END
