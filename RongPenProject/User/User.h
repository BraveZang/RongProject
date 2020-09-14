//
//  AppDelegate.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *icon;


+ (void)saveUser:(User *)user;
+ (User *)getUser;
+ (void)deleUser;
+ (NSString *)getUserID;
+ (NSString *)getToken;
+ (NSString *)getIMToken;

@end
