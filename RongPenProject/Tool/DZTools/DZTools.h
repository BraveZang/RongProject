//
//  DZTools.h
//  jiyouhui2020
//
//  Created by zanghui  on 2020/7/30.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"

#define DEFAULT_HIDE_DELAY 1.0

NS_ASSUME_NONNULL_BEGIN

@interface DZTools : NSObject

+ (MBProgressHUD *)sharedManager;
//是否登录
+ (BOOL)islogin;
//没有登录去登录
+ (BOOL)panduanLoginWithViewContorller:(UIViewController *)viewController isHidden:(BOOL)ishidden;
//清除空格
+ (NSString*)removeWhiteSpaceWithString:(NSString *)string;
//提示窗口
+ (void)MsgBox:(NSString *)msg title:(NSString *)title;
//判断是否是手机号
+ (BOOL)isTelPhoneNub:(NSString *)str;
//判断邮箱合法化
+ (BOOL)isValidateEmail:(NSString *)email;
+ (NSString *) getIOSDeviceInfo;
//获取当前app版本号
+ (NSString *) getAppVersion;
//获取当前window
+ (UIWindow *)getAppWindow;
//获取入口类
+ (AppDelegate *)getAppDelegate;
//获取当前的ViewController
+ (UIViewController *)topViewController;
//获得当前时间
+(NSString *)getCurrentTime;
//获得一条线
+(UIView *)getAlineView:(CGRect)frame;
+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;
#pragma mark -
#pragma mark 打开相机或相册
+ (UIImagePickerController *)openPhotoToViewController:(UIViewController *)ViewController sourceType:(UIImagePickerControllerSourceType)sourceType;
#pragma mark -
#pragma mark 切割图片
+ (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size;
#pragma mark -
#pragma mark 获得时间差
+(NSString *)getUTCFormateDate:(NSString *)newsDate;
#pragma mark -  MBProgressHUD 方法
/**
 *  只显示风火轮的HUB（不显示文字内容）
 */
+ (void)showHud;
/**
 *  只显示风火轮的HUB（不显示文字内容）
 *
 *  @param dalay 消失时间
 */
+ (void)showHudDelay:(NSTimeInterval)dalay;
/**
 *  只显示文字提示的HUB（不显示风火轮）
 *
 *  @param text  要显示的文本
 *  @param dalay 消失时间
 */
+ (void)showText:(NSString *)text delay:(NSTimeInterval)dalay;
/**
 *  同时显示风火轮和文本的HUB，不会自动消失
 *
 *  @param text 要显示的文本
 */
+ (void)showTextHud:(NSString *)text;

/**
 *  显示文本的HUB，不会自动消失
 *
 *  @param text 要显示的文本
 */
+ (void)showText:(NSString *)text;

/**
 *  移除HUB
 */
+ (void)hideHud;
/**
 *  同时显示风火轮和文本的HUB，会自动消失
 *
 *  @param text  要显示的文本
 *  @param dalay 消失时间
 */
+ (void)showTextHud:(NSString *)text delay:(NSTimeInterval)dalay;
/**
 *  提示成功的HUB
 *
 *  @param text  要显示的文本
 *  @param dalay 消失时间
 */
+ (void)showOKHud:(NSString *)text delay:(NSTimeInterval)dalay;
/**
 *  提示失败的HUB
 *
 *  @param text  要显示的文本
 *  @param dalay 消失时间
 */
+ (void)showNOHud:(NSString *)text delay:(NSTimeInterval)dalay;
+ (void)showAnimated:(NSString *)imageName delay:(NSTimeInterval)dalay;
+ (void)showqidaiHud:(NSString *)text delay:(NSTimeInterval)dalay;
/**
 * Creates a new HUD, adds it to provided view and shows it. The counterpart to this method is hideHUDForView:animated:.
 *
 * @note This method sets removeFromSuperViewOnHide. The HUD will automatically be removed from the view hierarchy when hidden.
 *
 * @param view The view that the HUD will be added to
 * @param animated If set to YES the HUD will appear using the current animationType. If set to NO the HUD will not use
 * animations while appearing.
 * @param imageName A gif image's name.
 * @return A reference to the created HUD.
 *
 * @see hideHUDForView:animated:
 * @see animationType
 */
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withAnimatedImage:(NSString *)imageName;

/**
 计算结算时间
 
 @param date 开始时间
 */
+ (void)calculateEndTime:(NSDate*)date;

/**
 初始化结束时间
 */
+ (void)deleteEndTime;
//获取结束时间
+ (NSDate*)getEndTime;
+ (NSInteger)getSecond;

//计算时间差
+ (NSString *) compareCurrentTime:(NSString *)str;
/**NSDictionary变为json字符串**/
+ (NSData *)toJSONData:(id)theData;

/**NSArray变为json字符串**/
+ (id)toArrayOrNSDictionary:(NSData *)jsonData;
//计算文字高度
+ (CGSize)sizeForString:(NSString *)string withSize:(CGSize)fitsize withFontSize:(NSInteger)fontSize;
//检查是否包含域名
+ (NSString *)chackUrl:(NSString *)string;
+ (NSInteger)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
//解析error
+ (void)jiexierrrorwitherror:(NSError *)error;
@end

NS_ASSUME_NONNULL_END
