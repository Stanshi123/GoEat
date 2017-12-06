//
//  YelpClientPrivate.h
//  GoEat
//
//  Created by Zifan Shi on 12/5/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import "YelpClient.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kYelpErrorDomain;

@interface YelpClient ()

- (instancetype)initWithAccessToken:(NSString *)accessToken;

- (NSURLRequest *)requestWithPath:(NSString *)path;
- (NSURLRequest *)requestWithPath:(NSString *)path params:(nullable NSDictionary *)params;
- (void)queryWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSDictionary *responseDict, NSError *error))completionHandler;

+ (NSCharacterSet *)URLEncodeAllowedCharacters;
+ (NSURLRequest *)authRequestWithAppId:(NSString *)appId secret:(NSString *)secret;

@end

NS_ASSUME_NONNULL_END
