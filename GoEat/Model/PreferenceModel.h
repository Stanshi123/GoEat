//
//  PreferenceModel.h
//  GoEat
//
//  Created by Zifan Shi on 12/7/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreferenceModel : NSObject
// create the model
+ (instancetype) sharedModel;
// number of preferences
- (NSUInteger) numberOfPreference;
- (NSString*) preferenceAtIndex: (NSUInteger) index;
- (void) addPreference: (NSString *) preference;
- (void) addPreference: (NSString *) preference
               atIndex: (NSUInteger) index;
- (void) removePreference;
- (void) removePreferenceAtIndex: (NSUInteger) index;

@end
