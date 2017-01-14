//
//  BaseTabBarController.m
//  Travel
//
//  Created by 🐵 on 16-5-19.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "BaseTabBarController.h"
#import "HeadNewsVC.h"
#import "CommunityVC.h"
#import "ChooseVC.h"
#import "MeVC.h"
#import "RightTableViewController.h"


@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createTabBar];
    
}
#pragma mark --创建TabBar
- (void)createTabBar{
    HeadNewsVC * head = [[HeadNewsVC alloc]init];
    CommunityVC * comm = [[CommunityVC alloc]init];
//    实现抽屉效果 的两个视图控制器
    ChooseVC * choose = [[ChooseVC alloc]init];
    RightTableViewController * right = [[RightTableViewController alloc]init];
    UINavigationController * navc = [[UINavigationController alloc]initWithRootViewController:right];
//    MeVC * me = [[MeVC alloc]init];
    NSMutableArray * array = [NSMutableArray arrayWithObjects:head,comm,choose,nil];
    
    NSArray * titleArr = @[@"头条",@"社区",@"选车"];
    
    NSArray * normalArr = @[@"tabbar_HeadNews.png",@"tabbar_BBS.png",@"tabbar_Car.png"];
    
    NSArray * selectedArr = @[@"tabbar_HeadNews_press.png",@"tabbar_BBS_press.png",@"tabbar_Car_press.png"];
    
    for (int i =0; i<array.count; i++) {
        UIViewController * vc = array[i];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
        nav.tabBarItem.title = titleArr[i];
      [array replaceObjectAtIndex:i withObject:nav];
       
        
        UIImage * normalImage = [UIImage imageNamed:normalArr[i]];
        UIImage * selectedImage = [UIImage imageNamed:selectedArr[i]];
        
        nav.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
//    创建抽屉控制器
    MMDrawerController * drawer = [[MMDrawerController alloc]initWithCenterViewController:array[2] rightDrawerViewController:navc];
    drawer.maximumRightDrawerWidth = 290;
    drawer.openDrawerGestureModeMask = MMOpenDrawerGestureModeCustom;
    drawer.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    drawer.tabBarItem.title = titleArr[2];
    UIImage * normalImage = [UIImage imageNamed:normalArr[2]];
    UIImage * selectedImage = [UIImage imageNamed:selectedArr[2]];
    drawer.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    drawer.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [array replaceObjectAtIndex:2 withObject:drawer];
    self.viewControllers = array;

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
