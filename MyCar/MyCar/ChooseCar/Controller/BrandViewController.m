//
//  BrandViewController.m
//  MyCar
//
//  Created by 🐵 on 16-5-30.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "BrandViewController.h"
#import "BrandModel.h"
#import "BrandTableViewCell.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

@interface BrandViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) BrandModel * model;

@end

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self loadData];
    [self createTableView];
    
    self.title = self.masterName;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    MMDrawerController * drawer = [self mm_drawerController];
    
    drawer.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
    drawer.tabBarController.tabBar.hidden = YES;

    
}

#pragma mark 初始化
- (void)initData{
//    _dataArr = [[NSMutableArray alloc]init];
    
}

#pragma mark 加载数据
- (void)loadData{
   
//    [MMProgressHUD showWithStatus:@"正在加载"];
    
    NSString * URL = [NSString stringWithFormat:BRAND_INTRODUCTION,self.masterId];
    [HttpRequest startHttpRequestWithURL:URL andParmenter:nil andReturnBlock:^(NSData *data, NSError *error) {
        
        if (!error) {
//            [MMProgressHUD dismissWithSuccess:@"刷新成功"];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary * dataDic = dic[@"data"];
//            建模
            _model = [[BrandModel alloc]init];
            
            [_model setValuesForKeysWithDictionary:dataDic];
           
            [_tableView reloadData];
        }else{
            
      dispatch_async(dispatch_get_main_queue(), ^{
          
          UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
          imageView.image = [UIImage imageNamed:@"not_net_background@2x.png"];
          _tableView.backgroundView = imageView;
          
          
          
      });
        
        
        }
    }];
    
}
#pragma mark 创建列表
- (void)createTableView{
    //关闭自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT - 64-10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.bounces = NO;
    
    //    没网时去除Tableview的线条 设置背景图
    _tableView.tableFooterView = [[UIView alloc]init];
   
//        自适应
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 128.0;
    
    //     注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"BrandTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
}

#pragma mark TableView 的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //加入防止崩溃限制
    
    if ( self.model == nil) {
        return [[UITableViewCell alloc]init];
    }
    BrandTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.Label.text = _model.introduction;
    }else{
    
        cell.Label.text = _model.logoMeaning;
    }
    
    return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"品牌介绍";
    }else{
    
       return @"车标故事";
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return nil;
//    }else{
//        UIView * view =[[UIView alloc]init];
//        view.backgroundColor = [UIColor whiteColor];
//        return view;
//    }
//
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return 0;
//    }else{
//        
//        return SCREEN_HEIGHT;
//    }
//
//   
//}

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
