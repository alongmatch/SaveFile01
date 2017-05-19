//
//  WYTopLabel.m
//  WYNews
//
//  Created by sumshile on 2017/5/14.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "WYTopLabel.h"

@implementation WYTopLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:16.0];
        
    }
    return self;
}
- (void)setScale:(CGFloat)scale {
    
    // 范围 : 0.0 ~ 1.0
    _scale = scale;
    
    // 1.颜色由黑变红
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    
    // 2.文字缩放
    // CGAffineTransformMakeScale(CGFloat sx, CGFloat sy) : sx 和 sy 的最小值必须比1.0大,才能保证在原有基础上比现在大
    // 如果 sx 和 sy 是0 表示缩放到没有; 如果 sx 和 sy 是1.0 表示不做缩放,保持原有大小
    self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    // 需求 : 保证在1.0 ~ 1.2之间缩放 (外界直接传入的 0.0 ~ 1.0范围的scale无法直接使用)
    //    scale = 1.0 + scale * 0.2;
    
    CGFloat minScale = 1.0;
    CGFloat maxScale = 1.2;
    
    scale = minScale + (maxScale - minScale) * scale;
    
    self.transform = CGAffineTransformMakeScale(scale, scale);
}
@end
