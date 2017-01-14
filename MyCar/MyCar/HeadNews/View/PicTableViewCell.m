//
//  PicTableViewCell.m
//  MyCar
//
//  Created by 🐵 on 16-5-23.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "PicTableViewCell.h"

@implementation PicTableViewCell

- (void)loadDataFromModel:(NewsCellModel *)model{
    
    float height = _scrollView.bounds.size.height;
    float width =_scrollView.bounds.size.width;
    
    NSArray * array = [model.picCover componentsSeparatedByString:@";"];
     _scrollView.contentSize = CGSizeMake((width/array.count +3)*array.count, height);
    _scrollView.bounces =NO;
    _scrollView.userInteractionEnabled = NO;
   
    for (int i =0; i < array.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((width/array.count +3) * i, 0,width/array.count , height)];
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:nil];
        [_scrollView addSubview:imageView];
    }
    if (model.src) {
        _srcLabel.text = model.src;
    }else{
        
        _srcLabel.text = model.mediaName;
    }

    _titleLabel.text = model.title;
    
    _countLabel.text = [NSString stringWithFormat:@"%d",model.commentCount];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
