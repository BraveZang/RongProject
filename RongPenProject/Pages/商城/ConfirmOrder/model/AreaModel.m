//
//  AreaModel.m
//  DengHaiSeed
//
//  Created by mac on 31.10.19.
//  Copyright © 2019 ZrteC. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"second" : @"AreaModel"};
}
@end
