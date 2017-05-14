//
//  UILabel+Addition.h
//  01-生活圈
//
//  Created by teacher on 17/3/19.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)
/// 创建label
/**
 @param color 颜色
 @param size 字体大小
 @param text 文字
 */
+ (instancetype)makeLabelWithTextColor:(UIColor *)color andTextWithFont:(CGFloat)size andText:(NSString *)text;
@end
