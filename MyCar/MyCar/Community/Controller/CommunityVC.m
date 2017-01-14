//
//  CommunityVC.m
//  MyCar
//
//  Created by 🐵 on 16-5-20.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "CommunityVC.h"
#import "BBSViewController.h"
#import "HotViewController.h"

@interface CommunityVC ()

@property (nonatomic,strong) BBSViewController * bbs;
@property (nonatomic,strong) HotViewController * hot;

@end

@implementation CommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createController];
    [self createSegment];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    self.tabBarController.tabBar.hidden = NO;
    
}


- (void)createSegment{
    
    UISegmentedControl * seg = [[UISegmentedControl alloc]initWithItems:@[@"论坛",@"热帖"]];
    seg.frame = CGRectMake(0, 0, 200, 30) ;
    
    seg.selectedSegmentIndex =0;
    
    [seg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    
    
    self.navigationItem.titleView =seg;
    
}

- (void)createController{
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    _bbs = [[BBSViewController alloc]init];
    _bbs.view.frame = self.view.bounds;
    [self.view addSubview:_bbs.view];
    
    _hot = [HotViewController new];
    _hot.view.frame = self.view.bounds;
    [self.view addSubview:_hot.view];
    
    [self  addChildViewController:_bbs];
    [self addChildViewController:_hot];
    
    [self.view bringSubviewToFront:_bbs.view];
    
   
}

- (void)segChange:(UISegmentedControl *)seg{
    if (seg.selectedSegmentIndex  == 0) {
        [self.view bringSubviewToFront:_bbs.view];
    }else{
        
        [self.view bringSubviewToFront:_hot.view];
        
    }
    
    
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
