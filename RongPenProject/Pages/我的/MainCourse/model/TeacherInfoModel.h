//
//  TeacherInfoModel.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherInfoModel : NSObject

@property(nonatomic,strong)NSString   *avatar;
@property(nonatomic,strong)NSString   *info;
@property(nonatomic,strong)NSString   *tname;
@property(nonatomic,assign)CGFloat    cellH;

@end

NS_ASSUME_NONNULL_END
