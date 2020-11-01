//
//  TuiKuanView.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/1.
//

#import <UIKit/UIKit.h>
#import "HDragItemListView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuiKuanView : DZBaseViewController<UITextViewDelegate>

@property(nonatomic,strong)UIView             *bgView;
@property(nonatomic,strong)UITextView         *textView;
@property(nonatomic,strong)UILabel            *titleLab;
@property(nonatomic,strong)UIButton           *quxiaoBtn;
@property(nonatomic,strong)UIButton           *qudingBtn;
@property(nonatomic,strong)HDragItemListView  *itemList;
@property(nonatomic,strong)HDragItem          *item;
@property(nonatomic,strong)NSString           *orderidStr;




@end

NS_ASSUME_NONNULL_END
