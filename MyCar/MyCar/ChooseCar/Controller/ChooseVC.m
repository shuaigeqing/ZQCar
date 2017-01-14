//
//  ChooseVC.m
//  MyCar
//
//  Created by 🐵 on 16-5-20.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "ChooseVC.h"
#import "ChooseModel.h"
#import "UIViewController+MMDrawerController.h"
#import "RightTableViewController.h"
#import "ClassTableViewCell.h"


@interface ChooseVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,copy) NSString * url;

@property (nonatomic,strong) NSMutableArray * headerArr;

@property (nonatomic,strong) NSMutableArray * carArr;

@end

@implementation ChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选车";
    [self initData];
    [self createTableView];
    [_tableView.header beginRefreshing];

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    MMDrawerController * drawer = [self mm_drawerController];
    
    drawer.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
    drawer.tabBarController.tabBar.hidden = NO;
    
    
}

#pragma mark 初始化
- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];
    
    _headerArr = [[NSMutableArray alloc]init];
    
    _carArr = [[NSMutableArray alloc]init];
}

#pragma mark 加载数据
- (void)loadData{
    
//    [MMProgressHUD showWithStatus:@"正在刷新,请稍等"];
    
//    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    if ([ISNull isNilOfSender:CHOOSE_CAR]) {
        return;
    }
    [HttpRequest startHttpRequestWithURL:CHOOSE_CAR andParmenter:nil andReturnBlock:^(NSData *data, NSError *error) {
        
        if (!error) {
            
//            [MMProgressHUD dismissWithSuccess:@"刷新成功"];
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * dataArr = dic[@"data"];
            for (NSDictionary * dic in dataArr) {
//             建模
            ChooseModel * model = [[ChooseModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                
                [_dataArr addObject:model];
                
            }
//         数据分类整理
            [self GetHeaderArrAndSort];
            
            [_tableView reloadData];
            
            [_tableView.header endRefreshing];
            
            
        }else{
//            [MMProgressHUD dismissWithError:error.localizedDescription];
//            NSLog(@"%@",error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
                imageView.image = [UIImage imageNamed:@"not_net_background@2x.png"];
                _tableView.backgroundView = imageView;
                
                
                
            });
            [_tableView.header endRefreshing];
            
            
        }
    }];
    
}

#pragma mark --获取组头数据 排序
- (void)GetHeaderArrAndSort{

    for (int i = 0; i<26; i++) {
        NSMutableArray * array = [[NSMutableArray alloc]init];
        [_carArr addObject:array];
    }
    if ([ISNull isNilOfSender:_dataArr]) {
        return;
    }
    for (ChooseModel * model in _dataArr) {
       
        int index = [model.initial characterAtIndex:0] -'A';
        [_carArr[index] addObject:model];

    }
    
    [_carArr removeObject:@[]];
    
    for (NSMutableArray * array in _carArr) {
        ChooseModel * model = array[0];
        [_headerArr addObject:model.initial];
        
    }
    
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
   
    //    自适应
    //    _tableView.rowHeight = UITableViewAutomaticDimension;
    //    _tableView.estimatedRowHeight = 44.0;
    
    //     注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"ClassTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self addDropDownRefresh];
   
    
}

#pragma mark --刷新
- (void)addDropDownRefresh{
    
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        
        [_dataArr removeAllObjects];
        [_headerArr removeAllObjects];
        [_carArr removeAllObjects];
        [self loadData];
        
    }];
    
    NSArray * array = @[[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"]];
    [header setImages:array forState:MJRefreshStateRefreshing];
    
    _tableView.header = header;
    
}

#pragma mark TableView 的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_carArr[section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //加入防止下拉刷新崩溃限制
    
    if (_carArr.count <=0) {
        return [[UITableViewCell alloc]init];
    }
    
    ClassTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    ChooseModel * model = _carArr[indexPath.section] [indexPath.row];
    
    [cell loadDataFromModel:model];
    
    return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _carArr.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([ISNull isNilOfSender:_headerArr]) {
        return nil;
    }
    return _headerArr[section];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return _headerArr;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//  注意导入类别
    MMDrawerController * drawer = [self mm_drawerController];
    UINavigationController * nac = (UINavigationController *)drawer.rightDrawerViewController;
    RightTableViewController * right = (RightTableViewController *)nac.viewControllers[0];
    
    ChooseModel * model = _carArr[indexPath.section] [indexPath.row];
    right.logoUrl = model.logoUrl;
    right.masterId = model.masterId;
    right.masterName = model.name;
   [drawer toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
       
   }];


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
