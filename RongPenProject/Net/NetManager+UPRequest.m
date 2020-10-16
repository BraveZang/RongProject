//
//  NetManager+UPRequest.m
//  jiyouhui2020
//
//  Created by zanghui  on 2020/7/30.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "NetManager+UPRequest.h"


@implementation NetManager (UPRequest)



#pragma mark - 智能笔接口数据


#pragma mark - 用户账号 account
/**
 用户登录
 
 @param mobile 手机号
 @param yan 验证码
**/
- (void)login_indexWithMobile:(NSString *)mobile Yan:(NSString *)yan{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (mobile)[mutabDic setObject:mobile forKey:@"mobile"];
    if (yan) [mutabDic setObject:yan forKey:@"yan"];
    [self sendPOSTRequestToServerWithURL:@"login_index" postData:mutabDic];
}
/**
 获取验证码
 login_send
 @param mobile 手机号
 @param action 行为 非找回密码为空即可，否则传值为:findpwd
 **/
- (void)login_sendWithMobile:(NSString *)mobile Action:(NSString *)action{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (mobile)[mutabDic setObject:mobile forKey:@"mobile"];
    if (action) [mutabDic setObject:action forKey:@"action"];
    [self sendPOSTRequestToServerWithURL:@"login_send" postData:mutabDic];
}

/**
 密码登录
 login_pwdlogin
 @param mobile 手机号
 @param password 密码
 **/
- (void)login_pwdloginWithMobile:(NSString *)mobile Password:(NSString *)password{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (mobile)[mutabDic setObject:mobile forKey:@"mobile"];
    if (password) [mutabDic setObject:password forKey:@"password"];
    [self sendPOSTRequestToServerWithURL:@"login_pwdlogin" postData:mutabDic];
}

/**
设置年级
login_setgread
@param uid 会员id
@param grade 年级 1.一年级 2.二年级 3.三年级 4.四年级 5.五年级 6.六年级 7.初一 8.初二 9.初三 10.高一 11.高二 12.高三
**/
- (void)login_setgreadWithUid:(NSString *)uid Grade:(NSString *)grade{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (grade) [mutabDic setObject:grade forKey:@"grade"];
    [self sendPOSTRequestToServerWithURL:@"login_setgread" postData:mutabDic];
}

/**
 忘记密码-验证码校验
 login_repwdjy
 @param mobile 手机号
 @param yan 验证码
 **/
- (void)login_repwdjyWithMobile:(NSString *)mobile Yan:(NSString *)yan{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (mobile)[mutabDic setObject:mobile forKey:@"mobile"];
    if (yan) [mutabDic setObject:yan forKey:@"yan"];
    [self sendPOSTRequestToServerWithURL:@"login_repwdjy" postData:mutabDic];
}

/**
 忘记密码
 login_repwddo
 @param uid 忘记密码-验证码校验接口返回的uid
 @param newpwd 新的密码
 **/
- (void)login_repwddoWithUid:(NSString *)uid Newpwd:(NSString *)newpwd{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (newpwd) [mutabDic setObject:newpwd forKey:@"newpwd"];
    [self sendPOSTRequestToServerWithURL:@"login_repwddo" postData:mutabDic];
}
/**
 会员信息更新
 login_renewing
 @param uid 会员uid 登录成功后返回的uid
 **/
- (void)login_renewingWithUid:(NSString *)uid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    [self sendPOSTRequestToServerWithURL:@"login_renewing" postData:mutabDic];
    
}

/**
 获取地区
 main_area
 **/
- (void)main_areaWithNoParam{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    [self sendPOSTRequestToServerWithURL:@"main_area" postData:mutabDic];
    
}
#pragma mark - 首页




#pragma mark - 我的


/**
 商城
 Shop_index
 **/
- (void)Shop_indexWithNoParam{
    
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    [self sendPOSTRequestToServerWithURL:@"Shop_index" postData:mutabDic];
    
}

/**
 商品详情
 id 商品的id
 type 我的商城 接口返回的type 商品、教辅、练习册
 Shop_info
 **/
- (void)Shop_infoWithId:(NSString *)id Type:(NSString *)type{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (id)[mutabDic setObject:id forKey:@"id"];
    if (type)[mutabDic setObject:type forKey:@"type"];
    [self sendPOSTRequestToServerWithURL:@"Shop_info" postData:mutabDic];
    
}
/**
 立即购买-确定 Shop_buy
 uid 当前会员id
 total 商品总价格
 goods 商品列表
 **/
- (void)Shop_buyWithUid:(NSString *)uid Total:(NSString *)total Goods:(NSArray *)goods{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (total)[mutabDic setObject:total forKey:@"total"];
    if (goods)[mutabDic setObject:goods forKey:@"goods"];
    [self sendPOSTRequestToServerWithURL:@"Shop_buy" postData:mutabDic];
    
}
@end




























