//
//  YelpClient.h
//  GoEat
//
//  Created by Zifan Shi on 12/5/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kYelpAPIHost;

@interface YelpClient : NSObject

- (instancetype)init NS_UNAVAILABLE;

+ (void)authorizeWithAppId:(NSString *)appId
                    secret:(NSString *)secret
         completionHandler:(void (^)(YLPClient *_Nullable client, NSError *_Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
