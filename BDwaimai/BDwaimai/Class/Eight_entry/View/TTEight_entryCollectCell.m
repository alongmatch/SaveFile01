//
//  TTEight_entryCollectCell.m
//  BDwaimai
//
//  Created by sumshile on 2017/5/11.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "TTEight_entryCollectCell.h"
#import "Eight_entryModel.h"
@interface TTEight_entryCollectCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation TTEight_entryCollectCell

-(void)setEntryModel:(Eight_entryModel *)entryModel
{
    self.backgroundColor=[UIColor whiteColor];
    _entryModel=entryModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:entryModel.pic]];
    _titleLabel.text=entryModel.name;
}
@end
