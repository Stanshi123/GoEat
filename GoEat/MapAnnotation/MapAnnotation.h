//
//  MapAnnotation.h
//  GoEat
//
//  Created by Zifan Shi on 12/7/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : MKPointAnnotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord title:(NSString *)title;

@end
