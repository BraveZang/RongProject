//
//  ReadInfoFooterView.m
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import "ReadInfoFooterView.h"
#import "MapModel.h"
@interface ReadInfoFooterView ()

@property (nonatomic, strong) UIScrollView  *scrollView;

@end

@implementation ReadInfoFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatReadInfoFooterView];
    }
    return self;
}

- (void)creatReadInfoFooterView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, APP_HEIGHT_6S(56.0))];
//    self.scrollView.delegate = self;
    [self addSubview:_scrollView];
}

- (void)setInfoModel:(ReadInfoModel *)infoModel{
    self.scrollView.contentSize = CGSizeMake(APP_WIDTH_6S(30.0)*infoModel.list.count, APP_HEIGHT_6S(56.0));
    
    for (NSInteger i = 0; i < infoModel.list.count; i++) {
        MapModel  *model = infoModel.list[i];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH_6S(30.0)*i + APP_WIDTH_6S(5.0), APP_HEIGHT_6S(5.0), APP_WIDTH_6S(25.0), APP_HEIGHT_6S(36.0))];
        imageView.tag = 100+i;
        imageView.userInteractionEnabled = YES;
//        imageView.backgroundColor = [UIColor redColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.ditu]];
        
        [self.scrollView addSubview:imageView];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = imageView.frame;
        [self.scrollView addSubview:btn];

    }
}

- (void)imageClick:(UIButton *)sender{
    
    if (self.seletedUnitblock) {
        self.seletedUnitblock(sender.tag - 200);
    }
}


- (void)setBookModel:(MainBookModel *)bookModel{
    
    
    
    

}

@end
