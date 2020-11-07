//
//  AnswerModel.h
//  RongPenProject
//
//  Created by mac on 4.11.20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnswerModel : NSObject

@property (nonatomic, strong) NSString      *answer;
@property (nonatomic, strong) NSString      *bookid;
@property (nonatomic, strong) NSString      *en;
@property (nonatomic, strong) NSString      *gqid;
@property (nonatomic, strong) NSString      *Id;
@property (nonatomic, strong) NSString      *unitid;
@property (nonatomic, strong) NSString      *zh;
@property (nonatomic, assign) BOOL          hsaRead;




@end

NS_ASSUME_NONNULL_END
