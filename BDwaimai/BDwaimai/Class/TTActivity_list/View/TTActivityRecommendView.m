//
//  TTActivityRecommendView.m
//  baiduTakeawary
//
//  Created by sumshile on 2017/5/10.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "TTActivityRecommendView.h"
#import "Activity_listModel.h"
#import "UIColor+Addition.h"
@interface TTActivityRecommendView ()
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet UILabel *centenLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;


@end
@implementation TTActivityRecommendView

+(instancetype)activityRecommendView
{
    return [[UINib nibWithNibName:@"TTActivityRecommendView" bundle:nil]instantiateWithOwner:nil options:nil].lastObject;
}
-(void)setListModel:(Activity_listModel *)listModel
{
    
    self.backgroundColor=[UIColor whiteColor];
    
    _listModel=listModel;
    _headLabel.text=listModel.title;
    _centenLabel.text=listModel.desc;
    
    for (int i=0; i<listModel.img_url.length; i++)
    {
        NSString* ch=[listModel.img_url substringWithRange:NSMakeRange(i, 1)];
        if ([ch isEqualToString:@"@"]) {
            NSString* urlS=[listModel.img_url substringToIndex:i];
            
            [_mainImageView sd_setImageWithURL:[NSURL URLWithString:urlS]];
             break;
        }
    }
    [_headLabel setTintColor:[UIColor colorWithHex:(uint32_t)strtoull([[NSString stringWithFormat:@"0%@",[listModel.title_color substringFromIndex:1]]UTF8String], 0, 0)]];
    [_centenLabel setTintColor:[UIColor colorWithHex:(uint32_t)strtoull([[NSString stringWithFormat:@"0%@",[listModel.desc_color substringFromIndex:1]]UTF8String], 0, 0)]];
    [self setBackgroundColor:[UIColor colorWithHex:(uint32_t)strtoull([[NSString stringWithFormat:@"0%@",[listModel.background_color substringFromIndex:1]]UTF8String], 0, 0)]];
}

@end
