//
//  NewsDetailViewController.m
//  MyCar
//
//  Created by 🐵 on 16-5-25.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@property (nonatomic,strong)UIWebView * webView;

@property (nonatomic,copy) NSString * newsLink;

@end

@implementation NewsDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBarHidden =NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self loadData];

    [self createRightItem];
}
#pragma mark ---创建webView
- (void)createWebView{

    if (![ISNull isNilOfSender:self.name]) {
        self.title = self.name;
    }
    self.automaticallyAdjustsScrollViewInsets =NO;
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:_newsLink]];
    
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
    

}

#pragma mark 加载数据
- (void)loadData{
    
//    [MMProgressHUD showWithStatus:@"正在加载"];
   
    if (self.path) {
        _newsLink = self.path;
//         [MMProgressHUD dismissWithSuccess:@"刷新成功"];
        [self createWebView];
    }else{
        NSString * url;
        if (self.choose ==0) {
             url = [NSString stringWithFormat:DETAIL,self.NewsID];
        }else{
            
        url = [NSString stringWithFormat:CAR_CELL_DETAIL,self.NewsID];
        
        }
    
        
        [HttpRequest startHttpRequestWithURL:url andParmenter:nil andReturnBlock:^(NSData *data, NSError *error) {
            
            if (!error) {
//                [MMProgressHUD dismissWithSuccess:@"刷新成功"];
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSDictionary * dataDic = dic[@"data"];
                NSDictionary * shareDataDic = dataDic[@"shareData"];
                _newsLink = shareDataDic[@"newsLink"];
                NSLog(@"%@",_newsLink);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self createWebView];
                    
                });
            }else{
//                [MMProgressHUD dismissWithError:error.localizedDescription];
//                NSLog(@"%@",error.localizedDescription);
                
            }
        }];
        
    }
    
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
