//
//  NSString+URL.h
//  jiyouhui2020
//
//  Created by zanghui  on 2020/8/4.
//  Copyright © 2020 Lmjx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (URL)
-(NSString*)encodeString:(NSString*)unencodedString;
-(NSString *)decodeString:(NSString*)encodedString;
@end

NS_ASSUME_NONNULL_END
