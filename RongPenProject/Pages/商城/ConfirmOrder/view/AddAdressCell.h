//
//  AddAdressCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/17.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddAdressCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic)  UILabel              *titleLab;
@property (strong, nonatomic)  UITextField          *phoneTF;
@property (strong, nonatomic)  UITextView           *addressTV;
@property (strong, nonatomic)  UIButton             *adressbtn;
@property (strong, nonatomic)  NSMutableArray       *btnAry;
@property (strong, nonatomic)  UISwitch             *swi;
@property (strong, nonatomic)  AddressModel         *model;

@property (copy, nonatomic) void(^textfieldStrBlock)(NSString*str);//是否设置默认地址



@end

NS_ASSUME_NONNULL_END
