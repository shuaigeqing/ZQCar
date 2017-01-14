//
//  ButtonOnHeadView.h
//  MyCar
//
//  Created by 🐵 on 16-5-22.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadButtonModel.h"

@interface ButtonOnHeadView : UIButton

@property (nonatomic,strong) UIImageView * ImageView;

@property (nonatomic,strong) UILabel * label;

- (void)loadDataFromModel:(HeadButtonModel *)model;

@end
