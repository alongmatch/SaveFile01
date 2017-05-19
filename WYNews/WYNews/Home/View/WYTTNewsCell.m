//
//  WYTTNewsCell.m
//  WYNews
//
//  Created by sumshile on 2017/5/14.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "WYTTNewsCell.h"
#import "NewsTableViewController.h"

@interface WYTTNewsCell ()
@property (strong, nonatomic)NewsTableViewController* newsVC;

@end
@implementation WYTTNewsCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    _newsVC=[[NewsTableViewController alloc]init];
    [self.contentView addSubview:_newsVC.view];
    _newsVC.tableView.frame = self.contentView.bounds;
    
    _newsVC.tableView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
}

/// 表示一种事件的发生 : 拿到新闻的地址事件
- (void)setURLString:(NSString *)URLString {
    _URLString = URLString;
    
    _newsVC.URLString = URLString;
}

@end
