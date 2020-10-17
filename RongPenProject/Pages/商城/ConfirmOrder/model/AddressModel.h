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
@property(nonatomic,strong)NSString *isdefault;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *marks;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *province_id;
@property(nonatomic,strong)NSString *region_id;

@end

NS_ASSUME_NONNULL_END
