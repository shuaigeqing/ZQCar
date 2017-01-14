//
//  BBSViewController.m
//  MyCar
//
//  Created by 🐵 on 16-5-26.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "BBSViewController.h"

@interface BBSViewController ()

@end

@implementation BBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.type = BBSVIEW;
}

#pragma mark 设置网址
- (void)setMyUrl{
    self.url = [NSString stringWithFormat:kGetForumInfoURL,self.page];
    
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
