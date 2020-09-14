//
//  FrameDefine.h
//  SuiYangPartyBuilding
//
//  Created by LiuZhengli on 14-4-14.
//  Copyright © 2016年 com.henanunicom. All rights reserved.
//

#ifndef MClient_FrameDefine_h
#define MClient_FrameDefine_h

//点
#define ccp(__X__,__Y__)				CGPointMake(__X__,__Y__)
#define ccpZero							CGPointZero
#define ccpMax							ccp(1.0f, 1.0f)
#define ccpHalf(size)					ccp(size.width/2,size.height/2)
#define ccpAdd(p1,p2)                   ccp(p1.x+p2.x,p1.y+p2.y)
#define ccpSub(p1,p2)                   ccp(p1.x-p2.x,p1.y-p2.y)

#define ccpDot(p1,p2)                   p1.x*p2.x+p1.y*p2.y
#define ccpLength(p)                    sqrt(ccpDot(p,p))
#define ccpDistance(p1,p2)              ccpLength(ccpSub(p1,p2))

//矩形
#define ccr(__X__,__Y__,__W__,__H__)	CGRectMake(__X__,__Y__,	__W__,__H__)
#define ccrZero							CGRectZero
#define ccr2(p,s)						ccr(p.x, p.y, s.width, s.height)


//size
#define ccs(__W__,__H__)				CGSizeMake(__W__, __H__)
#define ccsZero							CGSizeZero
#define ccsScale(size,scale)            ccs(size.width*scale,size.height*scale)
#define ccsAdd(s1,s2)                   ccs(s1.width+s2.width,s1.height+s2.height)
#define ccsSub(s1,s2)                   ccs(s1.width-s2.width,s1.height-s2.height)

//screen
#define P_SCREEN                        [[UIScreen mainScreen] bounds]
#define P_WIDTH                         P_SCREEN.size.width            //窗口宽度
#define P_HEIGHT                        P_SCREEN.size.height             //窗口高度
#define P_SIZE                          ccs(P_WIDTH,P_HEIGHT)           //窗口大小
#define P_FRAME                         ccr2(ccpZero,P_SIZE)            //窗口大小
#define P_WIDTH_2                       P_WIDTH/2
#define P_WIDTH_4                       P_WIDTH/4
#define P_WIDTH_6                       P_WIDTH/6
#define P_HEIGHT_2                      P_HEIGHT/2
#define P_HEIGHT_4                      P_HEIGHT/4
#define P_HEIGHT_6                      P_HEIGHT/6

// device
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#endif
#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#endif
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_ZOOMED (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#endif
