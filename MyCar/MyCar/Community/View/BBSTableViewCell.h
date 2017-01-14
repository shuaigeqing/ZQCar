//
//  BBSTableViewCell.h
//  MyCar
//
//  Created by 🐵 on 16-5-26.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSModel.h"

@interface BBSTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *IV;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyCountLabel;

- (void)loadDataFromModel:(BBSModel *)model;

@end
