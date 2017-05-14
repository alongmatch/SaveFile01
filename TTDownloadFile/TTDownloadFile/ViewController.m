//
//  ViewController.m
//  TTDownloadFile
//
//  Created by sumshile on 2017/5/13.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "ViewController.h"
#import "TTBookModel.h"
#import "TTDLBookCell.h"
#import "TTDownloadManager.h"
@interface ViewController ()<TTDLBookCellDelegate>
///模型数组
@property(nonatomic,strong)NSMutableArray<TTBookModel*>* bookList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self arrayModelInit];
    [self loadData];
}
#pragma mark
#pragma mark - 初始化数组
-(void)arrayModelInit
{
    self.bookList=[NSMutableArray array];
    
}

#pragma mark
#pragma mark - 加载数据
-(void)loadData
{
    NSURL* url=[NSURL URLWithString:@"http://42.62.15.101/yyting/bookclient/ClientGetBookResource.action?bookId=30776&imei=OEVGRDQ1ODktRUREMi00OTU4LUE3MTctOUFGMjE4Q0JDMTUy&nwt=1&pageNum=1&pageSize=50&q=114&sc=acca7b0f8bcc9603c25a52f572f3d863&sortType=0&token=KMSKLNNITOFYtR4iQHIE2cE95w48yMvrQb63ToXOFc8%2A"];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error==nil&&data!=nil)
        {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* bookArray=dic[@"list"];
            [bookArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TTBookModel* bookModel=[TTBookModel new];
                [bookModel setValuesForKeysWithDictionary:obj];
                bookModel.downSelected=NO;
                [self.bookList addObject:bookModel];
                
            }];
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
        else
        {
            NSLog(@"%@",error);
        }
    }]resume];
}
#pragma mark
#pragma mark - 重写代理方法传出点击的cell
-(void)bookCellDelegata:(TTDLBookCell *)cell
{
    NSIndexPath* indexPath=[self.tableView indexPathForCell:cell];
    TTDownloadManager* downLoadM=[TTDownloadManager sharedDownloadManage];
    
    TTBookModel *book = _bookList[indexPath.row];
    if (self.bookList[indexPath.row].downSelected==NO)
    {
        [downLoadM pauseDownloadWithURLString:self.bookList[indexPath.row].path pauseBlock:^{
            NSLog(@"%@暂停了下载",book.name);
        }];
        return;
    }
    [downLoadM downloadWithURLString:self.bookList[indexPath.row].path ProgressBlock:^(float progress) {
        NSLog(@"VC 进度 %zd -- %f",indexPath.row,progress);
        TTDLBookCell* upCell=[self.tableView cellForRowAtIndexPath:indexPath];
        book.parg=progress;
        upCell.bookModel=book;
    } completion:^(NSString *filePath) {
        NSLog(@"VC 下载完成 %@",filePath);
        TTDLBookCell* upCell=[self.tableView cellForRowAtIndexPath:indexPath];
        upCell.bookModel=book;
        
    }];
    
}


//数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bookList.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTDLBookCell* cell=[tableView dequeueReusableCellWithIdentifier:@"lin" forIndexPath:indexPath];
    cell.bookModel=self.bookList[indexPath.row];
    cell.delegate=self;
    return cell;
}


@end
