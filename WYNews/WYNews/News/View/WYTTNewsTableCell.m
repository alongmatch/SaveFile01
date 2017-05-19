//
//  WYTTNewsTableCell.m
//  WYNews
//
//  Created by sumshile on 2017/5/16.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "WYTTNewsTableCell.h"
#import "WYTTNewsModel.h"
#import <UIImageView+WebCache.h>
@interface WYTTNewsTableCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replayCountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgsrcImageViews;

@end

@implementation WYTTNewsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(WYTTNewsModel *)model
{
    _model=model;
    self.titleLabel.text = model.title;
    self.sourceLabel.text = model.source;
    self.replayCountLabel.text = model.replyCount.stringValue;
        
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"1"]];
        
        // 给多图的另外两个控件赋值
    if (model.imgextra.count > 0) {
            
            for (int i = 0; i < self.imgsrcImageViews.count; i++) {
                // 循环的取出控件,每取出一个就赋值一个
                UIImageView *imgsrcImgView = self.imgsrcImageViews[i];
                
                // 循环的取出控件对应的地址
                NSDictionary *imgsrcDict = model.imgextra[i];
                NSString *imgsrc = imgsrcDict[@"imgsrc"];
                
                [imgsrcImgView sd_setImageWithURL:[NSURL URLWithString:imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
            }
        }
}

@end
