//
//  NewsTableViewController.m
//  NetEaseSH05
//
//  Created by teacher on 17/5/14.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NetworkManager.h"
#import "WYTTNewsTableCell.h"
#import <YYModel.h>
#import "WYTTNewsModel.h"

#define kBaseCell (@"baseCell")
#define kBigCell (@"kBigCell")
#define kImagesCell (@"kImagesCell")

@interface NewsTableViewController ()

@property (nonatomic, strong) NSArray *newsList;
@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseCell" bundle:nil] forCellReuseIdentifier: kBaseCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"BigCell" bundle:nil] forCellReuseIdentifier: kBigCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"ImagesCell" bundle:nil] forCellReuseIdentifier: kImagesCell];
    
    
}

- (void)setURLString:(NSString *)URLString {
    
    _URLString = URLString;
    NSLog(@"NewsTableViewController %@",URLString);
    
    // 发送网络请求获取数据
    [[NetworkManager sharedManager] GETWithURLString:URLString parameters:nil success:^(NSDictionary *responseObject) {
        NSString *key = responseObject.keyEnumerator.nextObject;
        NSArray *dictArr = responseObject[key];
        self.newsList = [NSArray yy_modelArrayWithClass:[WYTTNewsModel class] json:dictArr];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newsList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYTTNewsModel *news = self.newsList[indexPath.row];
    
    NSString *identifier;
    if (news.imgType == YES) {
        identifier = kBigCell;
    } else if (news.imgextra.count > 0) {
        identifier = kImagesCell;
    } else {
        identifier = kBaseCell;
    }
    
    WYTTNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    
    cell.model = news;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYTTNewsModel *news = self.newsList[indexPath.row];
    
    CGFloat cellH;
    if (news.imgType == YES) {
        cellH = 180;
    } else if (news.imgextra.count > 0) {
        cellH = 130;
    } else {
        cellH = 80;
    }
    return cellH;
}

@end
