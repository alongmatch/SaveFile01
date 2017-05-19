//
//  NewsTableViewController.h
//  NetEaseSH05
//
//  Created by teacher on 17/5/14.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController

/// 接收NewsCell传入的URLString
@property (nonatomic, copy) NSString *URLString;

@end
