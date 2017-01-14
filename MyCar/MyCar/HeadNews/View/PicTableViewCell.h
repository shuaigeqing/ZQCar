//
//  PicTableViewCell.h
//  MyCar
//
//  Created by 🐵 on 16-5-23.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCellModel.h"

@interface PicTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *srcLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;

- (void)loadDataFromModel:(NewsCellModel *)model;

@end
