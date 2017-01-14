//
//  BaseBBsViewController.m
//  MyCar
//
//  Created by 🐵 on 16-5-26.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "BaseBBsViewController.h"
#import "BBSModel.h"
#import "BBSTableViewCell.h"
#import "HotTableViewCell.h"
#import "CommunityDetailViewController.h"

@interface BaseBBsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseBBsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self setMyUrl];
    [self loadData];
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_tableView.header beginRefreshing];
    
    
}
#pragma mark 初始化
- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];

    
    _page =0;
}
#pragma mark 设置网址
- (void)setMyUrl{
    self.url = [NSString stringWithFormat:kGetForumInfoURL,self.page];
    
}
#pragma mark 加载数据
- (void)loadData{
       [HttpRequest startHttpRequestWithURL:self.url andParmenter:nil andReturnBlock:^(NSData *data, NSError *error) {
           
           if (!error) {
               NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               NSArray * postListArr = dic[@"postList"];
               for (NSDictionary * dic in postListArr) {
//               建模
                   BBSModel * model = [[BBSModel alloc]init];
                   
                   [model setValuesForKeysWithDictionary:dic];
                   
                   [_dataArr addObject:model];
                   
               }
               [_tableView reloadData];
               [_tableView.header endRefreshing];
               [_tableView.footer endRefreshing];
               
               
           }else{
           
               NSLog(@"%@",error.localizedDescription);
               dispatch_async(dispatch_get_main_queue(), ^{
                   
                   UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
                   imageView.image = [UIImage imageNamed:@"not_net_background@2x.png"];
                   _tableView.backgroundView = imageView;
                   
                   
                   
               });
               
               dispatch_async(dispatch_get_main_queue(), ^{
                   UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
                   imageView.image = [UIImage imageNamed:@"notice_pic_background_defualt@2x.png"];
                   _tableView.backgroundView = imageView;

                   
                   
               });
               
               [_tableView.header endRefreshing];
               [_tableView.footer endRefreshing];
           
           }
           
       }];

}
#pragma mark 创建列表
- (void)createTableView{
    //关闭自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //    没网时去除Tableview的线条 设置背景图
    _tableView.tableFooterView = [[UIView alloc]init];
    
    [_tableView registerNib:[UINib nibWithNibName:@"BBSTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HotTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self addDropDownRefresh];
    [self addDropUpRefresh];
}


#pragma mark --刷新
- (void)addDropDownRefresh{
    
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        _page = 0;
        [_dataArr removeAllObjects];
        [self setMyUrl];
        [self loadData];
        
    }];
    
    NSArray * array = @[[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"]];
    [header setImages:array forState:MJRefreshStateRefreshing];
    
    _tableView.header = header;
    
}


- (void)addDropUpRefresh{
    
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        _page+=10;
        [self setMyUrl];
        [self loadData];
        
    }];
    NSArray * array = @[[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"]];
    [footer setImages:array forState:MJRefreshStateRefreshing];
    
    _tableView.footer = footer;
    
}
#pragma mark TableView 的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //    防越界
    if (_dataArr.count <=0) {
        return [[UITableViewCell alloc]init];
    }

    
    if (self.type == BBSVIEW) {
        BBSTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        BBSModel * model = _dataArr[indexPath.row];
        
        [cell loadDataFromModel:model];
        return cell;
       

    }else{
        HotTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        BBSModel * model = _dataArr[indexPath.row];
        
        [cell loadDataFromModel:model];
        return cell;
    }
   
   

    
   }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
         
    CommunityDetailViewController * detail = [[CommunityDetailViewController alloc]init];
    BBSModel * model = _dataArr[indexPath.row];
    detail.url = model.postLink;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
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
