//
//  UILabel+Addition.m
//  01-生活圈
//
//  Created by teacher on 17/3/19.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)
+ (instancetype)makeLabelWithTextColor:(UIColor *)color andTextWithFont:(CGFloat)size andText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    
    return label;
}
@end
