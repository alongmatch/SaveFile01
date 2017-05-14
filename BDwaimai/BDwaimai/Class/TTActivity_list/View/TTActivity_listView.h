//
//  TTActivity_listView.h
//  baiduTakeawary
//
//  Created by sumshile on 2017/5/10.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Activity_listModel;
@interface TTActivity_listView :UIView

@property(nonatomic,strong)NSMutableArray<Activity_listModel*>* listModelArray;

@end
