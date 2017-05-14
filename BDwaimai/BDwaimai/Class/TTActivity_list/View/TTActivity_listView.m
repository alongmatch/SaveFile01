//
//  TTActivity_listView.m
//  baiduTakeawary
//
//  Created by sumshile on 2017/5/10.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "TTActivity_listView.h"
#import "Activity_listModel.h"
#import "TTActivityRecommendView.h"
@interface TTActivity_listView ()
///scroll
@property (weak, nonatomic)UIScrollView* scrollView;
///容器视图
@property (weak, nonatomic)UIView* contenView;

///view集合
@property(nonatomic,strong)NSMutableArray<TTActivityRecommendView*>* remendViewArray;
@end
@implementation TTActivity_listView



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark
#pragma mark - 封装ui

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}
-(void)setupUI
{
    [self initRemendArray];
    [self setupScrollView];
}
-(void)initRemendArray
{
    self.remendViewArray=[NSMutableArray array];
}
#pragma mark
#pragma mark - 创建remendView
-(void)setupRemendView
{
    

    for (int i=0; i<self.listModelArray.count; i++)
    {
        TTActivityRecommendView* re=[TTActivityRecommendView activityRecommendView];
        re.listModel=self.listModelArray[i];
        [self.contenView addSubview:re];
        re.listModel=self.listModelArray[i];
        [self.remendViewArray addObject:re];
        
        re.backgroundColor=[UIColor whiteColor];
    }
    for (int i=0; i<self.listModelArray.count; i++)
    {
        
        TTActivityRecommendView* re=self.remendViewArray[i];

        
        
        [re mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(i*(self.scrollView.width/3));
            make.width.offset(self.scrollView.width/3);
             make.top.bottom.offset(0);
        }];

        
    }
}

#pragma mark
#pragma mark - 创建一个scrollView来保证view的滑动

-(void)setupScrollView
{
    UIScrollView* scrollView=[UIScrollView new];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.offset(0);
    }];
    self.scrollView=scrollView;
    
    //容器视图
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self layoutIfNeeded];
    UIView* contenView=[[UIView alloc]init];
    [_scrollView addSubview:contenView];
    self.contenView=contenView;
    [contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.offset(400);
        make.height.offset(_scrollView.height);
        make.edges.offset(0);
    }];
    

    
    
}
#pragma mark
#pragma mark - 模型视图自动布局
-(void)setListModelArray:(NSMutableArray<Activity_listModel *> *)listModelArray
{
    _listModelArray=listModelArray;
    
    self.backgroundColor=[UIColor whiteColor];
    [self setupRemendView];
    [self layoutIfNeeded];
    [_contenView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(self.scrollView.width/3*(self.listModelArray.count));
    }];
    
    [self layoutIfNeeded];
    self.scrollView.contentSize=CGSizeMake(self.contenView.frame.size.width, 0) ;
}



@end


























