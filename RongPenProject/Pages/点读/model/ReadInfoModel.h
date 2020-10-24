//
//  ReadInfoModel.h
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReadInfoModel : NSObject


@property (nonatomic, strong) NSString      *bookid;
@property (nonatomic, strong) NSString      *unitid;
@property (nonatomic, strong) NSString      *width;
@property (nonatomic, strong) NSString      *heigth;
@property (nonatomic, strong) NSArray       *list;

@end

NS_ASSUME_NONNULL_END
