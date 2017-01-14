//
//  DetailViewController.m
//  MyCar
//
//  Created by 🐵 on 16-5-29.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "DetailViewController.h"
#import "BaseTabBarController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

@interface DetailViewController ()

@property (nonatomic,strong) UIWebView * webView;

@property (nonatomic,copy) NSString * url;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    [self createRightItem];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    MMDrawerController * drawer = [self mm_drawerController];
    drawer.tabBarController.tabBar.hidden = YES;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --创建右按钮
- (void)createRightItem{
    
    UIBarButtonItem * refresh = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(ItemClicked:)];
    refresh.tag = 5000;
    
    
//    UIBarButtonItem * share = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(ItemClicked:)];
//    share.tag = 5001;
    
    self.navigationItem.rightBarButtonItem = refresh;

}
#pragma mark 加载数据
- (void)loadData{
//    NSLog(@"%@",_serialId);
//    [MMProgressHUD showWithStatus:@"正在加载"];
//    if ([ISNull isNilOfSender:_serialId]) {
//        return;
//    }
    NSString * URL = [NSString stringWithFormat:THREE_DETAIL,self.serialId];
        [HttpRequest startHttpRequestWithURL:URL andParmenter:nil andReturnBlock:^(NSData *data, NSError *error) {
            
            if (!error) {
//                [MMProgressHUD dismissWithSuccess:@"刷新成功"];
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSDictionary * dataDic = dic[@"data"];
                NSDictionary * HuiMaiCheDic = dataDic[@"HuiMaiChe"];
                _url = HuiMaiCheDic[@"WapLink"];
                NSLog(@"%@",_url);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self createWebView];
                    
                });
            }else{
                
//                [MMProgressHUD dismissWithError:error.localizedDescription];
//                NSLog(@"%@",error.localizedDescription);
                
                
            }
        }];
        
    }
    


#pragma mark --创建Webview

- (void)createWebView{
   
    self.automaticallyAdjustsScrollViewInsets =NO;
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
}

#pragma mark --ItemAction

- (void)ItemClicked:(UIBarButtonItem *)item{
//    if (item.tag ==5000) {
//        
//    }else{
//    
//    }
    
     [_webView reload];
    
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
