//
//  PreferenceModel.m
//  GoEat
//
//  Created by Zifan Shi on 12/7/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import "PreferenceModel.h"

@interface PreferenceModel()
@property NSMutableArray* preferences;
@property NSString* filepath;
@end

@implementation PreferenceModel

+ (instancetype) sharedModel {
    static PreferenceModel* _sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken,^ {
        _sharedModel = [[self alloc] init];
    });
    
    if (_sharedModel == nil) {
        _sharedModel = [[self alloc] init];
    }
    
    return _sharedModel;
}

- (instancetype) init {
    self = [super init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = paths[0];
    NSLog(@"docDir = %@", documentsDirectory);
    
    self.filepath = [documentsDirectory stringByAppendingPathComponent:@"preferences.plist"];
    NSLog(@"filepath = %@", self.filepath);
    
    NSMutableArray *preferences = [NSMutableArray arrayWithContentsOfFile:self.filepath];
    
    if (!preferences) {
        _preferences = [[NSMutableArray alloc] init];
        _preferences = [NSMutableArray arrayWithObjects:@"food",nil];
    } else {
        _preferences = [[NSMutableArray alloc] init];
        
        for (NSString* pref in preferences) {
            [_preferences addObject:pref];
        }
    }
    
    return self;
}

- (NSUInteger) numberOfPreference {
    return [_preferences count];
}

- (NSString*) preferenceAtIndex: (NSUInteger) index {
    return [_preferences objectAtIndex:index];
}

- (void) addPreference: (NSString *) preference {
    [_preferences addObject:preference];
    [self save];
}

- (void) addPreference: (NSString *) preference
               atIndex: (NSUInteger) index {
    NSUInteger num = [_preferences count];
    if (index <= num) {
        [_preferences insertObject:preference atIndex:index];
    } else {
        NSLog(@"ERROR OUT OF BOUND");
    }
    [self save];
}
- (void) removePreference {
    [_preferences removeLastObject];
    [self save];
}

- (void) removePreferenceAtIndex: (NSUInteger) index {
    NSUInteger num = [_preferences count];
    if (index < num) {
        [_preferences removeObjectAtIndex:index];
    } else {
        NSLog(@"ERROR OUT OF BOUND");
    }
    
    [self save];
}

- (void) save {
    NSMutableArray *preferences = [[NSMutableArray alloc] init];
    
    for (NSString *pref in self.preferences) {
        [preferences addObject:pref];
    }
    
    [preferences writeToFile:self.filepath atomically:YES];
}



@end
