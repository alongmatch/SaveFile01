//
//  TTActivity_listCell.m
//  baiduTakeawary
//
//  Created by sumshile on 2017/5/11.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "TTActivity_listCell.h"
#import "TTActivity_listView.h"
@interface TTActivity_listCell ()
@property (weak, nonatomic) IBOutlet TTActivity_listView *activityListView;


@end
@implementation TTActivity_listCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setListModelArray:(NSMutableArray<Activity_listModel *> *)listModelArray
{
    _listModelArray=listModelArray;
    
    _activityListView.listModelArray=listModelArray;
}

@end
