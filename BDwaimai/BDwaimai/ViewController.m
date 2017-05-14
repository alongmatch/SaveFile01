//
//  ViewController.m
//  BDwaimai
//
//  Created by sumshile on 2017/5/11.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "ViewController.h"
#import "Activity_listModel.h"
#import "Activity_mobileModel.h"
#import "Eight_entryModel.h"
#import "TTEightMainCell.h"
#import "TTCycleMobileCell.h"
#import "TTActivity_listCell.h"
@interface ViewController ()

@property(nonatomic,strong)NSMutableArray* listModelArray;
@property(nonatomic,strong)NSMutableArray* mobileModelArray;
@property(nonatomic,strong)NSMutableArray* entryModelArray;
//轮播器属性

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allocArrayData];
    [self loadData];
    [self tableDataLoad];
    [[UIApplication sharedApplication]keyWindow].backgroundColor=[UIColor whiteColor];
}
#pragma mark
#pragma mark - table初始化和注册
-(void)tableDataLoad
{
    [self.tableView registerNib:[UINib nibWithNibName:@"TTEightMainCell" bundle:nil] forCellReuseIdentifier:@"eight"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TTCycleMobileCell" bundle:nil] forCellReuseIdentifier:@"mobile"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TTActivity_listCell" bundle:nil] forCellReuseIdentifier:@"list"];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.rowHeight = 150;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}
#pragma mark
#pragma mark - 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listModelArray.count?3:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item==0) {
        TTEightMainCell* cell=[tableView dequeueReusableCellWithIdentifier:@"eight" forIndexPath:indexPath];
        cell.entryArray=self.entryModelArray;
        return cell;
    }
    if (indexPath.item==1)
    {
        TTCycleMobileCell* cell=[tableView dequeueReusableCellWithIdentifier:@"mobile" forIndexPath:indexPath];
        
        cell.mobileArray=self.mobileModelArray;
        
        return cell;
    }

    
    TTActivity_listCell* cell=[tableView dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];
    cell.listModelArray=self.listModelArray;
    return cell;
}


#pragma mark
#pragma mark - 初始化模型数组

-(void)allocArrayData
{
    self.listModelArray=[NSMutableArray array];
    self.mobileModelArray=[NSMutableArray array];
    self.entryModelArray=[NSMutableArray array];
}
#pragma mark
#pragma mark - 加载model数据

- (void)loadData {
    
    NSURL *url = [NSURL URLWithString:@"http://client.waimai.baidu.com/shopui/na/v1/cliententry?da_ext=&msgcuid=&return_type=launch&net_type=wifi&aoi_id=&taste=&address=&screen=320x568&sortby=&cuid=3D0A8678-18DC-4447-9611-13A411B1FCF9&hot_fix=1&uuid=C99F87B1-9588-443D-8BBA-D5DAE3CB57E1&alipay=1&sv=4.4.1&isp=46001&channel=appstore&loc_lng=13538713.207818&resid=1001&from=na-iphone&request_time=1487663910624&model=iPhone6%2C2&count=20&lng=&idfa=8EFD4589-EDD2-4958-A717-9AF218CBC152&page=1&os=10.0.2&lat=&loc_lat=3615772.560023&promotion=&city_id=&vmgdb=&jailbreak=0&device_name=%E9%BB%91%E9%A9%AC%E7%A8%8B%E5%BA%8F%E5%91%98"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 判断网络操作是否出错
        if (error == nil) {
            NSDictionary *JSONDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            // 还要判断数据是否出错
            if ([JSONDict[@"error_msg"] isEqualToString:@""]) {
                
                // 取result字段
                NSDictionary *resultDict = JSONDict[@"result"];
                
                NSArray* listArray=resultDict[@"eight_entry"];
                NSArray* activityArray=resultDict[@"activity_list"];
                NSArray* activity_mobile=resultDict[@"activity_mobile"];
                [listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    Eight_entryModel * model=[Eight_entryModel new];
                    [model setValuesForKeysWithDictionary:obj];
                    [self.entryModelArray addObject:model];
                }];
                [activityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    Activity_listModel * model=[Activity_listModel new];
                    [model setValuesForKeysWithDictionary:obj];
                    [self.listModelArray addObject:model];
                }];
                [activity_mobile enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    Activity_mobileModel* model=[Activity_mobileModel new];
                    [model setValuesForKeysWithDictionary:obj];
                    [self.mobileModelArray addObject:model];
                }];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    [self.tableView reloadData];
                }];
                
            } else {
                // 使用弹框的形式
                NSLog(@"%@",JSONDict[@"error_msg"]);
            }
            
        } else {
            // 使用弹框的形式
            NSLog(@"%@",error);
        }
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
