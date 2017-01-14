//
//  NewsViewController.m
//  MyCar
//
//  Created by 🐵 on 16-5-20.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.choose = 0;
}
#pragma mark 设置网址
- (void)setMyUrl{
    self.url = [NSString stringWithFormat:NEWS,self.page];
    
    self.buttonURL = HEAD_BTN;
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
