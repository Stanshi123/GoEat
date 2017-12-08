//
//  BusinessModel.m
//  
//
//  Created by Zifan Shi on 12/7/17.
//

#import "BusinessModel.h"
#import "PreferenceModel.h"

@interface BusinessModel()
@property NSMutableArray* businesses;
@property double longitude;
@property double latitude;
@property (nonatomic) YLPSearch *search;
@property PreferenceModel *dataModel;
@end

@implementation BusinessModel
+ (instancetype) sharedModel {
    static BusinessModel* _sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken,^ {
        _sharedModel = [[self alloc] init];
    });
    
    if (_sharedModel == nil) {
        _sharedModel = [[self alloc] init];
    }
    NSLog(@"Shared Model init...");
    return _sharedModel;
}

- (instancetype)init {
    
    _businesses = [[NSMutableArray alloc] init];
    
    [self searchWithCoordinateWithLatitude:34.0224
                                 longitude:-118.2851];
    
    _dataModel = [PreferenceModel sharedModel];
    NSLog(@"Number of business in model: %lu", (unsigned long)[_businesses count ]);
    return self;
}


- (NSUInteger) numberOfBusiness {
    return [_businesses count];
}

- (YLPBusiness*) businessAtIndex: (NSUInteger) index {
    if (index < [_businesses count]) {
        return [_businesses objectAtIndex:index];
    } else return nil;
}

- (void) searchWithCoordinateWithLatitude: (double) latitude
                                longitude: (double) longitude {
    YLPCoordinate *coordinate = [[YLPCoordinate alloc] initWithLatitude:latitude
                                                              longitude:longitude];
    
    NSString* searchTerm;
    if ([_dataModel numberOfPreference] <= 1) {
        searchTerm = @"food";
    } else {
        NSString *searchTerm2;
        NSUInteger randomIndex = arc4random_uniform((unsigned int)[_dataModel numberOfPreference]);
        searchTerm2 = [_dataModel preferenceAtIndex:randomIndex];
        searchTerm = [NSString stringWithFormat:@"food %@", searchTerm2];
    }
    [[AppDelegate sharedClient] searchWithCoordinate: coordinate term:searchTerm limit:20 offset:0 sort:YLPSortTypeDistance completionHandler:^
     (YLPSearch *search, NSError* error) {
         
         self.search = search;
         NSLog(@"Number of business: %lu", (unsigned long)[_search.businesses count ]);
         NSLog(@"Name of first: %@", _search.businesses[0].name);
         [_businesses removeAllObjects];
         [_businesses addObjectsFromArray:_search.businesses];
         
         /*
          dispatch_async(dispatch_get_main_queue(), ^{
          //[self.tableView reloadData];
          NSLog(@"we are here");
          [_businesses addObjectsFromArray: _search.businesses];
          });
          */
     }];
}
- (NSMutableArray *) allBusinesses {
    return _businesses;
}
@end
