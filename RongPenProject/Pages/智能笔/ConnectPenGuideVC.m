//
//  ConnectPenGuideVC.m
//  RongPenProject
//
//  Created by mac on 7.11.20.
//

#import "ConnectPenGuideVC.h"
#import "PenGuideView.h"
@interface ConnectPenGuideVC ()

@property (nonatomic, strong)PenGuideView   *topView;

@end

@implementation ConnectPenGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toptitle.hidden=NO;
    self.leftImgBtn.hidden=NO;
    self.toptitle.text=@"连接蓝牙笔";
    self.view.backgroundColor = hexColor(F3F5F8);
    
    [self.view addSubview:self.topview];

}


#pragma mark -- lazy

- (PenGuideView *)topView {
    if (!_topView) {
        _topView = [[PenGuideView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, 111)];
        
    }
    return _topView;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
