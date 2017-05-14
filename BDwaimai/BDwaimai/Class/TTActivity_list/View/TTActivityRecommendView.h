//
//  TTActivityRecommendView.h
//  baiduTakeawary
//
//  Created by sumshile on 2017/5/10.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Activity_listModel;
@interface TTActivityRecommendView : UIView

@property(nonatomic,strong)Activity_listModel* listModel;
+(instancetype)activityRecommendView;

@end
