//
//  AppDelegate.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *avatar;


+ (void)saveUser:(User *)user;
+ (User *)getUser;
+ (void)deleUser;
+ (NSString *)getUserID;
+ (NSString *)getToken;
+ (NSString *)getIMToken;

@end
