//
//  AppDelegate.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "MTool.h"
#import "MBProgressHUD.h"
#import "MAlertView.h"

static UIView *hudView = nil;
static NSString *token;
/** 当前网络状态 */
static AFNetworkReachabilityStatus NOW_NETWORK_STATUS;

@interface MTool ()
@end
@implementation MTool


+ (void)setNetworkStatus:(AFNetworkReachabilityStatus)sender {
    NOW_NETWORK_STATUS = sender;
}

+ (AFNetworkReachabilityStatus)getNetWorkStatus {
    
    
    return NOW_NETWORK_STATUS;
}
/**
 把大长串的数字做单位处理
 **/

+(NSString *)changeAsset:(NSString *)amountStr

{
    if(amountStr && ![amountStr isEqualToString:@""])
    {
        NSInteger num = [amountStr integerValue];
        if(num >=1000000000000)
        {
            NSString *str = [NSString stringWithFormat:@"%ld",num/1000000000000];
            return[NSString stringWithFormat:@"%@万亿",str];
        } else if(num >=100000000)
        {
            NSString *str = [NSString stringWithFormat:@"%ld",num/100000000];
            return[NSString stringWithFormat:@"%@亿",str];
        } else if(num >=10000000)
        {
            NSString *str = [NSString stringWithFormat:@"%ld",num/10000000];
            return[NSString stringWithFormat:@"%@千万",str];
        }else if(num >=10000)
        {
            NSString *str = [NSString stringWithFormat:@"%ld",num/10000];
            return[NSString stringWithFormat:@"%@万",str];
        }
    }
    return amountStr;
}


/**
 获取字典有序value数组
 对传入的字典key进行排序，依序提取value入数组
 @param dict NSDictionary
 @return NSArray
 */
+(NSMutableArray *) aryorderValueArrayWithDictionary:(NSDictionary *) dict {
    
    NSMutableArray *orderValueArray = [[NSMutableArray alloc]init];
    
    //取出字典所有key
    NSArray *keyArray = [dict allKeys];
    
    //将key排序
    NSArray *sortedArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    
    for (int i = 0 ; i < sortedArray.count ; i++)
    {
        NSString *key = sortedArray[i];
        NSString *value =[dict valueForKey:key];
        NSLog(@"%@ = %@",key,value);
        [orderValueArray addObject:value];
        
    }
    return orderValueArray;
    
}

+ (void)setToken:(NSString *)sender {
    token = [NSString stringWithFormat:@"%@", sender];
}

+ (NSString *)getToken {
    if (token) {
        if ([token length] > 0) {
            return token;
        }
    }
    return @"";
}


//计算UILabel的高度(带有行间距的情况)

+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width LineSpacing:(CGFloat)Spac withlab:(UILabel*)lab{
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:Spac];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
    [lab setAttributedText:attributedString1];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 6;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
    };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
/**
 将url字符转转为字典
 @param url
 @return NSDictionary
 */
+(NSMutableDictionary *)urlChangurl:(NSString *) url{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:0];
    url=[url encodeString:url];
    url=[url decodeString:url];
    NSRange range = [url rangeOfString:@"?"];
    NSString *propertys = [url substringFromIndex:(int)(range.location+1)];
    NSArray *stringUrlOne = [url componentsSeparatedByString:@"?"];
    NSString *beforepropertys = stringUrlOne[0];
    NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
    [tempDic  setValue:beforepropertys forKey:@"dicname"];
    for (int j = 0 ; j < subArray.count; j++)
    {
        //在通过=拆分键和值
        NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
        NSLog(@"再把每个参数通过=号进行拆分：\n%@", dicArray);
        //给字典加入元素
        [tempDic setObject:dicArray[1] forKey:dicArray[0]];
    }
    return tempDic;
    
}
//提示框
+(void)showImage:(NSString *)image title:(NSString *)title inView:(UIView *)view withCGsize:(CGSize)size afterDelay:(CGFloat)timer
{
    if (!image||!view) {
        return;
    }
    
    if (hudView) {
        [hudView removeFromSuperview];
        hudView = nil;
    }
    hudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    hudView.backgroundColor = [UIColor colorWithRed:(.0/255.0) green:(.0/255.0)  blue:(.0/255.0) alpha:.85];
    hudView.layer.cornerRadius = 5;
    hudView.layer.masksToBounds = YES;
    
    hudView.center = view.center;
    [view addSubview:hudView];
    hudView.hidden = NO;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(size.width/3, 45, size.width/3, size.height/3);
    imageView.image = [UIImage imageNamed:image];
    imageView.hidden = NO;
    [hudView addSubview:imageView];
    
    if (title&&title.length) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 32*size.width/45, size.width-40, 17)];
        label.text = title;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 1;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16.0f];
        label.textAlignment = NSTextAlignmentCenter;
        [hudView addSubview:label];
    }
    if (timer>0) {
        [self performSelector:@selector(hideImageView) withObject:nil afterDelay:timer];
    }
}

+ (void)hideImageView
{
    hudView.hidden = YES;
    [hudView removeFromSuperview];
    hudView = nil;
}


+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}



+ (void)showMessage:(NSString *)message inView:(UIView *)view
{
    if (!view)
    {
        AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        view = app.window;
    }
    
    MAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"MAlertView" owner:nil options:nil] objectAtIndex:0];
    [alertView showWithTitle:message inView:view];
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize textSize = CGSizeZero;
    
    // 7.0 系统的适配处理。
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    textSize = [text boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:tdic
                                  context:nil].size;
    
    return textSize;
}

#pragma mark - 压缩图片

+ (NSData *)imageCompressToData:(UIImage *)image{
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    if (data.length>300*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(image, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(image, 0.5);
        }else if (data.length>300*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(image, 0.9);
        }
    }
    return data;
}
//防止图片过大旋转
+(UIImage *)fixOrientation:(UIImage *)image{
    
    
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    if (data.length>300*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(image, 0.05);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(image, 0.5);
        }else if (data.length>300*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(image, 0.9);
        }
    }
    //        NSData *imageData = [NSData dataWithContentsOfFile:data];
    UIImage *aImage = [UIImage imageWithData:data];
    
    
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark - 去掉换行符

+ (NSString *)removeSpaceAndNewline:(NSString *)str

{
    
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return temp;
    
}
#pragma mark - 图片转化为UIImage
+(UIImage *) getImageFromURL:(NSString *)fileURL

{
    if ([fileURL containsString:@"http"]) {
        fileURL=fileURL;
    }
    else {
        fileURL=[NSString stringWithFormat:@"%@%@",kIMageUrl,fileURL];
    }
    UIImage * result;
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
       result = [UIImage imageWithData:data];
       return result;
    
}
#pragma mark - 将YYYY-MM-dd HH:mm:ss时间转换为MM-dd HH:mm的时间格式
/**
 * @brief   将YYYY-MM-dd HH:mm:ss时间转换为MM-dd HH:mm的时间格式
 * @param   uiDate    YYYY-MM-dd HH:mm:ss时间
 * @return  NSString   MM-dd HH:mm 时间
 */
+ (NSString *)convertDateStringFromString:(NSString*)uiDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
    NSDate *date=[formatter dateFromString:uiDate];
    
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}


+(NSDate*) convertDateFromString:(NSString*)uiDate geshi:(NSString*)geshi
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:geshi];
    NSDate *date=[formatter dateFromString:uiDate];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [zone secondsFromGMTForDate:date];
    NSDate *currentDate = [date dateByAddingTimeInterval:interval];
    NSLog(@"data %@",date);
    return currentDate;
}

+ (NSDate *)stringDateToDate:(NSString *)dateString {
    //    @"2013-03-24 10:45:32"
    NSString *currentDateString = dateString;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"HH:mm:ss"];
    return [dateFormater dateFromString:currentDateString];
}
+(NSString*)getCurrentTimes
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"MM.dd"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}
//获取一周的日期
+(NSArray *)adddDataOnViews{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    // weekDay = 1;
    if (weekDay == 1)
    {
        firstDiff = -6;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    // NSLog(@"firstDiff: %ld lastDiff: %ld",firstDiff,lastDiff);
    // 在当前日期(去掉时分秒)基础上加上差的天
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMdd"];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@""];
    [formatter1 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSString *monthStr = [formatter1 stringFromDate:[NSDate date]];
    
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    NSLog(@"%@=======%@",firstDay,lastDay);
    
    int firstValue = firstDay.intValue;
    int lastValue = lastDay.intValue;
    
    NSMutableArray *dateArr = [[NSMutableArray alloc]init];
    if (firstValue < lastValue) {
        
        for (int j = 0; j<7; j++) {
            NSString *obj = [NSString stringWithFormat:@"%d",firstValue+j];
            NSString *str1 = [obj substringToIndex:2];//截取掉下标2之前的字符串
            NSLog(@"截取的值为：%@",str1);
            NSString *str2 = [obj substringFromIndex:2];//截取掉下标1之后的字符串
            NSString*resultStr=[NSString stringWithFormat:@"%@.%@",str1,str2];
            [dateArr addObject:resultStr];
        }
    }
    else if (firstValue > lastValue)
    {
        for (int j = 0; j < 7-lastValue; j++) {
            NSString *obj = [NSString stringWithFormat:@"%d",firstValue+j];
            NSString *str1 = [obj substringToIndex:2];//截取掉下标2之前的字符串
            NSLog(@"截取的值为：%@",str1);
            NSString *str2 = [obj substringFromIndex:2];//截取掉下标1之后的字符串
            NSString*resultStr=[NSString stringWithFormat:@"%@.%@",str1,str2];
            [dateArr addObject:resultStr];
        }
        for (int z = 0; z<lastValue; z++) {
            
            NSString *obj = [NSString stringWithFormat:@"%d",z+1];
            NSString *str1 = [obj substringToIndex:2];//截取掉下标2之前的字符串
            NSLog(@"截取的值为：%@",str1);
            NSString *str2 = [obj substringFromIndex:2];//截取掉下标1之后的字符串
            NSString*resultStr=[NSString stringWithFormat:@"%@.%@",str1,str2];
            [dateArr addObject:resultStr];
        }
    }
    return dateArr;
    
}
//1406702751547
+ (NSString *)dateAllStringFromString:(NSString *)timeString
{
    return [MTool dateStringFromString:timeString toFormat:@"HH:mm"];
}
//根据时间戳 获取多少分钟前 多少小时前  多少天前
+(NSString*)distanceTimeWithBeforeTime:(double)beTime

{
    
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    
    double distanceTime = now - beTime;
    
    NSString* distanceStr;
    
    NSDate* beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"HH:mm"];
    
    NSString* timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    
    NSString* nowDay = [df stringFromDate:[NSDate date]];
    
    NSString* lastDay = [df stringFromDate:beDate];
    
    if(distanceTime <60) {//小于一分钟
        
        distanceStr =@"刚刚";
        
    }
    
    else if(distanceTime <60*60) {//时间小于一个小时
        
        distanceStr = [NSString stringWithFormat:@"%d分钟前",(int)distanceTime/60];
        
    }
    
    else if(distanceTime <24*60*60&& [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        
        distanceStr = [NSString stringWithFormat:@"%d小时前",(int)distanceTime/60/60];
        
    }
    
    else if(distanceTime<24*60*60*2&& [nowDay integerValue] != [lastDay integerValue]){
        
        if([nowDay integerValue] - [lastDay integerValue] ==1|| ([lastDay integerValue] - [nowDay integerValue] >10&& [nowDay integerValue] ==1)) {
            
            distanceStr = @"1天前";
            
        }
        
    }
    
    else if(distanceTime <24*60*60*7){
        
        //[df setDateFormat:@"MM-dd HH:mm"];
        
        distanceStr = [NSString stringWithFormat:@"%d天前",(int)distanceTime/24/60/60];
        
    }
    else if(distanceTime <24*60*60*7*2){
        
        
        distanceStr =@"1周前";
        
    }
    else if(distanceTime <24*60*60*7*3){
        
        
        distanceStr =@"2周前";
        
    }
    else if(distanceTime <24*60*60*7*4){
        
        //[df setDateFormat:@"MM-dd HH:mm"];
        
        distanceStr =@"3周前";
        
    }
    
    else{
        
        [df setDateFormat:@"HH:mm"];
        
        distanceStr = [df stringFromDate:beDate];
        
    }
    
    return distanceStr;
    
}


+ (NSString *)datePartStringFromString:(NSString *)timeString
{
    return [MTool dateStringFromString:timeString toFormat:@"YYYY-MM-dd"];
}

+(NSString *)getNowTimeTimestamp{
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}
/**
 *  获取当前的13位的时间戳
 */
+ (NSString *)getNow1970Date{
    
    NSDate *date = [NSDate date];
    //    NSLog(@"%lf",[date timeIntervalSince1970] * 1000);
    return [NSString stringWithFormat:@"%.lf",[date timeIntervalSince1970] * 1000];
}
/**
 *  将13位时间转换为年月日
 */
+(NSString *)dateSub10String:(NSString *)timeString{
    return [[self dateAllStringFromString:timeString] substringToIndex:10];
}
+(NSDate *)datejishuangYear:(int)year Month:(int)month Day:(int)day withData:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //NSCalendarIdentifierGregorian:iOS8之前用NSGregorianCalendar
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    //NSCalendarUnitYear:iOS8之前用NSYearCalendarUnit,NSCalendarUnitMonth,NSCalendarUnitDay同理
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:year];
    
    [adcomps setMonth:month];
    
    [adcomps setDay:day];
    
    return [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
}

#pragma mark - 将13位时间转换为想要的时间格式
/**
 * @brief   将13位时间转换为想要的时间格式
 * @param   timeString    13位时间
 * @param   toFormat    格式（如：YYYY-MM-dd HH:mm:ss）
 * @return  NSString 时间
 */
+ (NSString *)dateStringFromString:(NSString *)timeString toFormat:(NSString *)toFormat
{
    // 初始化时间格式控制器
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    // 设置设计格式
    [matter setDateFormat:toFormat];
    NSTimeInterval time = [timeString doubleValue];
    NSDate * Date = [NSDate dateWithTimeIntervalSince1970:time];
    // 进行转换
    NSString *date = [matter stringFromDate:Date];
    return date;
}

+ (NSString *)ConvertStrToTime:(NSString *)timeStr

{
    
        long long time=[timeStr longLongValue];
    
        NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000];
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
        NSString*timeString=[formatter stringFromDate:d];
    
        return timeString;
    
}
+ (NSString *)stringToDate:(NSString *)dateStr {
    
    // 初始化时间格式控制器
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    // 设置设计格式
    [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
    NSTimeInterval time = [dateStr doubleValue];
    NSDate * Date = [NSDate dateWithTimeIntervalSince1970:time];
    // 进行转换
    NSString *date = [matter stringFromDate:Date];
    
    return date;
}
/**
 将日期转换为星期
 
 @param timeString 时间戳
 @return 星期
 */
+ (NSString *)getWeekWithTimeString:(NSString *)timeString{
    
    NSTimeInterval timeInterval;
    if (timeString.length >= 10){
        timeInterval = [timeString doubleValue]/1000;
    }else{
        timeInterval = [timeString doubleValue];
    }
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSArray*weekdays = [NSArray arrayWithObjects: [NSNull null],@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    
    NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone*timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit =NSCalendarUnitWeekday;
    
    NSDateComponents*theComponents = [calendar components:calendarUnit fromDate:date];
    
    return[weekdays objectAtIndex:theComponents.weekday];
    
    
    
}

+ (NSString*)compareTwoTime:(NSString *)timeStr time2:(NSString *)timeStr2{
    
    long long time1 = [timeStr longLongValue];
    long long time2 = [timeStr2 longLongValue];
    
    NSTimeInterval balance = time2 /1000- time1 /1000;
    
    NSString*timeString = [[NSString alloc]init];
    
    timeString = [NSString stringWithFormat:@"%f",balance /60];
    
    timeString = [timeString substringToIndex:timeString.length-7];
    
    return timeString;
    
    
    
}




+ (NSString *)dateToString:(NSDate *)sender {
    //    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [sender timeIntervalSince1970];
    //    NSTimeInterval now = [sender timeIntervalSince1970];
    
    NSMutableString *stringTime = [NSMutableString stringWithFormat:@"%lld", (long long)now];
    //    if ([stringTime length] < 13) {
    //        while ([stringTime length] < 13) {
    //            [stringTime appendString:@"0"];
    //        }
    //    }
    
    return stringTime;
}

+ (NSString *)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

+ (BOOL)getCurrentRefresh
{
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [myDefault objectForKey:@"refresh"];
    if (personData) {
        return  [[NSKeyedUnarchiver unarchiveObjectWithData:personData] boolValue];
    }
    return nil;
}

+ (NSInteger)getCurrentRefreshTimeInterval
{
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [myDefault objectForKey:@"timeInterval"];
    if (personData) {
        return  [[NSKeyedUnarchiver unarchiveObjectWithData:personData] integerValue];
    }
    return 0;
}


#pragma mark - 正则校验
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL) deptNumInputShouldNumber:(NSString *)str
{
     NSString *regex = @"[0-9]*";
     NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
     return ([pred evaluateWithObject:str]) ;
}



#pragma mark - 设置是否开启推送
/**
 * @brief   设置是否开启推送
 * @param   open    YES开启，NO不开启
 * @return  是否成功
 */
+ (BOOL)storeCurrentOpenAPN:(NSString *)open {
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:open];
    if (personData) {
        [myDefault setObject:personData forKey:@"isOpenAPN"];
        [myDefault synchronize];
        return YES;
    }
    return NO;
}

#pragma mark - 得到是否开启推送
/**
 * @brief   得到是否开启推送
 * @return  YES开启，NO不开启
 */
+ (NSString *)getOpenAPN {
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [myDefault objectForKey:@"isOpenAPN"];
    if (personData) {
        return  [NSKeyedUnarchiver unarchiveObjectWithData:personData];
    }
    return nil;
}


#pragma mark - 设置是否显示过引导页
/**
 * @brief   是否显示过引导页
 * @param   version    版本号，如果版本号与得到的版本号一至就是显示过，如果没有版本号或是与当前得到的版本号不一至就是没有显示过
 * @return  是否成功
 */
+ (BOOL)storeCurrentShowGuide:(NSString *)version {
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:version];
    if (personData) {
        [myDefault setObject:personData forKey:@"showGuide"];
        [myDefault synchronize];
        return YES;
    }
    return NO;
}

#pragma mark - 得到是否显示过引导页
/**
 * @brief   是否显示过引导页
 * @return  版本号，如果版本号与得到的版本号一至就是显示过，如果没有版本号或是与当前得到的版本号不一至就是没有显示过
 */
+ (NSString *)getShowGuide {
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [myDefault objectForKey:@"showGuide"];
    if (personData) {
        return  [NSKeyedUnarchiver unarchiveObjectWithData:personData];
    }
    return nil;
}


+ (NSString *)getCurrentLastLoginState
{
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [myDefault objectForKey:@"loginState"];
    if (personData) {
        return  [NSKeyedUnarchiver unarchiveObjectWithData:personData];
    }
    return nil;
}
+ (BOOL)storeNotificationState:(BOOL)b
{
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    
    NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:[NSNumber numberWithBool:b]];
    if (personData) {
        [myDefault setObject:personData forKey:@"NotificationState"];
        [myDefault synchronize];
        return YES;
    }
    return NO;
}

+(BOOL)getNotificationState
{
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [myDefault objectForKey:@"NotificationState"];
    if (personData) {
        return  [[NSKeyedUnarchiver unarchiveObjectWithData:personData] boolValue];
    }
    return YES;
}

+ (BOOL)storeVoiceState:(BOOL)b
{
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:[NSNumber numberWithBool:b]];
    if (personData) {
        [myDefault setObject:personData forKey:@"VoiceState"];
        [myDefault synchronize];
        return YES;
    }
    return NO;
}

+(BOOL)getVoiceState
{
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [myDefault objectForKey:@"VoiceState"];
    if (personData) {
        return  [[NSKeyedUnarchiver unarchiveObjectWithData:personData] boolValue];
    }
    return YES;
}

+(BOOL)storeCurrentMessage:(NSDictionary *)curretnPersonDic
{
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:curretnPersonDic];
    if (personData) {
        [myDefault setObject:personData forKey:@"login"];
        [myDefault synchronize];
        return YES;
    }
    return NO;
}

+ (NSMutableDictionary  *)getCurrentMessage
{
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSData *personData = [myDefault objectForKey:@"login"];
    if (personData) {
        return  [NSKeyedUnarchiver unarchiveObjectWithData:personData];
    }
    return nil;
}


/** 存储当前用户信息 */
+(BOOL)storeCurrentUserModel:(User *)userModel{
    // 沙盒路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
    
    //存进沙盒 自定义对象的存储必须用NSKeyedArchiver，
    BOOL choose = [NSKeyedArchiver archiveRootObject:userModel toFile:path];
    return choose;
}

/** 获取当前用户信息 */
+ (User  *)getCurrentUserModel{
    // 取出对象沙盒路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

//清除当前信息
+ (void)removeCurrentMessage
{
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault removeObjectForKey:@"login"];
}

/**
 * Retain a formated string with a real date string
 *
 * @param dateString a real date string, which can be converted to a NSDate object
 *
 * @return a string that will be x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
+ (NSString *)timeInfoWithDateString:(NSString *)dateString {
    // 把日期字符串格式化为日期对象
    NSDate *date = nil;
    if (dateString.length == 13)
    {
        NSTimeInterval timeInterval = [dateString doubleValue]/1000;
        date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        date = [MTool getNowDateFromatAnDate:date];
    } else {
        return @"";
    }
    
    NSDate *curDate = [NSDate date];
    curDate = [MTool getNowDateFromatAnDate:curDate];
    //    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *curDateComps;// = [[NSDateComponents alloc] init];
    curDateComps = [calendar components:unitFlags fromDate:curDate];
    
    NSDateComponents *dateComps;// = [[NSDateComponents alloc] init];
    dateComps = [calendar components:unitFlags fromDate:date];
    
    
    
    if ([curDateComps day] == [dateComps day]) {
        return [MTool dateStringFromString:dateString toFormat:@"HH:mm"];
    } else {
        return [NSString stringWithFormat:@"%ld天前", (long)abs([MTool intervalSinceNow:dateString])];
    }
    
    return @"1小时前";
}


+ (int)intervalSinceNow: (NSString *) theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSince1970:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        return [timeString intValue];
    }
    return -1;
}


+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}




/**
 * @brief   通过text view中的文字与宽度，计算出高度
 * @param   textView 要计算的textView
 * @return  CGSize  计算后的大小
 */
+ (CGSize)contentSizeHeightOfTextView:(UITextView *)textView {
    CGSize textViewSize = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, FLT_MAX)];
    
    return textViewSize;
}

/**
 * @brief   通过label中的文字与宽度，计算出高度
 * @param   label 要计算的label
 * @return  CGSize  计算后的大小
 */
+ (CGSize)contentSizeHeightOfLabel:(UILabel *)label {
    CGSize labelSize = [label sizeThatFits:CGSizeMake(label.frame.size.width, FLT_MAX)];
    
    return labelSize;
}

/**
 * @brief   通过label中的文字与高度，计算出宽度
 * @param   label 要计算的label
 * @return  CGSize  计算后的大小
 */
+ (CGSize)contentSizeWidthOfLabel:(UILabel *)label {
    CGSize labelSize = [label sizeThatFits:CGSizeMake(FLT_MAX, label.frame.size.height)];
    
    return labelSize;
}


/**
 * @brief   复制View
 * @param   view 要复制的view
 * @return  UIView  复制的View
 */
+ (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}


/**
 * @brief   检查是否是数组，数组长度是否大于0
 * @param   id 要检查的对象
 * @return  BOOL
 */
+ (BOOL)checkingIsArray:(id)sender {
    
    if (sender) {
        if ([sender isKindOfClass:[NSArray class]] || [sender isKindOfClass:[NSMutableArray class]]) {
            if ([sender count] > 0) {
                return YES;
            }
        }
    }
    
    return NO;
}

/**
 * @brief   检查是否是string，长度是否大于0
 * @param   id 要检查的对象
 * @return  BOOL
 */
+ (BOOL)checkingIsString:(id)sender {
    if (sender) {
        if ([sender isKindOfClass:[NSString class]] ||[sender isKindOfClass:[NSMutableString class]]) {
            if ([sender length] > 0) {
                if ([sender isEqualToString:@"(null)"]) {
                    return NO;
                }
                return YES;
            }
        }
    }
    return NO;
}

/**
 * @brief   检查是否是Dic，长度是否大于0
 * @param   id 要检查的对象
 * @return  BOOL
 */
+ (BOOL)checkingIsDic:(id)sender {
    if (sender) {
        if ([sender isKindOfClass:[NSDictionary class]] ||[sender isKindOfClass:[NSMutableDictionary class]]) {
            if ([sender count] > 0) {
                return YES;
            }
        }
    }
    return NO;
}



/**
 * @brief   读取plist文件，得到内容为DIC
 * @param   fileName plist名
 * @return  NSMutableDictionary
 */
+ (NSMutableDictionary *)readPlistToDic:(NSString *)fileName {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (data) {
        if ([data isKindOfClass:[NSMutableDictionary class]]) {
            return data;
        }
    }
    return nil;
}

/**
 * @brief   将DIC写入到plist文件
 * @param   fileName plist名
 * @param   dataDic DIC
 */
+ (void)pushDicToPlist:(NSMutableDictionary *)dataDic fileName:(NSString *)fileName {
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
    
    //输入写入
    [dataDic writeToFile:filename atomically:YES];
    
    //    //那怎么证明我的数据写入了呢？读出来看看
    //    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    //    NSLog(@"%@", data1);
}





/**
 * @brief   读取plist文件，得到内容为Array
 * @param   fileName plist名
 * @return  NSMutableArray
 */
+ (NSMutableArray *)readPlistToArray:(NSString *)fileName {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if (data) {
        if ([data isKindOfClass:[NSMutableArray class]]) {
            return data;
        }
    }
    return nil;
}

/**
 * @brief   将Array写入到plist文件
 * @param   fileName plist名
 * @param   dataArray array
 */
+ (void)pushArrayToPlist:(NSMutableArray *)dataArray fileName:(NSString *)fileName {
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
    //输入写入
    [dataArray writeToFile:filename atomically:YES];
    
    //    //那怎么证明我的数据写入了呢？读出来看看
    //    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    //    NSLog(@"%@", data1);
}


/**
 * @brief   文件是否存在
 * @param   path 路径
 * @param   isCreate 如果不存在，是否创建  YES创建、NO不创建
 * @param   BOOL
 */
+ (BOOL)fileExists:(NSString *)path isCreate:(BOOL)isCreate{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    if ([fileManager fileExistsAtPath:path]) {//如果文件存在
        NSLog(@"文件已经存在");
        return YES;
    } else {
        if (isCreate) {
            [fileManager createFileAtPath:path contents:nil attributes:nil];
        }
    }
    return NO;
}


/**
 * @brief   文件是否存在在Documents目录下
 * @param   name 文件名
 * @param   isCreate 如果不存在，是否创建  YES创建、NO不创建
 * @param   BOOL
 */
+ (BOOL)fileExistsForName:(NSString *)name isCreate:(BOOL)isCreate {
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:name];
    
    return [MTool fileExists:filename isCreate:isCreate];
}


/**
 * @brief   将信息写入到plist
 * @param   sender 信息DIC
 */
+ (void)pushDicToPlist:(NSMutableDictionary *)sender name:(NSString *)name{
    [MTool fileExistsForName:[NSString stringWithFormat:@"%@.plist", name] isCreate:YES];
    [MTool pushDicToPlist:sender fileName:name];
}

/**
 * @brief   得到plist信息
 * @return  NSString 文件名
 */
+ (NSDictionary *)getDicFromPlist:(NSString *)name {
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", name]];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    if (data) {
        if ([data isKindOfClass:[NSMutableDictionary class]]) {
            return data;
        }
    }
    return nil;
}


/**
 * @param sender 地区信息数组
 * @param province 要查询的省
 * @return NSDictionary 省信息
 */
+ (NSDictionary *)getProvince:(NSArray *)sender province:(NSString *)province {
    for (NSDictionary *temp in sender) {
        if ([MTool checkingIsDic:temp]) {
            if ([[temp objectForKey:@"name"] isEqualToString:province] || [[temp objectForKey:@"code"] isEqualToString:province]) {
                return temp;
            }
        }
    }
    return nil;
}

/**
 * @param sender 地区信息数组
 * @param city 要查询的市
 * @return NSDictionary 市信息
 */
+ (NSDictionary *)getCity:(NSArray *)sender city:(NSString *)city {
    for (NSDictionary *temp in sender) {
        if ([MTool checkingIsDic:temp]) {
            if ([[temp objectForKey:@"name"] isEqualToString:city]) {
                return temp;
            }
        }
    }
    return nil;
}



+ (void)callPhone:(NSString *)phoneNum {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNum]]];
}



+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}





/**
 * @brief   设置view圆角
 * @param   radius 圆角度数
 * @param   corners 哪个角需要圆
 * UIRectCornerTopLeft
 * UIRectCornerTopRight
 * UIRectCornerBottomLeft
 * UIRectCornerBottomRight
 * UIRectCornerAllCorners
 * @param   view
 */
+ (void)setViewRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners view:(id)view {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:((UIView *)view).bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = ((UIView *)view).bounds;
    maskLayer.path = maskPath.CGPath;
    ((UIView *)view).layer.mask = maskLayer;
}


/**
 * @brief   设置圆角
 * @param   radius 圆角度数
 * @param   view
 */
+ (void)setViewRadius:(CGFloat)radius view:(id)view {
    ((UIView *)view).layer.cornerRadius = radius;
    ((UIView *)view).layer.masksToBounds = YES;
}






/**
 * @brief   描边
 * @param   borderWidth 边宽度
 * @param   color 颜色
 * @param   view
 */
+ (void)setViewBorder:(CGFloat)borderWidth color:(UIColor *)color view:(id)view {
    ((UIView *)view).layer.borderColor = color.CGColor;
    ((UIView *)view).layer.borderWidth = borderWidth;
}

/**
 * @brief   描边并加圆角
 * @param   borderWidth 边宽度
 * @param   color 颜色
 * @param   radius 圆角度数
 * @param   view
 */
+ (void)setViewRadiusAndBorder:(CGFloat)borderWidth color:(UIColor *)color radius:(CGFloat)radius view:(id)view {
    ((UIView *)view).layer.cornerRadius = radius;
    ((UIView *)view).layer.masksToBounds = YES;
    ((UIView *)view).layer.borderColor = color.CGColor;
    ((UIView *)view).layer.borderWidth = borderWidth;
}

/**
 * @brief   描边并加圆角 圆角4 颜色153/153/153 线宽0.5
 * @param   view
 */
+ (void)setViewRadiusAndBorder:(id)view {
    ((UIView *)view).layer.cornerRadius = 4;
    ((UIView *)view).layer.masksToBounds = YES;
    ((UIView *)view).layer.borderColor = RGBCOLOR(153, 153, 153).CGColor;
    ((UIView *)view).layer.borderWidth = 0.5;
}

/**
 * @brief   设置UITextField左边距
 * @param   textField textField
 * @param   leftWidth 距离
 */
+ (void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth {
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}


/**
 * @brief   播放按键音
 * @param   soundName 声音名
 */
+ (void)playSound:(NSString *)soundName {
    
    if (![MTool getVoiceState]) {//声音关了
        return;
    }
    
    //    NSString *playSound = [userinfo whetherPlayingMusic];
    //    if ([playSound length] > 0) {
    //        if ([playSound integerValue] != 1) {
    //            return;
    //        }
    //    } else {
    //        [userinfo setWhetherToPlaySound:@"1"];
    //    }
    NSString *path = [[NSBundle mainBundle]pathForResource:@"chack.wav" ofType:nil];
    if ([MTool checkingIsString:soundName]) {
        path = [[NSBundle mainBundle]pathForResource:soundName ofType:nil];
    }
    
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    if (error == kAudioServicesNoError){
        NSLog(@"sadfasfdsf ");
    }else {
        NSLog(@"Failed to create sound ");
    }
    
    AudioServicesPlaySystemSound(soundID);
}


#pragma mark -手机别名
+(NSString *)phoneName
{
    return [[UIDevice currentDevice] name];
}


#pragma mark -手机系统版本
/**
 *  手机系统版本
 *
 *  @return e.g. 8.0
 */
+(NSString *)phoneVersion{
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark -手机型号
//这个方法只能获取到iPhone、iPad这种信息，无法获取到是iPhone 4、iPhpone5这种具体的型号。
/**
 *  手机型号
 *
 *  @return e.g. iPhone
 */
+(NSString *)phoneModel{
    return [[UIDevice currentDevice] model];
}


#pragma mark - 设备版本
//这个代码可以获取到具体的设备版本（已更新到iPhone 6s、iPhone 6s Plus），缺点是：采用的硬编码。具体的对应关系可以参考：https://www.theiphonewiki.com/wiki/Models
//这个方法可以通过AppStore的审核，放心用吧。
/**
 *  设备版本
 *
 *  @return e.g. iPhone 5S
 */
+ (NSString *)DeviceVersion {
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceString;
}


/**
 * @brief   提示框展示纯文字类型
 * @param   text 文字
 * @param   showTime 显示时间
 */
//+ (void)showText:(NSString *)text showTime:(NSInteger)showTime{
//    
//    UIView *view = [[UIApplication sharedApplication].windows firstObject];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.userInteractionEnabled = NO;
//    hud.mode = MBProgressHUDModeText;
//    
//    hud.label.text = text;
//    hud.label.numberOfLines = 0;
//    hud.label.textColor = [UIColor whiteColor];
//    hud.label.font = [UIFont systemFontOfSize:20];
//    
////    这个是提示框的背景View
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.68];
//    [hud hideAnimated:YES afterDelay:showTime];
//}



/**
 * @brief   提示框展示纯文字类型
 * @param   text 文字
 */
//+ (void)showText:(NSString *)text{
//    [self showText:text showTime:2];
//}




/**
 * @brief   把Button的图标放在文字的右边  前提是文字跟图片有值   多加了3像素的间隙
 * @param
 */
+ (void)rightButtonImg:(UIButton *)button{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = button.titleLabel.font;
    
    CGFloat textW = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width + button.imageView.bounds.size.width + 3;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, textW, 0, -textW);
    //    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.bounds.size.width, 0, button.imageView.bounds.size.width);
}


/**
 * @brief   给要视图裁圆 切增加阴影  (masksToBounds= NO的情况下)
 * @param   view        需要加效果的视图
 * @param   isSquare    方的阴影还是圆的
 */
+ (void)addShadow:(UIView *)view shadowColor:(UIColor *)color isSquare:(BOOL)isSquare{
    
    view.layer.shadowColor = color.CGColor;
     // 阴影偏移，默认(0, -3)
       view.layer.shadowOffset = CGSizeMake(0,0);
       // 阴影透明度，默认0
    view.layer.shadowOpacity = 0.5;
       // 阴影半径，默认3
       view.layer.shadowRadius = 3;
    
    if (isSquare) {
        CGMutablePathRef squarePath = CGPathCreateMutable();
        CGPathAddRect(squarePath, NULL, view.bounds);
        view.layer.shadowPath = squarePath; CGPathRelease(squarePath);
    }else{
        CGMutablePathRef circlePath = CGPathCreateMutable();
        CGPathAddEllipseInRect(circlePath, NULL, view.bounds);
        view.layer.shadowPath = circlePath; CGPathRelease(circlePath);
    }
}

/**
 * @brief   给要视图裁圆 切增加阴影  (masksToBounds=YES 的情况下)
 * @param   view        需要加效果的视图
 * @param   corner      裁圆的角度
 * @param   superView   view的父视图
 * @param   shadowColor 阴影颜色
 * @param   isSquare    方的阴影还是圆的
 * @param   frame       这是因为有的XIB 布局的空间 阴影错位
 */
+ (void)addShadow:(UIView *)view cornerValue:(CGFloat)corner superView:(UIView*)superView shadowColor:(UIColor *)color isSquare:(BOOL)isSquare frame:(CGRect)frame{
    
    view.layer.cornerRadius =corner;
    view.layer.masksToBounds = YES;
    
    CALayer *subLayer=[CALayer layer];
    
    CGRect fixframe;
    if (frame.size.width) {
        fixframe = frame;
    }else{
        fixframe = view.layer.frame;
    }
    
    subLayer.frame=  fixframe;
    subLayer.cornerRadius = corner;
    
    subLayer.backgroundColor=[UIColor clearColor].CGColor;
    
    subLayer.shadowColor= color.CGColor;
    
    subLayer.shadowOpacity=1;
    
    subLayer.shadowRadius= 6;
    subLayer.shadowOffset = CGSizeMake(0, 1);
    
    if (isSquare) {
        CGMutablePathRef squarePath = CGPathCreateMutable();
        CGPathAddRect(squarePath, NULL, view.bounds);
        subLayer.shadowPath = squarePath; CGPathRelease(squarePath);
    }else{
        CGMutablePathRef circlePath = CGPathCreateMutable();
        CGPathAddEllipseInRect(circlePath, NULL, view.bounds);
        subLayer.shadowPath = circlePath; CGPathRelease(circlePath);
    }
    [superView.layer insertSublayer:subLayer below:view.layer];
}

//根据文字跟最大宽计算出控件该有的高度
+ (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    return [self sizeWithText:text font:font maxSize:maxSize].height;;
    
}

//根据文字跟最大宽计算出
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    NSString *string = [NSString stringWithFormat:@"%@",text];
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}



/**
 * @brief  快速创建Lable
 * @param   left 左边距离
 * @param   top 顶部距离
 * @param   width 宽度
 * @param   heigh 高度
 * @param   title 文字
 */

+(UILabel *)quickCreateLabelWithleft:(CGFloat)left top:(CGFloat)top width:(CGFloat)width heigh:(CGFloat)heigh title:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left, top, width, heigh)];
    label.text = title;
    //    label.backgroundColor = [UIColor orangeColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:8];
    return label;
    
}
/**
 * @brief  快速创建UITextField
 * @param   frame 位置大小
 
 */
+(UITextField*)CreateTextFieldWithFrame:(CGRect)frame withCapacity:(NSString *)placeholder withSecureTextEntry:(BOOL)isSecoure withTargrt:(id)t withTag:(NSInteger)tag {
    UITextField * qcTextfield = [[UITextField alloc]initWithFrame:frame];
    [[UITextField appearance] setTintColor:[UIColor lightGrayColor]];
    //qcTextfield.background = [UIImage imageNamed:image];
    qcTextfield.backgroundColor = [UIColor clearColor];
    //qcTextfield.clearButtonMode = UITextFieldViewModeAlways;
    qcTextfield.returnKeyType = UIReturnKeyDefault;
    qcTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    qcTextfield.secureTextEntry = isSecoure;
    qcTextfield.placeholder = placeholder;
    qcTextfield.delegate = t;
    qcTextfield.tag = tag;
    return qcTextfield;
    
}



/**
 *  @author chenglibin
 *
 *  十六进制颜色转换成
 *
 *  @param stringToConvert // 例如： @"#123456"
 
 *
 *  @return UIColor
 */


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    NSInteger r = (hex >> 16) & 0xFF;
    NSInteger g = (hex >> 8) & 0xFF;
    NSInteger b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}


/**
 获取字符串字符长度
 
 @param text 字符串
 @return 字符长度
 */
+(NSUInteger)textLength: (NSString *) text{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
        NSUInteger unicodeLength = asciiLength;
    
    return unicodeLength;
}




/*
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
