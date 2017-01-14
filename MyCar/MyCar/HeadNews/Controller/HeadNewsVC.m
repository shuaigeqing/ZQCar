//
//  HeadNewsVC.m
//  MyCar
//
//  Created by 🐵 on 16-5-20.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "HeadNewsVC.h"
#import "NewsViewController.h"
#import "CarViewController.h"
#import "AVViewController.h"
#import "NewCarViewController.h"
#import "SCNavTabBarController.h"

@interface HeadNewsVC ()

@end

@implementation HeadNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createController];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;

}
- (void)createController{
    NewsViewController * news = [[NewsViewController alloc]init];
    news.title = @"要闻";
    
    CarViewController * car = [[CarViewController alloc]init];
    car.title = @"说车";
    
//    AVViewController * av = [[AVViewController alloc]init];
//    av.title = @"视频";
//    
//    NewCarViewController * newCar = [[NewCarViewController alloc]init];
//    newCar.title = @"新车";
    
    SCNavTabBarController * navTabBar = [[SCNavTabBarController alloc]init];
    
    navTabBar.subViewControllers = @[news,car];
    navTabBar.navTabBarColor = [UIColor colorWithRed:35 / 255.0 green:43 / 255.0 blue:60 / 255.0 alpha:0.5];
    
    self.view.backgroundColor = [UIColor colorWithRed:55 / 255.0 green:63 / 255.0 blue:80 / 255.0 alpha:1];
    [navTabBar addParentController:self];
    
    

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
