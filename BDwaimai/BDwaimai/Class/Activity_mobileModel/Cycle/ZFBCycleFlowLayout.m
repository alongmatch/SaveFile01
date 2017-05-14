//
//  ZFBCycleFlowLayout.m
//  01-图片轮播器
//
//  Created by teacher on 17/3/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "ZFBCycleFlowLayout.h"

@implementation ZFBCycleFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    // 水平方向滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置分页效果
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 关闭弹簧效果
    self.collectionView.bounces = NO;
}
@end
