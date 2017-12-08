//
//  AppDelegate.h
//  GoEat
//
//  Created by Zifan Shi on 12/5/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

@import UIKit;
@import Foundation;

@import YelpAPI;

@class YLPClient;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (YLPClient*) sharedClient;

@end

