//
//  WYTTHomeViewController.m
//  WYNews
//
//  Created by sumshile on 2017/5/14.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "WYTTHomeViewController.h"
#import "WYLabelModel.h"
#import "WYTopLabel.h"
#import "UIView+WP.h"
#import "WYTTNewsCell.h"
@interface WYTTHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *bottomCollection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *bottomFlow;
@property(nonatomic,strong)NSArray<WYLabelModel*>* labelModelList;
@property(nonatomic,strong)NSMutableArray <WYTopLabel*>* topArray;

@end

@implementation WYTTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _topArray=[NSMutableArray array];
    [self loadData];
    [self initLabelArray];
    [self newsCollectionFlowLayout];
    
}
#pragma mark
#pragma mark - 设置collection
-(void)newsCollectionFlowLayout
{
    self.bottomFlow.itemSize=CGSizeMake(self.view.width, self.view.height-44);
    self.bottomFlow.minimumLineSpacing=0;
    self.bottomFlow.minimumInteritemSpacing=0;
    self.bottomCollection.bounces=YES;
    self.bottomFlow.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    self.bottomCollection.pagingEnabled=YES;
    
}

#pragma mark - 频道标签点击事件
- (void)labelTapClick:(UITapGestureRecognizer *)tap {
    
    // 1.把点击的label居中
    // 1.1 获取点击的label
    WYTopLabel *tapLabel = (WYTopLabel *)tap.view;
    // 1.2 获取点击的label滚动到居中时,需要滚动的距离
    CGFloat offsetX = tapLabel.center.x - (self.view.bounds.size.width * 0.5);
    
    // 1.3 设置左右滚动的临界值
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.topScrollView.contentSize.width - self.view.bounds.size.width;
    if (offsetX < minOffsetX) {
        offsetX = minOffsetX;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 1.4 找到需要滚动到的目标点
    CGPoint point = CGPointMake(offsetX, 0);
    // 1.5 直接滚过去
    [self.topScrollView setContentOffset:point animated:YES];
    
    // 2.把点击的label对应的新闻视图滚动到频幕
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:tapLabel.tag inSection:0];
    [self.bottomCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    // 3.点击某个标签时,只把选中的标签变红,其它的标签全部变黑
    for (int i = 0; i < self.labelModelList.count; i++) {
        
        // 遍历所有的频道标签
        WYTopLabel *label = self.topArray[i];
        // 筛选出选中的那一个
        if (i == tapLabel.tag) {
            label.scale = 1.0;
        } else {
            label.scale = 0;
        }
    }
}
#pragma mark
#pragma mark - 创建label到topScrollview
-(void)initLabelArray
{
    float topLabelW=self.view.width/5;
    for (int i=0; i<_labelModelList.count; i++)
    {
        WYTopLabel* top=[[WYTopLabel alloc]initWithFrame:CGRectZero];
        top.text=self.labelModelList[i].tname;
        [self.topScrollView addSubview:top];
        top.frame=CGRectMake(topLabelW*i, 0, topLabelW, 44);

        [_topArray addObject:top];
        // 给label添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapClick:)];
        [top addGestureRecognizer:tap];
        // 开启LABEL的交互能力
        top.userInteractionEnabled = YES;
        // 做标记,方便新闻滚动视图找到跟频道标签的对应点
        top.tag = i;
        
        
        // 默认使"头条"为红色和最大缩放比
        if (i == 0) {
            top.scale = 1.0;
        }
    }
    self.topScrollView.contentSize=CGSizeMake(47*topLabelW, 0);
    self.bottomCollection.delegate=self;
    self.bottomCollection.dataSource=self;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.labelModelList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WYTTNewsCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"coll" forIndexPath:indexPath];
    NSString *URLString = [NSString stringWithFormat:@"article/list/%@/0-20.html",self.labelModelList[indexPath.row].tid];
    cell.URLString = URLString;
    return cell;
}

#pragma mark
#pragma mark - 加载数据
-(void)loadData
{
    _labelModelList=[WYLabelModel getWYLabelModel];
    
}
#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 1.1 获取点击的label
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    WYTopLabel *label = self.topArray[index];
    
    // 1.2 获取点击的label滚动到居中时,需要滚动的距离
    CGFloat offsetX = label.center.x - (self.view.bounds.size.width * 0.5);
    
    // 1.3 设置左右滚动的临界值
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.topScrollView.contentSize.width - self.view.bounds.size.width;
    if (offsetX < minOffsetX) {
        offsetX = minOffsetX;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 1.4 找到需要滚动到的目标点
    CGPoint point = CGPointMake(offsetX, 0);
    // 1.5 直接滚过去
    [self.topScrollView setContentOffset:point animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 获取当前滚动到的索引
    NSInteger currentIndex = scrollView.contentOffset.x / self.view.bounds.size.width;
    
    // 要实现频道标签缩放,需要获取四个值 : 左边标签索引和缩放比 / 右边标签索引和缩放比
    
    // 找到左右标签的索引
    NSInteger leftIndex = currentIndex;
    NSInteger rightInedx = leftIndex + 1;
    
    // 找到左右标签的缩放比
    CGFloat index_float = scrollView.contentOffset.x / self.view.bounds.size.width;
    
    CGFloat rightScale = index_float - currentIndex;
    CGFloat leftScale = 1 - rightScale;
    
    // 获取左右索引对应的左右标签
    WYTopLabel *leftLabel = self.topArray[leftIndex];
    leftLabel.scale = leftScale;
    
    // 防止角标越界
    if (rightInedx < self.topArray.count) {
        WYTopLabel *rightLabel = self.topArray[rightInedx];
        rightLabel.scale = rightScale;
    }
    
    
}

@end
