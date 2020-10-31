//
//  AddressModel.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *address;



//是否默认:0=非默认,1=默认地址
@property(nonatomic,strong)NSString *moren;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *shi;
@property(nonatomic,strong)NSString *sheng;
@property(nonatomic,strong)NSString *qu;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *sheng1;
@property(nonatomic,strong)NSString *shi1;
@property(nonatomic,strong)NSString *qu1;




@end

NS_ASSUME_NONNULL_END
