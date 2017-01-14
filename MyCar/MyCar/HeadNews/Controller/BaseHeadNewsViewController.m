//
//  BaseHeadNewsViewController.m
//  MyCar
//
//  Created by 🐵 on 16-5-20.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "BaseHeadNewsViewController.h"
#import "NewsCellModel.h"
#import "NewsTableViewCell.h"
#import "HeadButtonModel.h"
#import "ButtonOnHeadView.h"
#import "PicTableViewCell.h"
#import "AVTableViewCell.h"
#import "NewsDetailViewController.h"

@interface BaseHeadNewsViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation BaseHeadNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self setMyUrl];
//    [self loadButtonData];
    [self createTableView];
    [_tableView.header beginRefreshing];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSArray * array = [_tableView indexPathsForVisibleRows];
    
    for (NSIndexPath * indexpath in array) {
        
        if (_dataArr.count <=0 || indexpath.row >=_dataArr.count -3) {
            return;
        }
        
        NewsCellModel * model = _dataArr[indexpath.row +3];
        if (model.duration != nil) {
            
            AVTableViewCell * cell = (AVTableViewCell *)[_tableView cellForRowAtIndexPath:indexpath];
            cell.IV.hidden = NO;
            [self.player stop];
//            [self.player.view removeFromSuperview];
            
        }
    }}
- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
//    AVTableViewCell * cell = (AVTableViewCell *)[_tableView cellForRowAtIndexPath:self.indexpath];
//    cell.IV.hidden = NO;
//    [_player stop];
}

#pragma mark 初始化
- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];
    
    _buttonArr = [[NSMutableArray alloc]init];
    
    _page =1;
}
#pragma mark 设置网址
- (void)setMyUrl{
    self.url = [NSString stringWithFormat:NEWS,_page];
    
    self.buttonURL = HEAD_BTN;
}
#pragma mark 加载数据
- (void)loadData{
    
//    [MMProgressHUD showWithStatus:@"正在刷新,请稍等"];
    
//    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    if ([ISNull isNilOfSender:self.url]) {
        return;
    }
    [HttpRequest startHttpRequestWithURL:self.url andParmenter:nil andReturnBlock:^(NSData *data, NSError *error) {
        
        if (!error) {
            
//            [MMProgressHUD dismissWithSuccess:@"刷新成功"];
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary * dataDic = dic[@"data"];
            NSArray * lisrtArr = dataDic[@"list"];
            
            for (NSDictionary * dic in lisrtArr) {
                //            模型
                NewsCellModel * model = [[NewsCellModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [_dataArr addObject:model];
                
            }
            
            
//            创建头视图
            [self createHeadView];
            [_tableView reloadData];
            
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];

        }else{
//            [MMProgressHUD dismissWithError:error.localizedDescription];
//            NSLog(@"%@",error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
                imageView.image = [UIImage imageNamed:@"not_net_background@2x.png"];
                _tableView.backgroundView = imageView;
                
                
                
            });
            
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
        
        }
           }];

}
- (void)loadButtonData{
    
    
    if ([ISNull isNilOfSender:self.buttonURL]) {
        return;
    }
   
     [HttpRequest startHttpRequestWithURL:self.buttonURL andParmenter:nil andReturnBlock:^(NSData *data, NSError *error) {
         if (!error) {
             NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
             NSDictionary * dataDic = dic[@"data"];
             
             NSArray * listArr = dataDic[@"list"];
             
             for (NSDictionary * dic in listArr) {
//                建模
                 HeadButtonModel * model = [[HeadButtonModel alloc]init];
                 [model setValuesForKeysWithDictionary:dic];
                 
                 [_buttonArr addObject:model];
                 
             }
             
             [_tableView reloadData];
            
         }else{
         
          NSLog(@"%@",error.localizedDescription);
             
         }
         
         
     }];

}

#pragma mark 创建列表
- (void)createTableView{
    //关闭自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-20, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
   

//    没网时去除Tableview的线条 设置背景图
    _tableView.tableFooterView = [[UIView alloc]init];
   
//    自适应
//    _tableView.rowHeight = UITableViewAutomaticDimension;
//    _tableView.estimatedRowHeight = 44.0;
    
//     注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"BASE"];
    [_tableView registerNib:[UINib nibWithNibName:@"PicTableViewCell" bundle:nil] forCellReuseIdentifier:@"picCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"AVTableViewCell" bundle:nil] forCellReuseIdentifier:@"avCell"];
    
    [self addDropDownRefresh];
    [self addDropUpRefresh];
    
}

#pragma mark --刷新
- (void)addDropDownRefresh{

      MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
          
          _page = 1;
          [_dataArr removeAllObjects];
          [_buttonArr removeAllObjects];
          [self setMyUrl];
          
          [self loadButtonData];
          [self loadData];
          
      }];

    NSArray * array = @[[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"]];
    [header setImages:array forState:MJRefreshStateRefreshing];
    
    _tableView.header = header;

}


- (void)addDropUpRefresh{
    
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
         _page++;
         [self setMyUrl];
         [self loadData];
         
     }];
    NSArray * array = @[[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"]];
    [footer setImages:array forState:MJRefreshStateRefreshing];
    
    _tableView.footer = footer;

}
#pragma mark --创建头视图
- (void)createHeadView{
    self.topScroll.choose = self.choose;
    [self.topScroll loadDataFromArray:_dataArr];
    _tableView.tableHeaderView = self.topScroll;

}
#pragma mark 按钮切换视图

- (UIView *)createSectionHeadView{

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    view.backgroundColor = [UIColor whiteColor];
    if (_buttonArr.count >0) {
        for (int i =0; i<_buttonArr.count; i++) {
            ButtonOnHeadView * btn = [[ButtonOnHeadView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/_buttonArr.count * i, 0, SCREEN_WIDTH /_buttonArr.count, 60)];
            btn.tag = 2000+i;
            HeadButtonModel * model = _buttonArr[i];
            [btn loadDataFromModel:model];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:btn];
        }

    }
    
    return view;
}


#pragma mark TableView 的代理 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    //加入防止下拉刷新崩溃限制
   
    if (_dataArr.count <=0 || indexPath.row >=_dataArr.count -3) {
        return [[UITableViewCell alloc]init];
    }
       
        NewsCellModel * model = _dataArr[indexPath.row +3];
        if (model.duration != nil) {
            
            AVTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"avCell"];
            [cell loadAvFromModel:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
             return cell;
        }else if ([model.picCover rangeOfString:@";"].location != NSNotFound){
            PicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"picCell"];
            [cell loadDataFromModel:model];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             return cell;
        }else{
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BASE" forIndexPath:indexPath];
           [cell loadDataFromModel:model];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }



}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [self createSectionHeadView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (_buttonArr.count <=0) {
        return 0;
    }
    
    return 60;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArr.count <=0 || indexPath.row >=_dataArr.count -3){
        return 0;
      }
    NewsCellModel * model = _dataArr[indexPath.row +3];
    if (model.duration !=nil) {
    
        return 201;
    }else if ([model.picCover rangeOfString:@";"].location != NSNotFound){
        
        return 180;
    }else{
    
        return 80;
    }

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCellModel * model = _dataArr[indexPath.row +3];
    
    if (model.mp4Link !=nil) {
        AVTableViewCell * cell = (AVTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
        cell.IV.hidden =YES;
        self.player.view.frame = cell.View.frame;
        self.player.contentURL = [NSURL URLWithString:model.mp4Link];
        [cell.View addSubview:self.player.view];
        [self.player play];
        
    }else{
    
        NewsDetailViewController * detail = [[NewsDetailViewController alloc]init];
        detail.NewsID = model.newsId;
        detail.choose = self.choose;
        detail.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:detail animated:YES];
    
    }
    
    
    
}

#pragma mark --scrollview的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
   NSArray * array = [_tableView indexPathsForVisibleRows];
    
    for (NSIndexPath * indexpath in array) {
        
        if (_dataArr.count <=0 || indexpath.row >=_dataArr.count -3) {
            return;
        }
        
        NewsCellModel * model = _dataArr[indexpath.row +3];
        if (model.duration != nil) {
            
            AVTableViewCell * cell = (AVTableViewCell *)[_tableView cellForRowAtIndexPath:indexpath];
            CGRect rectInTableView = [_tableView rectForRowAtIndexPath:indexpath];
            CGRect rect = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
            
//            
//            float y = rect.origin.y;
////            float height = rect.size.height;
//            NSLog(@"y::%f",y);
//            NSLog(@"table:%f",_tableView.frame.size.height);
////            NSLog(@"%f",height);
            
 
            if (rect.origin.y < -cell.frame.size.height ||rect.origin.y > _tableView.frame.size.height -30) {
                cell.IV.hidden = NO;
                [self.player stop];
//                [self.player.view removeFromSuperview];
            }
            
            
            
}}}


#pragma mark --buttonAction
- (void)btnClicked:(UIButton *)btn{
    if (_buttonArr.count <=0) {
        return;
    }
    NewsDetailViewController * detail = [[NewsDetailViewController alloc]init];
    detail.hidesBottomBarWhenPushed =YES;
    NSInteger index = btn.tag - 2000;
    HeadButtonModel * model = _buttonArr[index];
    detail.name = model.title;
    detail.choose = self.choose;
    if (index ==0) {
        detail.path = LOAN_BUTTON_DETAIL;
    }else if (index ==1){
    
        detail.path = SALES_BUTTON_DETAIL;
       
    }else if (index ==2){
    
        detail.path = FLOORPRICE_BUTTON_DETAIL;
    }else{
    
        detail.path = USED_BUTTON_DETAIL;
    }
    
    [self.navigationController pushViewController:detail animated:YES];

}


#pragma mark --topScrollView 懒加载

-(TopScrollView *)topScroll{

    if (!_topScroll) {
        _topScroll = [[TopScrollView alloc]initWithFrame:CGRectMake(0, -200, SCREEN_WIDTH, 200)];
        
    }
    return _topScroll;
}

#pragma mark ---createPlayer
- (MPMoviePlayerController *)player{
    
    if (!_player) {
        _player = [[MPMoviePlayerController alloc]init];
    
        //    播放界面的适配
        _player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //    根据俯视图大小变化 自由的宽 高

    }
    
    return _player;
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
