//
//  BusinessModel.h
//  
//
//  Created by Zifan Shi on 12/7/17.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface BusinessModel : NSObject
// create the model
+ (instancetype) sharedModel;
// number of preferences
- (NSUInteger) numberOfBusiness;
- (YLPBusiness*) businessAtIndex: (NSUInteger) index;
- (void) searchWithCoordinateWithLatitude: (double) latitude
                                longitude: (double) longitude;
- (NSMutableArray *) allBusinesses;

@end
