//
//  DZTools.m
//  jiyouhui2020
//
//  Created by zanghui  on 2020/7/30.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "DZTools.h"
#import "LoginVC.h"

@implementation DZTools

static UILabel *_msgLabel = nil;

//是否登录
//+ (BOOL)islogin
// {
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *userID = [userDefault objectForKey:UserID];
//    if (userID == nil || [userID isEqualToString:@""])
//    {
//        return NO;
//    }
//     return YES;
//}
//没有登录去登录
+ (BOOL)panduanLoginWithViewContorller:(UIViewController *)viewController isHidden:(BOOL)ishidden
{
    if (![DZTools islogin]) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您还没有登录，请先登录" preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [alertC addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            viewController.hidesBottomBarWhenPushed = YES;
//            LoginViewController *loginVC = [LoginViewController new];
//            [viewController.navigationController pushViewController:loginVC animated:YES];
//            viewController.hidesBottomBarWhenPushed = ishidden;
            LoginVC*vc=[[LoginVC alloc]init];
            vc.hidesBottomBarWhenPushed=YES;
            [viewController presentViewController:vc animated:YES completion:nil];
        }]];
        [[DZTools getAppWindow].rootViewController presentViewController:alertC animated:YES completion:nil];
        return NO;
    }
   return YES;
}
+ (NSString*)removeWhiteSpaceWithString:(NSString *)string
{
    NSString *removeString = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return removeString;
}
//提示窗口
+ (void)MsgBox:(NSString *)msg title:(NSString *)title{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:okAction];
    [[DZTools topViewController] presentViewController:alertController animated:YES completion:nil];
}

+ (void)deleteCookie
{
    if ([[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] count] != 0)
    {
        for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies])
        {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
    else
    {
        return;
    }
    [self deleteCookie];
}



+ (NSString *)getDiskSpaceInfo{
    uint64_t totalSpace = 0.0f;
    uint64_t totalFreeSpace = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
    }else
        return nil;
    
    NSString *infostr = [NSString stringWithFormat:@"%.2f GB 可用/总共 %.2f GB", ((totalFreeSpace/1024.0f)/1024.0f)/1024.0f, ((totalSpace/1024.0f)/1024.0f)/1024.0f];
    return infostr;
}


+ (BOOL)isTelPhoneNub:(NSString *)str
{
    if (str.length < 11)
    {
        [DZTools showNOHud:@"请输入正确的手机号码" delay:1.0];
        
        return NO;
    }
    else
    {
          NSString *regex = @"^((13[0-9])|(14[0-9])|(17[0-9])|(15[^4,\\D])|(18[0-9])|(19[0-9])|(16[0-9])|(17[0-9]))\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:str];
        if (!isMatch) {
            
            [DZTools showNOHud:@"请输入正确的手机号码" delay:1.0];
            
            return NO;
        }
        else
        {
            return YES;
        }
    }
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:email];
}

#pragma mark ---- 正则匹配用户身份证号15或18位
+(BOOL)judgeIdentityStringValid:(NSString *)identityString
{
    //长度不为18的都排除掉
    if (identityString.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:identityString];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}


+ (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (NSString *) getIOSDeviceInfo
{
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSString * info = [NSString stringWithFormat:@"手机别名: %@ 设备名称: %@ 手机型号: %@",userPhoneName,deviceName,phoneModel];
    return info;
}

//获取当前app版本号
+ (NSString *) getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // 当前应用版本号码  int类型
    //    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersion);
    return appCurVersion;
}


+(float)fileSizeForDir:(NSString*)path//计算文件夹下文件的总大小
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float size =0;
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize/ 1024.0/1024.0;
        }
        else
        {
            [self fileSizeForDir:fullPath];
        }
    }
    return size;
}



+ (NSString *)getHMS:(float)second
{
    NSDictionary* dict = [[self class] convertSecond2HourMinuteSecond:second];
    NSString* time = [self getTimeString:dict prefix:@""];
    return time;
}

+ (NSDictionary*)convertSecond2HourMinuteSecond:(int)second
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    int hour = 0, minute = 0;
    
    hour = second / 3600;
    minute = (second - hour * 3600) / 60;
    second = second - hour * 3600 - minute *  60;
    
    [dict setObject:[NSNumber numberWithInt:hour] forKey:@"hour"];
    [dict setObject:[NSNumber numberWithInt:minute] forKey:@"minute"];
    [dict setObject:[NSNumber numberWithInt:second] forKey:@"second"];
    return dict;
}

+ (NSString*)getTimeString:(NSDictionary*)dict prefix:(NSString*)prefix
{
    int hour = [[dict objectForKey:@"hour"] intValue];
    int minute = [[dict objectForKey:@"minute"] intValue];
    int second = [[dict objectForKey:@"second"] intValue];
    
    NSString* formatter = hour < 10 ? @"0%d" : @"%d";
    NSString* strHour = [NSString stringWithFormat:formatter, hour];
    
    formatter = minute < 10 ? @"0%d" : @"%d";
    NSString* strMinute = [NSString stringWithFormat:formatter, minute];
    
    formatter = second < 10 ? @"0%d" : @"%d";
    NSString* strSecond = [NSString stringWithFormat:formatter, second];
    
    return [NSString stringWithFormat:@"%@%@:%@:%@", prefix, strHour, strMinute, strSecond];
}

//判断一下文件里面是否包含视频文件
+(BOOL)isExistFile:(NSString *)fileName
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:fileName];
}



#pragma mark - 获取UIWindow AppDelegate
+ (UIWindow *)getAppWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [DZTools _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [DZTools _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [DZTools _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [DZTools _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

#pragma mark -
#pragma mark 用户信息

//获得当前时间
+(NSString *)getCurrentTime
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSLog(@"locationString:%@",locationString);
    
    return locationString;
}
//获得工作进展标签
+(NSString *)getProcessLabel:(NSString *)aType
{
    NSString  *tempStr;
    if ([aType isEqualToString:@"0"])
    {
        tempStr =  @"进展";
    }
    else if ([aType isEqualToString:@"1"])
    {
        tempStr =  @"计划";
    }
    else if ([aType isEqualToString:@"2"])
    {
        tempStr =  @"问题";
    }
    return tempStr;
    
}

+(float)getLabelHeight:(NSString *)aLabelTitle fontName:(NSString *)aFontName fontSize:(CGFloat)aFontSize widthSize:(CGSize)aSize
{
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:aFontName size:aFontSize],NSParagraphStyleAttributeName:paragraphStyle};
    
    NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
    
    CGSize labelsize = [aLabelTitle boundingRectWithSize:aSize
                                                 options:options
                                              attributes:attributes
                                                 context:nil].size;
    
    return labelsize.height;
}
+(UIView *)getAlineView:(CGRect)frame
{
    UIView *topLineView = [[UIView alloc] initWithFrame:frame];
    topLineView.backgroundColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0];
    return topLineView;
}
+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim
{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    NSString *removeHtmlString = trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
    NSString *removeSpace = [removeHtmlString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    
    return removeSpace;
}
+(NSMutableAttributedString *)labelContent:(NSString *)aStr   space:(int)aSpace
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:aStr];
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:aSpace];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
    
    return str;
}

+(UIImageView *)getALineImageView:(CGRect)frame
{
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:frame];
    lineImage.image = [UIImage imageNamed:@"line.png"];
    return lineImage;
}

#pragma mark - 打开相机或相册
+ (UIImagePickerController *)openPhotoToViewController:(UIViewController *)ViewController sourceType:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.view.backgroundColor = [UIColor whiteColor];
        picker.navigationBarHidden = YES;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [ViewController presentViewController:picker animated:YES completion:^{}];
        
        return picker;
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"该设备不支持!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:okAction];
        [[DZTools topViewController] presentViewController:alertController animated:YES completion:nil];
    }
    return nil;
}
#pragma mark -
#pragma mark 切割图片
+ (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    CGSize newSize;
    if (image.size.height / image.size.width > 1){
        newSize.height = size.height;
        newSize.width = size.height / image.size.height * image.size.width;
    } else if (image.size.height / image.size.width < 1){
        newSize.height = size.width / image.size.width * image.size.height;
        newSize.width = size.width;
    } else {
        newSize = size;
    }
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


#pragma mark -
#pragma mark 获得时间差
+(NSString *)getUTCFormateDate:(NSString *)newsDate
{
    NSLog(@"   %@",newsDate);
    NSString *endString = nil;
    
    if([newsDate rangeOfString:@"-"].location !=NSNotFound)
    {
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *current_date= [dateFormatter1 dateFromString:newsDate];
        //转化date的格式
        endString = [dateFormatter1 stringFromDate:current_date];
    }
    else
    {
        NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
        
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        
        [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
        
        NSDate*inputDate = [inputFormatter dateFromString:newsDate];
        
        NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
        
        [outputFormatter setLocale:[NSLocale currentLocale]];
        
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        
        endString  = [outputFormatter stringFromDate:inputDate];
    }
    NSString *dateContent;
    
    dateContent = [NSString stringWithFormat:@"%@",[endString substringWithRange:NSMakeRange(5, 11)]];
    
    return dateContent;
}


+(NSString*)convertEmojiToTag:(NSString *)text
{
    NSDictionary *emojiDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"expressionImage_custom2" ofType:@"plist"]];
    
    NSArray *values = [emojiDic allValues];
    NSMutableString *pattern = [[NSMutableString alloc] init];
    for (NSString *s in values)
        [pattern appendString:s];
    NSRegularExpression* regex = [NSRegularExpression
                                  regularExpressionWithPattern:[NSString stringWithFormat:@"[%@]",pattern]
                                  options:NSRegularExpressionCaseInsensitive
                                  error:nil];
    NSMutableString* mutableString = [text mutableCopy];
    NSInteger offset = 0; // keeps track of range changes in the string due to replacements.
    for (NSTextCheckingResult* result in [regex matchesInString:text
                                                        options:0
                                                          range:NSMakeRange(0, [text length])])
    {
        
        NSRange resultRange = [result range];
        resultRange.location += offset; // resultRange.location is updated
        // based on the offset updated below
        
        // implement your own replace functionality using
        // replacementStringForResult:inString:offset:template:
        // note that in the template $0 is replaced by the match
        NSString* match = [regex replacementStringForResult:result
                                                   inString:mutableString
                                                     offset:offset
                                                   template:@"$0"];
        NSString* replacement = [emojiDic allKeysForObject:match][0];
        [mutableString replaceCharactersInRange:resultRange withString:replacement];
        
        // update the offset based on the replacement
        offset += ([replacement length] - resultRange.length);
    }
    text = mutableString;
    return text;
}


+ (long long) fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+(UIImage *)imageByFileName:(NSString *)fileName
{
    if ([fileName hasSuffix:@".jpeg"]||[fileName hasSuffix:@"jpg"])
        return [UIImage imageNamed:@"file_jpg.png"];
    if ([fileName hasSuffix:@".png"])
        return [UIImage imageNamed:@"file_png.png"];
    if ([fileName hasSuffix:@".gif"])
        return [UIImage imageNamed:@"file_gif.png"];
    if ([fileName hasSuffix:@".bmp"])
        return [UIImage imageNamed:@"file_bmp.png"];
    if ([fileName hasSuffix:@".doc"])
        return [UIImage imageNamed:@"file_doc.png"];
    if ([fileName hasSuffix:@".xls"])
        return [UIImage imageNamed:@"file_xls.png"];
    if ([fileName hasSuffix:@".ppt"])
        return [UIImage imageNamed:@"file_ppt.png"];
    if ([fileName hasSuffix:@".txt"])
        return [UIImage imageNamed:@"file_txt.png"];
    if ([fileName hasSuffix:@".tif"]||[fileName hasSuffix:@".tiff"])
        return [UIImage imageNamed:@"file_tif.png"];
    if ([fileName hasSuffix:@".pdf"])
        return [UIImage imageNamed:@"file_pdf.png"];
    if ([fileName hasSuffix:@".wav"]||[fileName hasSuffix:@".wave"])
        return [UIImage imageNamed:@"file_wav.png"];
    if ([fileName hasSuffix:@".mp4"]||[fileName hasSuffix:@".mpg4"])
        return [UIImage imageNamed:@"file_mp4.png"];
    if ([fileName hasSuffix:@".mp3"])
        return [UIImage imageNamed:@"file_mp3.png"];
    if ([fileName hasSuffix:@".aiff"]||[fileName hasPrefix:@".aif"]||[fileName hasPrefix:@".aifc"])
        return [UIImage imageNamed:@"file_aiff.png"];
    if ([fileName hasSuffix:@".htm"]||[fileName hasSuffix:@".html"])
        return [UIImage imageNamed:@"file_html.png"];
    if ([fileName hasSuffix:@".xml"])
        return [UIImage imageNamed:@"file_xml.png"];
    if ([fileName hasSuffix:@".rtf"])
        return [UIImage imageNamed:@"file_rtf.png"];
    if ([fileName hasSuffix:@".gz"]||[fileName hasSuffix:@".gzip"])
        return [UIImage imageNamed:@"file_zip.png"];
    if ([fileName hasSuffix:@".tgz"])
        return [UIImage imageNamed:@"file_zip.png"];
    if ([fileName hasSuffix:@".rtfd"])
        return [UIImage imageNamed:@"file_rtfd.png"];
    if ([fileName hasSuffix:@".exe"])
        return [UIImage imageNamed:@"file_exe.png"];
    return [UIImage imageNamed:@"file_unknowtype.png"];
}

+(NSString *)UTIByFileName:(NSString *)fileName
{
    if ([fileName hasSuffix:@".jpeg"]||[fileName hasSuffix:@"jpg"])
        return @"public.jpeg";
    if ([fileName hasSuffix:@".png"])
        return @"public.png";
    if ([fileName hasSuffix:@".gif"])
        return @"com.compuserve.gif";
    if ([fileName hasSuffix:@".bmp"])
        return @"com.microsoft.bmp";
    if ([fileName hasSuffix:@".doc"])
        return @"com.microsoft.word.doc";
    if ([fileName hasSuffix:@".xls"])
        return @"com.microsoft.excel.xls";
    if ([fileName hasSuffix:@".ppt"])
        return @"com.microsoft.powerpoint.​ppt";
    if ([fileName hasSuffix:@".txt"])
        return @"public.plain-text";
    if ([fileName hasSuffix:@".tif"]||[fileName hasSuffix:@".tiff"])
        return @"public.tiff";
    if ([fileName hasSuffix:@".pdf"])
        return @"com.adobe.pdf";
    if ([fileName hasSuffix:@".wav"]||[fileName hasSuffix:@".wave"])
        return @"com.microsoft.waveform-​audio";
    if ([fileName hasSuffix:@".aiff"]||[fileName hasPrefix:@".aif"]||[fileName hasPrefix:@".aifc"])
        return @"public.aifc-audio";
    if ([fileName hasSuffix:@".htm"]||[fileName hasSuffix:@".html"])
        return @"public.html-​audio";
    if ([fileName hasSuffix:@".xml"])
        return @"public.xml";
    if ([fileName hasSuffix:@".rtf"])
        return @"public.rtf";
    if ([fileName hasSuffix:@".gz"]||[fileName hasSuffix:@".gzip"])
        return @"org.gnu.gnu-zip-archive";
    if ([fileName hasSuffix:@".tgz"])
        return @"org.gnu.gnu-zip-tar-archive";
    if ([fileName hasSuffix:@".rtfd"])
        return @"com.apple.rtfd";
    if ([fileName hasSuffix:@".exe"])
        return @"com.microsoft.windows-​executable";
    return @"";
}

+(NSDate *)convertToLocalDateFromStandardDate:(NSDate *)anyDate
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

+(NSString *)simpleTimeFromDateString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    if ([date isEqualToDate:[NSDate date]])
        return [dateString substringWithRange:NSMakeRange(14, 5)];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    
    NSDateComponents *todayComps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    if (comps.day - todayComps.day == -1)
        return @"昨天";
    if (comps.day - todayComps.day < -1  && comps.day - todayComps.day > -5)
        return @"";
    
    //    comps.wee
    return dateString;
}

#pragma mark -
static BOOL isAddHud;

//单例方法
+ (MBProgressHUD *)sharedManager
{
    static dispatch_once_t onceToken ;
    static MBProgressHUD   *hud = nil;
    dispatch_once(&onceToken, ^{
        hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        isAddHud = NO;
    }) ;
    return hud;
}


+ (void)removeHudWindow
{
    [[DZTools sharedManager] removeFromSuperview];
    isAddHud = NO;
}

+ (void)addHudWindow:(MBProgressHUD *)hudMsg
{
    if (isAddHud == NO)
    {
        [[UIApplication sharedApplication].keyWindow addSubview:hudMsg];
        isAddHud = YES;
    }
}
+ (void)showTextHud:(NSString *)text
{
    MBProgressHUD *hudMsg = [DZTools sharedManager];
    [self addHudWindow:hudMsg];
    [hudMsg.customView removeFromSuperview];
    hudMsg.customView = nil;
    hudMsg.mode = MBProgressHUDModeIndeterminate;
    hudMsg.detailsLabel.text = text;
    hudMsg.detailsLabel.font = [UIFont boldSystemFontOfSize:17];
    [hudMsg showAnimated:YES];
}
+ (void)showHud
{
    MBProgressHUD *hudMsg = [DZTools sharedManager];
    [self addHudWindow:hudMsg];
    [hudMsg.customView removeFromSuperview];
    hudMsg.customView = nil;
    hudMsg.detailsLabel.text = nil;
    hudMsg.mode = MBProgressHUDModeIndeterminate;
    [hudMsg showAnimated:YES];
}
+ (void)showText:(NSString *)text{
    MBProgressHUD *hudMsg = [DZTools sharedManager];
    [self addHudWindow:hudMsg];
    [hudMsg.customView removeFromSuperview];
    hudMsg.customView = nil;
    hudMsg.mode = MBProgressHUDModeText;
    hudMsg.detailsLabel.text = text;
    hudMsg.detailsLabel.font = [UIFont boldSystemFontOfSize:17];
    [hudMsg showAnimated:YES];
}


+ (void)showHudDelay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [DZTools sharedManager];
    [self addHudWindow:hudMsg];
    [hudMsg.customView removeFromSuperview];
    hudMsg.customView = nil;
    hudMsg.mode = MBProgressHUDModeIndeterminate;
    hudMsg.detailsLabel.text = nil;
    [hudMsg showAnimated:YES];
    [hudMsg hideAnimated:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}

+ (void)showText:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [DZTools sharedManager];
    [self addHudWindow:hudMsg];
    [hudMsg.customView removeFromSuperview];
    hudMsg.customView = nil;
    hudMsg.mode = MBProgressHUDModeText;
    hudMsg.detailsLabel.text = text;
    hudMsg.detailsLabel.font = [UIFont boldSystemFontOfSize:17];
    [hudMsg showAnimated:YES];
    [hudMsg hideAnimated:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}

+ (void)showTextHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [DZTools sharedManager];
    [self addHudWindow:hudMsg];
    [hudMsg.customView removeFromSuperview];
    hudMsg.customView = nil;
    hudMsg.mode = MBProgressHUDModeIndeterminate;
    hudMsg.detailsLabel.text = text;
    hudMsg.detailsLabel.font = [UIFont boldSystemFontOfSize:17];
    [hudMsg showAnimated:YES];
    [hudMsg hideAnimated:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}

+ (void)showOKHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [DZTools sharedManager];
    [self addHudWindow:hudMsg];
    hudMsg.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success-color"]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.detailsLabel.text = text;
    hudMsg.detailsLabel.font = [UIFont boldSystemFontOfSize:17];
    [hudMsg showAnimated:YES];
    [hudMsg hideAnimated:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}
+ (void)showNOHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [DZTools sharedManager];
    [self addHudWindow:hudMsg];
    hudMsg.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error-color"]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.detailsLabel.text = text;
    hudMsg.detailsLabel.font = [UIFont boldSystemFontOfSize:17];
    [hudMsg showAnimated:YES];
    [hudMsg hideAnimated:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}
+ (void)showqidaiHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [DZTools sharedManager];
    [self addHudWindow:hudMsg];
    hudMsg.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.detailsLabel.text = text;
    hudMsg.detailsLabel.font = [UIFont boldSystemFontOfSize:17];
    [hudMsg showAnimated:YES];
    [hudMsg hideAnimated:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}

+ (void)showAnimated:(NSString *)imageName delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [DZTools sharedManager];
    [self addHudWindow:hudMsg];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.frame = hudMsg.frame;
    hudMsg.customView = imageView;
    hudMsg.customView.layer.cornerRadius = 55.f;
    hudMsg.customView.layer.masksToBounds = YES;
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.detailsLabel.text = @"正在加载...";
    hudMsg.detailsLabel.font = [UIFont boldSystemFontOfSize:17];
    hudMsg.detailsLabel.textColor = [UIColor whiteColor];
    hudMsg.customView.backgroundColor = [UIColor colorWithRed:1.0 green:134/255.0 blue:92/255.0 alpha:1.0];
    [hudMsg showAnimated:YES];
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withAnimatedImage:(NSString *)imageName
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.frame = hud.frame;
    hud.customView = imageView;
    hud.customView.layer.cornerRadius = 55.f;
    hud.customView.layer.masksToBounds = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabel.text = @"正在加载...";
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:17];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.customView.backgroundColor = [UIColor colorWithRed:1.0 green:134/255.0 blue:92/255.0 alpha:1.0];
    [hud showAnimated:YES];
    return hud;
}

+ (void)hideHud
{
    [[DZTools sharedManager] hideAnimated:YES];
    [self removeHudWindow];
}
#pragma mark -
#pragma mark 时间格式
/*
 1.今天－－>今天 xx:xx(今天 15:39)
 
 2.昨天－－>昨天 xx:xx(昨天 06:00)
 
 3.前天－－>前天 xx:xx(前天 19:00)
 
 4.同一年, 例如:同一年的一月三号－－>01-03 xx:xx(14-01-03 12:29)
 
 5.不在同一年 －－> xxxx-xx-xx(14-12-12)
 */
+ (NSString *)timeFormat:(NSString *)string{
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate*inputDate = [inputFormatter dateFromString:string];
    //NSLog(@"startDate= %@", inputDate);
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yy-MM-dd HH:mm"];
    //get date str
    NSString *str= [outputFormatter stringFromDate:inputDate];
    //str to nsdate
    NSDate *strDate = [outputFormatter dateFromString:str];
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: strDate];
    NSDate *endDate = [strDate  dateByAddingTimeInterval: interval];
    //NSLog(@"endDate:%@",endDate);
    NSString *lastTime = [self compareDate:endDate];
    return lastTime;
}

+ (NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //修正8小时之差
    NSDate *date1 = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date1];
    NSDate *localeDate = [date1  dateByAddingTimeInterval: interval];
    
    //NSLog(@"nowdate=%@\nolddate = %@",localeDate,date);
    NSDate *today = localeDate;
    NSDate *yesterday,*beforeOfYesterday;
    
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday = [yesterday dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *beforeOfYesterdayString = [[beforeOfYesterday description] substringToIndex:10];
    
    NSString *dateString = [[date description] substringToIndex:10];
    
    NSString *dateContent;
    //今 昨 前天的时间
    NSString *time = [[date description] substringWithRange:(NSRange){11,5}];
    //其他时间
    NSString *time2 = [[date description] substringWithRange:(NSRange){2,14}];
    if ([dateString isEqualToString:todayString]){
        dateContent = [NSString stringWithFormat:@"今天 %@",time];
        return dateContent;
    } else if ([dateString isEqualToString:yesterdayString]){
        dateContent = [NSString stringWithFormat:@"昨天 %@",time];
        return dateContent;
    }else if ([dateString isEqualToString:beforeOfYesterdayString]){
        dateContent = [NSString stringWithFormat:@"前天 %@",time];
        return dateContent;
    }else{
        return time2;
    }
    
}



// 字符串自适应高度
/**
 *  获取字符串CGSize可以设置最大宽高
 *
 *  @return 返回CGSize
 */
+ (CGSize)getStringCGSizeWithString:(NSString *)string Font:(UIFont*)font MaxWidth:(float)width MaxHeight:(float)height{
    //设置字体
    CGSize size = CGSizeMake(width, height);//注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
#if defined SystemVersion_7x
    size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
#else
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    size =[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
#endif
    return size;
}

+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)ViewController
{
    return (ViewController.isViewLoaded && ViewController.view.window);
}

//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    return NO;
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}



/**
 计算结算时间
 
 @param date 开始时间
 */
+ (void)calculateEndTime:(NSDate*)date{
    NSDate *startD = date;
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = start + 119;
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:end];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *currentDateStr = [format stringFromDate:endDate];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:currentDateStr forKey:@"ENDTIME"];
    [userInfo synchronize];
    
}
/**
 初始化结束时间
 */
+ (void)deleteEndTime{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:nil forKey:@"ENDTIME"];
    [userInfo synchronize];
}

//获取结束时间
+ (NSDate*)getEndTime
{
    NSString *timeString = [[NSUserDefaults standardUserDefaults] objectForKey:@"ENDTIME"];
    if (timeString == nil || [timeString isEqualToString:@""]) {
        return [NSDate date];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:timeString];
    return destDate;
}

/**
 * 开始到结束的时间差
 */
+ (NSInteger)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    if (start >= end) {
        return 0;
    }
    NSTimeInterval value = end - start;
    int second = value;//秒
    return second;
}

+ (NSInteger)getSecond{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *currentDateStr = [format stringFromDate:[NSDate date]];
    NSString *endTimeString = [[NSUserDefaults standardUserDefaults] objectForKey:@"ENDTIME"];
    return [self dateTimeDifferenceWithStartTime:currentDateStr endTime:endTimeString];
}


+ (NSData *)toJSONData:(id)theData{
    /*
     NSError *error = nil;
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
     options:NSJSONWritingPrettyPrinted
     error:&error];
     
     if ([jsonData length] > 0 && error == nil){
     return jsonData;
     }else{
     return nil;
     }
     */
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:theData
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (NSString *) compareCurrentTime:(NSString *)str
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    //NSDate *nowDate = [NSDate date];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];// + 8*60*60;//[timeDate ] ;
    timeInterval =  -timeInterval;
    //标准时间和北京时间差8个小时
    //timeInterval = timeInterval - 8*60*60;
    NSString *result = str;
    
    if (timeInterval <= 120) {
        result = @"刚刚";
    } else if(timeInterval <= 60*60){
        result = [NSString stringWithFormat:@"%.f分钟前",timeInterval/60];
    } else if(timeInterval <= 60*60*24){
        result = [NSString stringWithFormat:@"%.f小时前",timeInterval/3600];
    } else if (timeInterval <= 60*60*24*3){
        result = [NSString stringWithFormat:@"%d天前",
                  (int)timeInterval/(60*60*24)];
    }else{
        result = [result substringToIndex:16];
    }
    /*
     else if((temp = temp/30) <12){
     result = [NSString stringWithFormat:@"%ld月前",temp];
     }
     else{
     temp = temp/12;
     result = [NSString stringWithFormat:@"%ld年前",temp];
     }
     */
    return  result;
}
+ (id)toArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

+ (CGSize)sizeForString:(NSString *)string withSize:(CGSize)fitsize withFontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:fitsize/*计算高度要先指定宽度*/ options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size;
}

+ (NSString *)chackUrl:(NSString *)string
{
    if ([string containsString:@"http://"] || [string containsString:@"https://"])
    {
        return string;
    }else
    {
        string = [kDomainUrl stringByAppendingString:string];
        return string;
    }
}
+ (void)jiexierrrorwitherror:(NSError *)error{
//    NSDictionary *response;
//    @try {
//        response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
//    } @catch (NSException *exception) {
//        return;
//    } @finally {
//        // 错误码
//        if ([response[@"code"] intValue] == TokenError) {
//            [User deleUser];
//            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"登录已失效，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
//            [alertC addAction:[UIAlertAction actionWithTitle:@"去登录"
//                                                       style:UIAlertActionStyleDefault
//                                                     handler:^(UIAlertAction *_Nonnull action) {
//                 LoginViewController *loginVC = [LoginViewController new];
//                 loginVC.hidesBottomBarWhenPushed = YES;
//                 [[DZTools topViewController].navigationController pushViewController:loginVC animated:YES];
//             }]];
//            [[DZTools getAppWindow].rootViewController presentViewController:alertC animated:YES completion:nil];
//            return;
//        }
//    }
}
@end

