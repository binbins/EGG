//
//  BigPicViewController.m
//  EGG
//
//  Created by yuebin on 16/9/7.
//  Copyright © 2016年 yuebin. All rights reserved.
//

#import "BigPicViewController.h"


@interface BigPicViewController () <UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *superScroll;
@property (nonatomic, strong)UIView *topView, *bottomView;

@end

@implementation BigPicViewController {
    BOOL _TabBarHidden;
}
#pragma mark - 懒加载
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSC_W, 64)];
        _topView.backgroundColor = [UIColor blackColor];
        _topView.alpha = .4;
  //返回键
        UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, 22, 40, 40)];
        [back setImage:[UIImage imageNamed:@"wp_nav_back_white"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:back];
        
  //分享键
        UIButton *share = [[UIButton alloc]initWithFrame:CGRectMake(KSC_W-50, 22, 40, 40)];
        [share setImage:[UIImage imageNamed:@"img_detail_share_up@3x"] forState:UIControlStateNormal];
        [share addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:share];
    }
    return _topView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, KSC_H-49, KSC_W, 49)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = .4;
        
        UIButton *look = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, 49, 49)];
//        [look setImage:[UIImage imageNamed:@"img_detail_download@3x"] forState:UIControlStateNormal];
        [look setTitle:@"设置" forState:UIControlStateNormal];
        [look addTarget:self action:@selector(lookAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:look];
        
        
        UIButton *like = [[UIButton alloc]initWithFrame:CGRectMake(KSC_W-100-50, 0, 49, 49)];
//        [like setImage:[UIImage imageNamed:@"img_list_aixin"] forState:UIControlStateNormal];
        [like setTitle:@"喜欢" forState:UIControlStateNormal];

        [like addTarget:self action:@selector(likeAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:like];
    }
    return _bottomView;


}
- (void)lookAction {    //弹出ActionSheet

    int i = self.superScroll.contentOffset.x / KSC_W;
    UIImageView *thisImgView = [self.superScroll viewWithTag:1000 + i];
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"设置为壁纸" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //创建动作
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]; //取消
    UIAlertAction *mainScr = [UIAlertAction actionWithTitle:@"设置主屏幕" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //拿到图片，设置为主屏幕
        
        
    }];
    UIAlertAction *LockedScr = [UIAlertAction actionWithTitle:@"设置锁定屏幕" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //锁定屏幕
//        [thisImgView.image zj_saveAsLockScreen];
    }];
    
    UIAlertAction *bothSet = [UIAlertAction actionWithTitle:@"同时设定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [thisImgView.image zj_saveAsHomeScreenAndLockScreen];
        
    }];
    
    UIAlertAction *saveLocal = [UIAlertAction actionWithTitle:@"保存至照片库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //锁定屏幕
        UIImageWriteToSavedPhotosAlbum(thisImgView.image, nil,nil, NULL);
    }];
    //添加动作
    [sheet addAction:cancle];
    [sheet addAction:mainScr];
    [sheet addAction:LockedScr];
    [sheet addAction:bothSet];
    [sheet addAction:saveLocal];
    
    [self presentViewController:sheet animated:YES completion:nil];
}
- (void)likeAction {

}

- (void)doShare {

}
- (void)dismissSelf {
    //要有过度动画
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
- (UIScrollView *)superScroll {
    if (!_superScroll) {
        _superScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSC_W, KSC_H)];
        _superScroll.contentSize = CGSizeMake(KSC_W *_imgNames.count, KSC_H);
        _superScroll.contentOffset = CGPointMake(KSC_W*_curPage, 0);
        _superScroll.delegate = self;
        _superScroll.pagingEnabled = YES;
        _superScroll.bounces = NO;
        [self creatSubScrollView];
    }
    return _superScroll;

}

- (void)creatSubScrollView {
    
    for (int i = 0; i < _imgNames.count; i++) {
        UIScrollView *subScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(KSC_W *i, 0, KSC_W, KSC_H)];
        subScrView.tag = 2000 + i;
        subScrView.delegate = self;
        //相关设置
        subScrView.contentSize = CGSizeMake(KSC_W, KSC_H);
        subScrView.bounces = NO;
        subScrView.maximumZoomScale = 3;
        subScrView.minimumZoomScale = 1;
        
        //创建图片视图
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSC_W, KSC_H)];
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideTabBar)];
        [imgView addGestureRecognizer:tap];
        imgView.tag = 1000 +i;
        [imgView sd_setImageWithURL:[NSURL URLWithString:_imgNames[i]] placeholderImage:[UIImage imageNamed:@"holder"]];
        
        [subScrView addSubview:imgView];    //添加图片视图
        [_superScroll addSubview:subScrView]; //别忘了子视图也添加上去
        
    }
}

- (void)hideTabBar {
    //隐藏显示
    _TabBarHidden = !_TabBarHidden;
    
    [UIView animateWithDuration:.5 animations:^{
        if (_TabBarHidden) {
            self.topView.alpha = 0;
            self.bottomView.alpha = 0;
        }else {
            self.topView.alpha = .4;
            self.bottomView.alpha = .4;
        }
    }];
   
    
    
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.superScroll];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    
    if (scrollView != self.superScroll) {
        int i = self.superScroll.contentOffset.x / KSC_W;
        
        //只要是父视图就行，也就是说可以越级调用子视图
        return [self.superScroll viewWithTag:1000 + i];
    }
    return nil;
}

//正在缩放时执行
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    if (scrollView != self.superScroll) {
        int i = self.superScroll.contentOffset.x / KSC_W;
        UIScrollView *subView = [self.superScroll viewWithTag:2000 + i];//滑动视图
        UIImageView *imgView = [self.superScroll viewWithTag:1000 + i];//滑动视图的~
        CGFloat subViewHeight = subView.frame.size.height;
        CGFloat subViewWidth = subView.frame.size.width;
        CGFloat imgViewHeight = imgView.frame.size.height;
        CGFloat imgViewWidth = imgView.frame.size.width;
        
        CGFloat topEdge = imgViewHeight < subViewHeight ? (subViewHeight - imgViewHeight)/2 : 0;
        CGFloat leftEdge = imgViewWidth < subViewWidth ? (subViewWidth - imgViewWidth)/2 : 0;
        subView.contentInset = UIEdgeInsetsMake(topEdge, leftEdge, topEdge, leftEdge);
    }
    
}

//还原
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.superScroll]) {    //是大滑动视图视图
        
        for (UIScrollView *view in scrollView.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                
           
                
                view.zoomScale = 1; // 就这一句话
                
            }
        }
        
    }
}

- (void)viewDidAppear:(BOOL)animated {
    

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
