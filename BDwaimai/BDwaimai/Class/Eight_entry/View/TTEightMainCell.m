//
//  TTEightMainCell.m
//  BDwaimai
//
//  Created by sumshile on 2017/5/11.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "TTEightMainCell.h"
#import "TTEight_entryView.h"
@interface TTEightMainCell ()
@property (weak, nonatomic) IBOutlet TTEight_entryView *eight_entry;


@end
@implementation TTEightMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor=[UIColor whiteColor];
}
-(void)setEntryArray:(NSMutableArray<Eight_entryModel *> *)entryArray
{
    _entryArray=entryArray;
    _eight_entry.entryArray=entryArray;
    
}
@end
