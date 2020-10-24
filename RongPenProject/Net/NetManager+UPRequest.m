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

/// 编辑会员信息
/// @param uid 用户id
/// @param avatar 头像
/// @param nickname 昵称
/// @param grade 班级
/// @param age 年龄
/// @param sex 性别
- (void)member_usereditWithUid:(NSString *)uid Avatar:(NSString *)avatar NicName:(NSString *)nickname Grade:(NSString *)grade Age:(NSString *)age andSex:(NSString *)sex{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (avatar)[mutabDic setObject:avatar forKey:@"avatar"];
    if (nickname)[mutabDic setObject:nickname forKey:@"nickname"];
    if (grade)[mutabDic setObject:grade forKey:@"grade"];
    if (age)[mutabDic setObject:age forKey:@"age"];
    if (sex)[mutabDic setObject:sex forKey:@"sex"];
    [self sendPOSTRequestToServerWithURL:@"member_useredit" postData:mutabDic];
}

/// 编辑会员头像
/// @param uid 用户id
/// @param avatar 头像
/// @param nickname 昵称
/// @param grade 班级
/// @param age 年龄
/// @param sex 性别
- (void)member_userHeaderEditWithUid:(NSString *)uid Avatar:(NSData *)avatar NicName:(NSString *)nickname Grade:(NSString *)grade Age:(NSString *)age andSex:(NSString *)sex{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (avatar)[mutabDic setObject:avatar forKey:@"avatar"];
    if (nickname)[mutabDic setObject:nickname forKey:@"nickname"];
    if (grade)[mutabDic setObject:grade forKey:@"grade"];
    if (age)[mutabDic setObject:age forKey:@"age"];
    if (sex)[mutabDic setObject:sex forKey:@"sex"];
    
    [self uploadWithUrl:@"member_useredit" body:mutabDic imageData:avatar];
//    [self sendPOSTRequestToServerWithURL:@"" postData:mutabDic];
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



#pragma mark - 闯关听写

/// 获取教辅列表
/// @param uid 用户id
- (void)getMain_buybookWithUid:(NSString *)uid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    [self sendPOSTRequestToServerWithURL:@"main_buybook" postData:mutabDic];
}

/// 切换教材
/// @param uid 用户id
- (void)Pass_indexbookWithUid:(NSString *)uid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    [self sendPOSTRequestToServerWithURL:@"Pass_index" postData:mutabDic];
}



/// 闯关提交结果
/// @param uid 用户id
/// @param bookid 教辅id
/// @param unitid 单元id
/// @param gqid 关卡id
- (void)Pass_txresultWithUid:(NSString *)uid andBookId:(NSString *)bookid Unitid:(NSString *)unitid andGqid:(NSString *)gqid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (bookid)[mutabDic setObject:bookid forKey:@"bookid"];
    if (unitid)[mutabDic setObject:unitid forKey:@"unitid"];
    if (gqid)[mutabDic setObject:gqid forKey:@"gqid"];

    [self sendPOSTRequestToServerWithURL:@"Pass_txresult" postData:mutabDic];
}


/// 获取闯关听写-单元列表
/// @param uid 用户id
/// @param bookid 教辅id
- (void)Pass_txWithUid:(NSString *)uid andBookId:(NSString *)bookid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (bookid)[mutabDic setObject:bookid forKey:@"bookid"];

    [self sendPOSTRequestToServerWithURL:@"Pass_tx" postData:mutabDic];
}

/// 闯关听写-关卡列表
/// @param uid 用户id
/// @param bookid 教辅id
/// @param unitid 单元id
- (void)Pass_gqlistWithUid:(NSString *)uid andBookId:(NSString *)bookid andUnitid:(NSString *)unitid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (bookid)[mutabDic setObject:bookid forKey:@"bookid"];
    if (unitid)[mutabDic setObject:unitid forKey:@"unitid"];

    [self sendPOSTRequestToServerWithURL:@"Pass_gqlist" postData:mutabDic];
}


/// 闯关听写-关卡详情
/// @param uid 用户id
/// @param bookid 教辅id
/// @param unitid 单元id
/// @param gqid 关卡id
- (void)Pass_gqinfoWithUid:(NSString *)uid andBookId:(NSString *)bookid Unitid:(NSString *)unitid andGqid:(NSString *)gqid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (bookid)[mutabDic setObject:bookid forKey:@"bookid"];
    if (unitid)[mutabDic setObject:unitid forKey:@"unitid"];
    if (gqid)[mutabDic setObject:gqid forKey:@"gqid"];

    [self sendPOSTRequestToServerWithURL:@"Pass_gqinfo" postData:mutabDic];
}

#pragma mark - 闯关中英互译

/// 获取闯关中英互译-单元列表
/// @param uid 用户id
/// @param bookid 教辅id
- (void)Pass_cntoenWithUid:(NSString *)uid andBookId:(NSString *)bookid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (bookid)[mutabDic setObject:bookid forKey:@"bookid"];

    [self sendPOSTRequestToServerWithURL:@"Pass_cntoen" postData:mutabDic];
}

/// 闯关中英互译-关卡列表
/// @param uid 用户id
/// @param bookid 教辅id
/// @param unitid 单元id
- (void)Pass_cntoenlistWithUid:(NSString *)uid andBookId:(NSString *)bookid andUnitid:(NSString *)unitid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (bookid)[mutabDic setObject:bookid forKey:@"bookid"];
    if (unitid)[mutabDic setObject:unitid forKey:@"unitid"];

    [self sendPOSTRequestToServerWithURL:@"Pass_cntoenlist" postData:mutabDic];
}


/// 闯关中英互译-关卡详情
/// @param uid 用户id
/// @param bookid 教辅id
/// @param unitid 单元id
/// @param gqid 关卡id
- (void)Pass_cntoeninfoWithUid:(NSString *)uid andBookId:(NSString *)bookid Unitid:(NSString *)unitid andGqid:(NSString *)gqid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (bookid)[mutabDic setObject:bookid forKey:@"bookid"];
    if (unitid)[mutabDic setObject:unitid forKey:@"unitid"];
    if (gqid)[mutabDic setObject:gqid forKey:@"gqid"];

    [self sendPOSTRequestToServerWithURL:@"Pass_cntoeninfo" postData:mutabDic];
}



#pragma mark - 我的

/**
 我的课程(录播课程、直播课程) 参数 Course_index
 参数：
 page 分页 默认1
 type 录播、直播
 **/
- (void)Course_indexWithPage:(NSString *)page Type:(NSString *)type{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    
    if (page)[mutabDic setObject:page forKey:@"page"];
    if (type)[mutabDic setObject:type forKey:@"type"];
     [self sendPOSTRequestToServerWithURL:@"Course_index" postData:mutabDic];
}

/**
 已购课程 参数
 参数：
 uid 当前会员id
 page 分页 默认1
 **/
- (void)Course_orderlistWithPage:(NSString *)page Uid:(NSString *)uid{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    
    if (page)[mutabDic setObject:page forKey:@"page"];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
     [self sendPOSTRequestToServerWithURL:@"Course_orderlist" postData:mutabDic];
}

/// 我的消息
/// @param uid 用户id
- (void)Message_indexWithUid:(NSString *)uid{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
     [self sendPOSTRequestToServerWithURL:@"Message_index" postData:mutabDic];
}






/// 消息详情
/// @param uid 用户id
/// @param type type 类型 1.购买消息 2.上课提醒 3.系统消息
- (void)Message_infoWithUid:(NSString *)uid andType:(NSString *)type{
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    
    if (type)[mutabDic setObject:type forKey:@"type"];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
     [self sendPOSTRequestToServerWithURL:@"Message_info" postData:mutabDic];
}




#pragma mark - 商城

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

/**
 确认订单 Shop_qrorder
 uid 当前会员id
 id 立即购买-确定 返回的订单id
 ordersn 订单号
 **/
- (void)Shop_qrorderWithUid:(NSString *)uid Id:(NSString *)id  Ordersn:(NSString *)ordersn{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (id)[mutabDic setObject:id forKey:@"id"];
    if (ordersn)[mutabDic setObject:ordersn forKey:@"ordersn"];
    [self sendPOSTRequestToServerWithURL:@"Shop_qrorder" postData:mutabDic];
    
}

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
- (void)Member_addresstjWithUid:(NSString *)uid Name:(NSString *)name  Mobile:(NSString *)mobile  Sheng:(NSString *)sheng  Shi:(NSString *)shi  Qu:(NSString *)qu  Address:(NSString *)address  Defaults:(NSString *)defaults{
    
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (uid)[mutabDic setObject:uid forKey:@"uid"];
    if (name)[mutabDic setObject:name forKey:@"name"];
    if (mobile)[mutabDic setObject:mobile forKey:@"mobile"];
    if (sheng)[mutabDic setObject:sheng forKey:@"sheng"];
    if (shi)[mutabDic setObject:shi forKey:@"shi"];
    if (qu)[mutabDic setObject:qu forKey:@"qu"];
    if (address)[mutabDic setObject:address forKey:@"address"];
    if (defaults)[mutabDic setObject:defaults forKey:@"defaults"];
    [self sendPOSTRequestToServerWithURL:@"Shop_qrorder" postData:mutabDic];
    
}
@end




























