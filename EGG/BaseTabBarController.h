//
//  BaseTabBarController.h
//  MTime
//
//  Created by 孙 峰 on 15/9/14.
//  Copyright (c) 2015年 SunFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController
{
    
    UIView *_contentView;//标签栏
    
    UIImageView *_selectImage;//选中
    
    
    
}


@end


@interface SFTabBarItem : UIControl{
    
    //图片
    
    UIImageView *_imageView;
    
    //Label
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame tabbarItem:(UITabBarItem *)item;

@end

