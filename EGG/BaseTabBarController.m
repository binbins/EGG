//
//  BaseTabBarController.m
//  MTime
//
//  Created by 孙 峰 on 15/9/14.
//  Copyright (c) 2015年 SunFeng. All rights reserved.
//

#import "BaseTabBarController.h"

#define kScreen_W    [UIScreen mainScreen].bounds.size.width
#define kScreen_H    [UIScreen mainScreen].bounds.size.height

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, 49)];
    [_contentView setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar addSubview:_contentView];

    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //删除按钮
    [self removeTabbarItem];
}

- (void)removeTabbarItem{
    
    //遍历标签栏的子视图，删除按钮
    for (UIView *v in self.tabBar.subviews) {
        
        //从字符串中提取类
        if ([v isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //从父视图中移除
            [v removeFromSuperview];
        }
    }
    
}

- (void)setViewControllers:(NSArray *)viewControllers{
    
    [super setViewControllers:viewControllers];
    
    //创建按钮
    [self createBtns];
}

- (void)createBtns{

    for (int i = 0; i < self.viewControllers.count; i++) {
        
        //创建按钮
        CGRect frame = CGRectMake(kScreen_W/self.viewControllers.count * i, 0, kScreen_W/self.viewControllers.count, 49);
        
        //初始化btn
        SFTabBarItem *item = [[SFTabBarItem alloc] initWithFrame:frame tabbarItem:[[self.viewControllers objectAtIndex:i] tabBarItem]];
        
        //添加选中图片，默认第一个
        if (i == 0) {
            
            _selectImage = [[UIImageView alloc] initWithFrame:item.frame];
            
            _selectImage.image = [UIImage imageNamed:@"home_bottom_tab_arrow"];
            _selectImage.contentMode = UIViewContentModeScaleAspectFit;
            
            [_contentView addSubview:_selectImage];
            
        }
        
        //添加
        [_contentView addSubview:item];
        
        item.tag = 100 + i;
        
        //添加点击方法
        [item addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}

- (void)btnAct:(SFTabBarItem *)item{
    //实现视图控制器的切换
    self.selectedIndex = item.tag - 100;
    
    //改变选中视图的frame
    [UIView animateWithDuration:0.3 animations:^{
        _selectImage.frame = item.frame;
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

@implementation SFTabBarItem


//这个做得不好，应该考虑没有字的情况，让图标居中 已经改正
-(instancetype)initWithFrame:(CGRect)frame tabbarItem:(UITabBarItem *)item{
    
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-15)];
        

        if (!item.title ) {
            _imageView.frame = CGRectMake(self.frame.size.width/8, self.frame.size.height/8, 3*self.frame.size.width/4, 3*self.frame.size.height/4);
        }
        _imageView.image = item.image;
        //布局方式
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-15, self.frame.size.width, 15)];
        
        _label.text = item.title;
        _label.textColor = [UIColor whiteColor];
        //对其方式
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:12];
        
        
        [self addSubview:_label];
        
    }
    
    return self;
    
}

@end
