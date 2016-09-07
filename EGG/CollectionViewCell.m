//
//  CollectionViewCell.m
//  EGG
//
//  Created by yuebin on 16/9/7.
//  Copyright © 2016年 yuebin. All rights reserved.
//

#import "CollectionViewCell.h"


@implementation CollectionViewCell

//+ (Class)class {
//
//    if ([super class]) {
//        
//        
//    }
//    return [super class];
//}

- (UIImageView *)pic {
    if (!_pic) {
        _pic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_pic];
    }
    return _pic;
}
@end
