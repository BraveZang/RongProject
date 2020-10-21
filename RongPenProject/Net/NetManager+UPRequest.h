//
//  NetManager+UPRequest.h
//  jiyouhui2020
//
//  Created by zanghui  on 2020/7/30.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "NetManager.h"



@interface NetManager (UPRequest)


#pragma mark - 智能笔接口数据
#pragma mark - 登录 获取验证码

/**
 用户登录
 
 @param mobile 手机号
 @param yan 验证码
**/
- (void)login_indexWithMobile:(NSString *)mobile Yan:(NSString *)yan;

/**
 获取验证码
 login_send
 @param mobile 手机号
 @param action 行为 非找回密码为空即可，否则传值为:findpwd
 **/
- (void)login_sendWithMobile:(NSString *)mobile Action:(NSString *)action;

/**
密码登录
login_pwdlogin
@param mobile 手机号
@param password 密码
**/
- (void)login_pwdloginWithMobile:(NSString *)mobile Password:(NSString *)password;

/**
设置年级
login_setgread
@param uid 会员id
@param grade 年级 1.一年级 2.二年级 3.三年级 4.四年级 5.五年级 6.六年级 7.初一 8.初二 9.初三 10.高一 11.高二 12.高三
**/
- (void)login_setgreadWithUid:(NSString *)uid Grade:(NSString *)grade;

/**
 忘记密码-验证码校验
 login_repwdjy
 @param mobile 手机号
 @param yan 验证码
 **/
- (void)login_repwdjyWithMobile:(NSString *)mobile Yan:(NSString *)yan;

/**
 忘记密码
 login_repwddo
 @param uid 忘记密码-验证码校验接口返回的uid
 @param newpwd 新的密码
 **/
- (void)login_repwddoWithUid:(NSString *)uid Newpwd:(NSString *)newpwd;

/**
 会员信息更新
 login_renewing
 @param uid 会员uid 登录成功后返回的uid
 **/
- (void)login_renewingWithUid:(NSString *)uid;


/**
 获取地区
 main_area
 **/
- (void)main_areaWithNoParam;
    
#pragma mark - 用户账号 account


#pragma mark - 首页




#pragma mark - 我的

/**
 我的课程(录播课程、直播课程) 参数 Course_index
 参数：
 page 分页 默认1
 type 录播、直播
 **/
- (void)Course_indexWithPage:(NSString *)page Type:(NSString *)type;

/**
 已购课程 参数
 参数：
 uid 当前会员id
 page 分页 默认1
 **/
- (void)Course_orderlistWithPage:(NSString *)page Uid:(NSString *)uid;
#pragma mark - 商城

/**
 商城
 Shop_index
 **/
- (void)Shop_indexWithNoParam;

/**
 商品详情
 id 商品的id
 type 我的商城 接口返回的type 商品、教辅、练习册
 Shop_info
 **/
- (void)Shop_infoWithId:(NSString *)id Type:(NSString *)type;

/**
 立即购买-确定 Shop_buy
 uid 当前会员id
 total 商品总价格
 goods 商品列表
 **/
- (void)Shop_buyWithUid:(NSString *)uid Total:(NSString *)total Goods:(NSArray *)goods;

/**
 确认订单 Shop_qrorder
 uid 当前会员id
 id 立即购买-确定 返回的订单id
 ordersn 订单号
 **/
- (void)Shop_qrorderWithUid:(NSString *)uid Id:(NSString *)id  Ordersn:(NSString *)ordersn;

/**
 地址添加 Member_addresstj
 uid 当前会员id
 name 姓名
 mobile 手机号
 sheng 省份id
 shi 市id
 qu 区id
 address 详细地址
 defaults 不为空则为默认
 **/
- (void)Member_addresstjWithUid:(NSString *)uid Name:(NSString *)name  Mobile:(NSString *)mobile  Sheng:(NSString *)sheng  Shi:(NSString *)shi  Qu:(NSString *)qu  Address:(NSString *)address  Defaults:(NSString *)defaults;

@end

