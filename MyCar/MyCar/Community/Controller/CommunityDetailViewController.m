//
//  CommunityDetailViewController.m
//  MyCar
//
//  Created by 🐵 on 16-5-27.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "CommunityDetailViewController.h"

@interface CommunityDetailViewController ()

@property (nonatomic,strong) UIWebView * webView;

@end

@implementation CommunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self createWebView];
    [self createRightItem];
}

#pragma mark ---创建webView

- (void)createWebView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if ([ISNull isNilOfSender:self.url]) {
        return;
    }

    _webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
    

}
#pragma mark --创建右按钮
- (void)createRightItem{
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(ItemClicked:)];
    
}
#pragma mark --ItemAction

- (void)ItemClicked:(UIBarButtonItem *)item{
    
    
    [_webView reload];
    
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
