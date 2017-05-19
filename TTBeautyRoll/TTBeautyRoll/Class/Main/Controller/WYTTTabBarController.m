//
//  WYTTTabBarController.m
//  TTBeautyRoll
//
//  Created by sumshile on 2017/5/18.
//  Copyright © 2017年 sumshile. All rights reserved.
//

#import "WYTTTabBarController.h"
#import "WYTTNavViewController.h"
@interface WYTTTabBarController ()

@end

@implementation WYTTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray* mutab=[NSMutableArray array];
    [mutab addObject:[self navViewControllerWithTitle:@"首页" ImageName:@"tabBar_home" ClassName:@"WYTTHomeController"]];
    [mutab addObject:[self navViewControllerWithTitle:@"订单" ImageName:@"tabBar_home" ClassName:@"WYTTHomeController"]];
    [mutab addObject:[self navViewControllerWithTitle:@"" ImageName:@"tabBar_home" ClassName:@"WYTTHomeController"]];
    
}
-(WYTTNavViewController*)navViewControllerWithTitle:(NSString*)title ImageName:(NSString*)imageName ClassName:(NSString*)className
{
    Class claName=NSClassFromString(className);
    UIViewController* vc=[[claName alloc]init];
    vc.title=title;
    [vc.tabBarItem setImage:[UIImage imageNamed:imageName]];
    NSString* image_sel=[NSString stringWithFormat:@"%@_sel",imageName];
    UIImage* imageV=[UIImage imageNamed:image_sel];
    [vc.tabBarItem setSelectedImage:[imageV imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    WYTTNavViewController* nav=[[WYTTNavViewController alloc]initWithRootViewController:vc];
    return nav;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
