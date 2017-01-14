//
//  HotTableViewCell.m
//  MyCar
//
//  Created by 🐵 on 16-5-26.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "HotTableViewCell.h"

@implementation HotTableViewCell

-(void)loadDataFromModel:(BBSModel *)model{

    _titleLabel.text =[NSString stringWithFormat:@"%@: %@",model.author,model.postTitle];
    
    NSInteger time = [model.createDate integerValue];
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSString * str = [NSString stringWithFormat:@"%@",date];
    
    _authorLabel.text = [str substringToIndex:10];
    _forumNameLabel.text =model.forumName;
    
    _viewCountLabel.text =[NSString stringWithFormat:@"%d",model.viewCount];
    
    

}

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = [UIColor colorWithRed:arc4random()%255/155.0 green:arc4random()%255/155.0 blue:arc4random()%255/155.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
