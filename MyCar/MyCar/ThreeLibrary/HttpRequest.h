//
//  HttpRequest.h
//  Travel
//
//  Created by 🐵 on 16-5-19.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

+ (void)startHttpRequestWithURL:(NSString *)url andParmenter:(NSDictionary *)parmeters andReturnBlock:(void(^)(NSData * data,NSError * error))block;

@end
