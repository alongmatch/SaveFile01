//
//  BDWMFlowLyout.m
//  百度外卖
//
//  Created by 代辉 on 2017/5/9.
//  Copyright © 2017年 代辉. All rights reserved.
//

#import "BDWMFlowLyout.h"

@implementation BDWMFlowLyout


- (void)prepareLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.minimumLineSpacing = 0;
    
    self.minimumInteritemSpacing = 0;
    
    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width / 5, self.collectionView.bounds.size.height / 2);
    
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    
}

//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
//    
//    NSArray *tempArr = [[NSArray alloc] initWithArray:arr copyItems:YES];
//    
//    for (int i = 0; i<tempArr.count; i++) {
//        
//        UICollectionViewLayoutAttributes *attr = tempArr[i];
//        
//        
//        
//    }
//    
//    
//    return tempArr;
//}



@end
