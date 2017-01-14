//
//  RightTableViewController.m
//  MyCar
//
//  Created by 🐵 on 16-5-28.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "RightTableViewController.h"
#import "DrawerModel.h"
#import "BrandViewController.h"
#import "ContainDrawerModel.h"
#import "DetailViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface RightTableViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) NSMutableArray * headerArr;

@property (nonatomic,strong) NSMutableArray * carArr;

@property (nonatomic,copy) NSString * url;

@end

@implementation RightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
//    [self setMyUrl];
//    [self.tableView.header beginRefreshing];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
//    [self initData];
    [self setMyUrl];
//    [self.tableView.header beginRefreshing];
    [self loadData];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    MMDrawerController * drawer = [self mm_drawerController];
    drawer.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    drawer.maximumRightDrawerWidth = (SCREEN_WIDTH * 2)/3;
    
    drawer.tabBarController.tabBar.hidden = NO;

    
}

#pragma mark 初始化
- (void)initData{
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addDropDownRefresh];
    _dataArr = [[NSMutableArray alloc]init];
    
    _headerArr = [[NSMutableArray alloc]init];
    
    _carArr = [[NSMutableArray alloc]init];
    
}
#pragma mark 设置网址
- (void)setMyUrl{
    
    self.url = [NSString stringWithFormat:TOW_DETAIL,self.masterId];
    
   
}
#pragma mark 加载数据
- (void)loadData{
    
    [_dataArr removeAllObjects];
//    [MMProgressHUD showWithStatus:@"正在刷新,请稍等"];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    if ([ISNull isNilOfSender:self.url]) {
        return;
    }
    [HttpRequest startHttpRequestWithURL:self.url andParmenter:nil andReturnBlock:^(NSData *data, NSError *error) {
        
        if (!error) {
            
//            [MMProgressHUD dismissWithSuccess:@"刷新成功"];
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           NSArray * dataArr = dic[@"data"];
            for (NSDictionary * dic1 in dataArr) {
                //             建模
                ContainDrawerModel * model = [[ContainDrawerModel alloc]init];
                model.brandId = dic1[@"brandId"];
                model.brandName = dic1[@"brandName"];
                model.serialListArr = dic1[@"serialList"];
                
                for (int i =0; i<model.serialListArr.count; i++) {
                    DrawerModel * model1 = [[DrawerModel alloc]init];
                    [model1 setValuesForKeysWithDictionary:model.serialListArr[i]];
                    [model.serialListArr replaceObjectAtIndex:i withObject:model1];
                }
               
                [_dataArr addObject:model];
            }
            
            [self.tableView reloadData];
            
            [self.tableView.header endRefreshing];
            
            
        }else{
//            [MMProgressHUD dismissWithError:error.localizedDescription];
//            NSLog(@"%@",error.localizedDescription);
            
            [self.tableView.header endRefreshing];
            
            
        }
    }];
    
}

#pragma mark --刷新
- (void)addDropDownRefresh{
    
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        

        [_dataArr removeAllObjects];
       
        [self setMyUrl];
        
        [self loadData];
        
    }];
    
    NSArray * array = @[[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"]];
    [header setImages:array forState:MJRefreshStateRefreshing];
    
    self.tableView.header = header;
   
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    
    return _dataArr.count +1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 1;
    }else{
    ContainDrawerModel * model = _dataArr[section-1];
    NSMutableArray * array = model.serialListArr;
    return array.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([ISNull isNilOfSender:_dataArr]) {
//        return [[UITableViewCell alloc]init];
//    }
    
    
    if (indexPath.section == 0) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }else{
        
        }
        
        cell1.textLabel.text = @"品牌介绍";
        
        [cell1.imageView sd_setImageWithURL:[NSURL URLWithString:self.logoUrl] placeholderImage:nil];
        
        return cell1;
        
    }else{
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];
        }else{
        }
        ContainDrawerModel * model = _dataArr[indexPath.section-1];
        DrawerModel * drawerModel = model.serialListArr[indexPath.row];
        [cell2.imageView sd_setImageWithURL:[NSURL URLWithString:drawerModel.Picture] placeholderImage:nil];
        cell2.textLabel.text = drawerModel.serialName;
        cell2.detailTextLabel.text = drawerModel.dealerPrice;
        return cell2;
    }
    
   }
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{

    ContainDrawerModel * model = _dataArr[section-1];
    return model.brandName;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{

    return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        BrandViewController * brand = [[BrandViewController alloc]init];
        
        brand.masterId =self.masterId;
        brand.masterName = self.masterName;
        brand.hidesBottomBarWhenPushed = YES;
        MMDrawerController * drawer = [self mm_drawerController];
        drawer.maximumRightDrawerWidth = SCREEN_WIDTH;
        [self.navigationController pushViewController:brand animated:YES];
        
    }else{
    DetailViewController * detail = [[DetailViewController alloc]init];
    ContainDrawerModel * model = _dataArr[indexPath.section -1];
    DrawerModel * drawerModel = model.serialListArr[indexPath.row];
    
    detail.serialId = drawerModel.serialId;
    detail.hidesBottomBarWhenPushed = YES;
    MMDrawerController * drawer = [self mm_drawerController];
    drawer.maximumRightDrawerWidth = SCREEN_WIDTH;
    
    [self.navigationController pushViewController:detail animated:YES];
    }

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
