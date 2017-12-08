//
//  MapAnnotation.m
//  GoEat
//
//  Created by Zifan Shi on 12/7/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord title:(NSString *)title
{
    self = [super init];
    if (self)
    {
        self.coordinate = coord;
        self.title = title;
    }
    return self;
}
@end
