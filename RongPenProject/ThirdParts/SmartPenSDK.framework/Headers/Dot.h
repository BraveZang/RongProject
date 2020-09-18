//
//  Dot.h
//  TQLSmartPen
//
//  Created by tql on 2017/10/20.
//  Copyright © 2017年 tqlZj. All rights reserved.
//

#import <Foundation/Foundation.h>
/**点的类型,第一个force大于零为down,force等于零为up*/
typedef NS_ENUM(NSInteger, DotType) {
    PEN_DOWN,
    PEN_MOVE,
    PEN_UP,
};

@interface Dot : NSObject

@property (nonatomic, assign) int SectionID;/**区域id*/
@property (nonatomic, assign) int OwnerID;/**用户id*/
@property (nonatomic, assign) int BookID;/**书本id*/
@property (nonatomic, assign) int PageID;/**页id*/
@property (nonatomic, assign) int counter;/**点计数器 0-255*/
@property (nonatomic, assign) int force;/**笔的压力*/
@property (nonatomic, assign) int angle;/**笔的角度*/
@property (nonatomic, assign) int x;/**x坐标整数部分*/
@property (nonatomic, assign) int fx;/**x坐标小数部分*/
@property (nonatomic, assign) int y;/**y坐标整数部分*/
@property (nonatomic, assign) int fy;/**y坐标小数部分*/
@property (nonatomic, assign) long timelong;
@property (nonatomic, assign) DotType type;/**定义点的类型,力为0则是提起状态*/

@property (nonatomic, assign) float ab_x;
@property (nonatomic, assign) float ab_y;
@property (nonatomic, assign) BOOL isRight;

/** get DOT string Value */
- (NSString *)toString;
/** get real coordinate (add x and fx) And mul 15*/
- (float)toAbsoluteX:(int)ax fx:(int)afx;

@end
