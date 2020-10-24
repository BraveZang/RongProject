//
//  MainCourseDetailModel.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainCourseDetailModel : NSObject
@property(nonatomic,strong)NSString   *videourl;
@property(nonatomic,strong)NSString   *videofm;
@property(nonatomic,strong)NSString   *type;
@property(nonatomic,strong)NSArray    *teacherinfo;
@property(nonatomic,strong)NSString   *sprice;
@property(nonatomic,strong)NSString   *range;
@property(nonatomic,strong)NSString   *name;
@property(nonatomic,strong)NSString   *id;
@property(nonatomic,strong)NSString   *details;
@property(nonatomic,strong)NSArray    *courserange;
@end

NS_ASSUME_NONNULL_END
