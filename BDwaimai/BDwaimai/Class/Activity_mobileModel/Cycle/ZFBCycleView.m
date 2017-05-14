//
//  ZFBCycleView.m
//  01-图片轮播器
//
//  Created by teacher on 17/3/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "ZFBCycleView.h"
#import "Masonry.h"
#import "ZFBCycleFlowLayout.h"
#import "ZFBCycleCell.h"
#import "Activity_mobileModel.h"

// 图片的个数
#define KImageCount   self.imageNames.count
// 组数
#define KSectionCount  3
@interface ZFBCycleView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;
@end

static NSString *cycleCellID = @"cycleCellID";

@implementation ZFBCycleView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    
    
    // 1.创建collectionView
    [self makeCollectionView];
    
    // 2.添加分页指示器
    [self makePageControl];
    
    /**
     1.定时器间隔时间
     2.给谁添加一个定时器
     3.要执行的方法
     4.额外信息
     5.是否重复执行
     */
    //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    //
    //    // 把定时器添加到运行循环并且指定为通用模式"定时器和UI同级"
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    
    // timer开头的方法创建出来的定时器没有自动添加到运行循环,
    //    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    // 以上两行代码和scheduled开头的方法是创建的定时器代码时等价
    //    [timer fire];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _timer = timer;

}


// 定时器每两秒要让控制器执行的方法
- (void)nextPage {
    
    
    
    
    // 0.获取当前滚动到第几页了
    NSInteger page = _pageControl.currentPage;
    
    NSIndexPath *indexPath;
    
    // 1.如果走到最后一页继续向下一组的第0个格子走
    if (page == (_imageNames.count - 1)) {
        
        indexPath = [NSIndexPath indexPathForItem:0 inSection:KSectionCount / 2 + 1];
    } else {
        // 2.如果不是最后一张图片就向下一页走
        
        indexPath = [NSIndexPath indexPathForItem:++page inSection:KSectionCount / 2];
    }
    
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

- (void)makePageControl {
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
#warning mark - 在封装后此行代码需要写在拿到数据之后再设置总个数
//    pageControl.numberOfPages = _imageNames.count;
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.9 alpha:1];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.4 alpha:1];
    [self addSubview:pageControl];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(0);
    }];
    
    _pageControl = pageControl;
}

- (void)makeCollectionView {
    // 1.创建布局对象
    ZFBCycleFlowLayout *flowLayout = [[ZFBCycleFlowLayout alloc] init];
    
    // 2.创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    // 3.设置数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 4.注册cell
    UINib *nib = [UINib nibWithNibName:@"ZFBCycleCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:cycleCellID];
    
//#warning mark - 封装时把此行删除
//    [self layoutIfNeeded];
    
    
    // 封装后因为在初始化的时候还没有数据,所以直接滚动会有问题
//    // 5.一启动就滚动到中间这一组的第0个cell
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:KSectionCount / 2];
//    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    _collectionView = collectionView;
}

- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
    
    // 有了数据以后再去设置总页数
    _pageControl.numberOfPages = imageNames.count;


//    [self layoutIfNeeded];
    // 5.一启动就滚动到中间这一组的第0个cell
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:KSectionCount / 2];
//    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

// 绘制
- (void)drawRect:(CGRect)rect {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:KSectionCount / 2];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

// 代码方法去滚动,并且开启动滚动,滚动完一页停下来后来调用此方法一次
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndDecelerating:scrollView];
}

// 此方法是,当手动拖拽时,里面的内容完全停止滚动之后会调用此方法一次
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 计算前面有几个格子
    NSInteger itemCount = _collectionView.contentOffset.x / _collectionView.bounds.size.width;
    // 计算组的索引
    NSInteger section = itemCount / _imageNames.count;
    // 计算item的索引
    NSInteger item = itemCount % _imageNames.count;
    
    //    NSLog(@"%zd -%zd", section, item);
    // 如果还在中间这一组什么也不做
    if (section == KSectionCount / 2) return;
    
    
    // 如果不在中间这一组就不加动画的方法回到中间这一组,
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:KSectionCount / 2];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = (_collectionView.contentOffset.x / _collectionView.bounds.size.width + 0.499);
    //    NSLog(@"%zd", page);
    // 设置当前的页数
    _pageControl.currentPage = page % _imageNames.count;
    
}


// 用户将要开始拖拽时把定时器先暂停
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 让定时器在遥远的未来去执行
    _timer.fireDate = [NSDate distantFuture];
    //    NSLog(@"%@ --%@", [NSDate distantFuture], [NSDate distantPast]);
}

// 用户松开手之手让定时器继续执行
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 让定时器间隔两秒执行
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2.0];
}




#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return KSectionCount;
}

// 返回cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageNames.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    ZFBCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cycleCellID forIndexPath:indexPath];
    // 2.设置数据
    cell.model=self.imageNames[indexPath.row];
    // 3.返回cell
    return cell;
}


// 当自己从父控件上移除时就会调用此方法,从父控件上移除不代表销毁
- (void)removeFromSuperview {
    NSLog(@"%s", __FUNCTION__);
    [_timer invalidate];
}


- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

@end
