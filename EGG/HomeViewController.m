//
//  HomeViewController.m
//  EGG
//
//  Created by yuebin on 16/9/7.
//  Copyright © 2016年 yuebin. All rights reserved.
//

#import "HomeViewController.h"
#import "CollectionViewCell.h"
#import "XRCarouselView.h"
#import "BigPicViewController.h"

@interface HomeViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, XRCarouselViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *images;
@property (nonatomic, strong)XRCarouselView *headView;
@end

@implementation HomeViewController


#pragma mark - 懒加载
- (NSArray *)images {

    if (!_images) {
        _images = @[@"http://a.hiphotos.baidu.com/zhidao/pic/item/ac345982b2b7d0a264383541cfef76094a369a7c.jpg", @"http://b.zol-img.com.cn/sjbizhi/images/4/320x510/1366279760542.jpg", @"http://upload.besoo.com/file/201608/21/2012055945908.jpeg", @"http://img1.gamedog.cn/2013/07/11/44-130G10Z4320-50.jpg", @"http://image.tianjimedia.com/uploadImages/2012/268/F9510I3WPPOW.jpg", @"http://img1.windmsn.com/b/2/266/26612/2661262.jpg", @"http://cdn.duitang.com/uploads/item/201508/14/20150814074658_xRSe5.thumb.700_0.jpeg", @"http://img5.duitang.com/uploads/item/201509/05/20150905212128_mJuZL.jpeg", @"http://images.ali213.net/picfile/pic/2015/06/03/927_2015060334506595.jpg", @"http://images.ali213.net/picfile/pic/2015/08/04/927_2015080491456480.jpg", @"http://www.sx198.com/p/360/image/201504/14302863921879236547.jpg", @"http://ww2.sinaimg.cn/large/e535f038jw1eqet2ono1oj20tn18g0zo.jpg", @"http://s13.sinaimg.cn/mw690/0062Eartgy6Tl8HcdhG8c&690",  @"http://bizhi.33lc.com/uploadfile/2015/0323/20150323011034843.jpg", @"http://img5.duitang.com/uploads/item/201403/16/20140316195055_M2GT4.thumb.700_0.png", @"http://img.taopic.com/uploads/allimg/121005/219049-1210051U20046.jpg" ];
    }
    return _images;
}
- (UIView *)headView {
    if (!_headView) {
        NSArray *arr2 = @[@"http://hiphotos.baidu.com/praisejesus/pic/item/e8df7df89fac869eb68f316d.jpg", @"http://pic39.nipic.com/20140226/18071023_162553457000_2.jpg", @"http://file27.mafengwo.net/M00/B2/12/wKgB6lO0ahWAMhL8AAV1yBFJDJw20.jpeg"];
        NSArray *describeArray = @[@"蛋蛋新人", @"收藏最多", @"猜你喜欢"];
        _headView = [[XRCarouselView alloc]initWithImageArray:arr2 describeArray:describeArray];
        _headView.frame = CGRectMake(0, 0, KSC_W, 150);
        _headView.delegate = self;
        _headView.time = 2;
        
    }
    return _headView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, KSC_W, KSC_H-64-49) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        //注册单元格和头视图
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    [self.view addSubview:self.collectionView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegateFlowLayout
//flow里设置item大小，间隔
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.images.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake( (KSC_W-4)/3, KSC_H/3);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeMake(KSC_W, 155);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 10, 0);
}   //整体的上左下右

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;   //item间隔
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;   //行间隔
}

#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    //注册过了不用再创建
    //只有一个数据，不在使用model
    NSURL *imgURL = [NSURL URLWithString:self.images[indexPath.item]];
    [cell.pic sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"holder"]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
    
    [head addSubview:self.headView];
    
    return head;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
    UIWindow *mainWindow = [[UIApplication sharedApplication].delegate window];
    UICollectionViewCell *item = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = [item convertRect:CGRectMake(0, 0, item.frame.size.width, item.frame.size.height) toView:mainWindow];
    UIImageView *bridge = [[UIImageView alloc]initWithFrame:frame];
    [bridge sd_setImageWithURL:[NSURL URLWithString:self.images[indexPath.item]] placeholderImage:[UIImage imageNamed:@"holder"]];
    [mainWindow addSubview:bridge];
    
    //推出滑动视图，之前添加视觉效果
    BigPicViewController *vc = [[BigPicViewController alloc]init];
    vc.imgNames = self.images;  //还要添加一个属性，记录当前序数
    vc.curPage = indexPath.item;
    
    
    [UIView animateWithDuration:.3 animations:^{

        bridge.frame = [UIScreen mainScreen].bounds;
        
    } completion:^(BOOL finished) {
        
        [self presentViewController:vc animated:YES completion:^{
        
            [bridge removeFromSuperview];
        }];
        
    }];
    
    
}

#pragma mark - 轮播delegate
- (void)carouselView:(XRCarouselView *)carouselView didClickImage:(NSInteger)index {
 
    NSLog(@"点击%u",index);
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
