//
//  TTDLBookCell.m
//  TTDownloadFile
//
//  Created by sumshile on 2017/5/13.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "TTDLBookCell.h"
#import "TTBookModel.h"
@interface TTDLBookCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *progView;


@end
@implementation TTDLBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIButton* button=[[UIButton alloc]init];
    [button setTitle:@"下载" forState:UIControlStateNormal];
    [button setTitle:@"暂停" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:self action:@selector(clink:) forControlEvents:UIControlEventTouchUpInside];
    self.accessoryView=button;
}
-(void)clink:(UIButton*)btn
{
    bool lastSelected=_bookModel.downSelected;
    btn.selected=!lastSelected;
    _bookModel.downSelected=!lastSelected;
    if ([self.delegate respondsToSelector:@selector(bookCellDelegata:)])
    {
        [self.delegate bookCellDelegata:self];
    }
}


-(void)setBookModel:(TTBookModel *)bookModel
{
    _bookModel=bookModel;
    _nameLabel.text=bookModel.name;
    UIButton* button=(UIButton*)self.accessoryView;
    button.selected=bookModel.downSelected;
    self.progView.progress=bookModel.parg;
}

@end
