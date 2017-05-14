//
//  TTCycleMobileCell.m
//  BDwaimai
//
//  Created by sumshile on 2017/5/11.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "TTCycleMobileCell.h"
#import "ZFBCycleView.h"
#import "Activity_mobileModel.h"
@interface TTCycleMobileCell ()
@property (weak, nonatomic) IBOutlet ZFBCycleView *cycleView;


@end
@implementation TTCycleMobileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setMobileArray:(NSMutableArray<Activity_mobileModel *> *)mobileArray
{
    _mobileArray=mobileArray;
    self.cycleView.imageNames=mobileArray.copy;
}

@end
