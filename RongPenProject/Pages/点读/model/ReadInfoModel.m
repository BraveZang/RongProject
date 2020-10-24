//
//  ReadInfoModel.m
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import "ReadInfoModel.h"
#import "MapModel.h"
@implementation ReadInfoModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"MapModel",
             };
}
@end
