//
//  NSString+URL.m
//  jiyouhui2020
//
//  Created by zanghui  on 2020/8/4.
//  Copyright © 2020 Lmjx. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

//URLEncode
-(NSString*)encodeString:(NSString*)unencodedString{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                    (CFStringRef)unencodedString,
                     NULL,
                     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                     kCFStringEncodingUTF8));
    
    return encodedString;
}


//URLDEcode
-(NSString *)decodeString:(NSString*)encodedString
{
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                              (__bridge CFStringRef)encodedString,CFSTR(""),
                               CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

@end
