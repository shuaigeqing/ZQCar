//
//  HttpRequest.m
//  Travel
//
//  Created by 🐵 on 16-5-19.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest
+(void)startHttpRequestWithURL:(NSString *)url andParmenter:(NSDictionary *)parmeters andReturnBlock:(void (^)(NSData *, NSError *))block{

   AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parmeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject,nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);

    }];
    

}
@end
