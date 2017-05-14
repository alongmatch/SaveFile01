//
//  TTDLBookCell.h
//  TTDownloadFile
//
//  Created by sumshile on 2017/5/13.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTBookModel,TTDLBookCell;
@protocol TTDLBookCellDelegate <NSObject>

-(void)bookCellDelegata:(TTDLBookCell*)cell;

@end
@interface TTDLBookCell : UITableViewCell
@property(nonatomic,strong)TTBookModel* bookModel;
@property (weak, nonatomic)id <TTDLBookCellDelegate> delegate;
@end
