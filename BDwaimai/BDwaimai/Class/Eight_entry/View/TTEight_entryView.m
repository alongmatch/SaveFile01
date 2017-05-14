//
//  TTEight_entryView.m
//  BDwaimai
//
//  Created by sumshile on 2017/5/11.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "TTEight_entryView.h"
#import "BDWMFlowLyout.h"
#import "TTEight_entryCollectCell.h"
@interface TTEight_entryView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic)UICollectionView* collec;
@end
@implementation TTEight_entryView


-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}


-(void)setupUI
{
    UICollectionView* collec=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[BDWMFlowLyout new]];
    collec.dataSource=self;
    collec.delegate=self;
    _collec=collec;
    [collec registerNib:[UINib nibWithNibName:@"TTEight_entryCollectCell" bundle:nil] forCellWithReuseIdentifier:@"eightcell"];
    [self addSubview:collec];
    [collec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    self.backgroundColor=[UIColor whiteColor];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.entryArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTEight_entryCollectCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"eightcell" forIndexPath:indexPath];
    cell.entryModel=self.entryArray[indexPath.item];
    return cell;
}
-(void)setEntryArray:(NSMutableArray<Eight_entryModel *> *)entryArray
{
    _entryArray=entryArray;
    [self.collec reloadData];
}
@end
