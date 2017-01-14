//
//  BBSModel.h
//  MyCar
//
//  Created by 🐵 on 16-5-26.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBSModel : NSObject

@property (nonatomic,copy) NSString * postTitle;
@property (nonatomic,copy) NSString * postLink;
@property (nonatomic,copy) NSString * author;
@property (nonatomic,copy) NSString * forumName;
@property (nonatomic,assign) int viewCount;
@property (nonatomic,copy) NSString * postImage;
@property (nonatomic,assign) int replyCount;
@property (nonatomic,copy) NSString * createDate;

@end
