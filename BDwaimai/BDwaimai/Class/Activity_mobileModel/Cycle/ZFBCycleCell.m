//
//  ZFBCycleCell.m
//  01-图片轮播器
//
//  Created by teacher on 17/3/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "ZFBCycleCell.h"
#import "Activity_mobileModel.h"
@interface ZFBCycleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@end
@implementation ZFBCycleCell


-(void)setModel:(Activity_mobileModel *)model
{
    _model=model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
}


@end
