//
//  MapAnnotationView.m
//  GoEat
//
//  Created by Zifan Shi on 12/7/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import "MapAnnotationView.h"

@implementation MapAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImage *myImage = [UIImage imageNamed:@"mark.png"];
        self.image = myImage;
        self.frame = CGRectMake(0, 0, 40, 40);
        // Use contentMode to ensure best scaling of image
        self.contentMode = UIViewContentModeScaleAspectFill;
        // Use centerOffset to adjust the position of the image
        self.centerOffset = CGPointMake(0, -20);
        
        self.canShowCallout = YES;
        
        // Left callout accessory view
        UIImageView *leftAccessoryView = [[UIImageView alloc] initWithImage:myImage];
        leftAccessoryView.frame = CGRectMake(0, 0, 20, 20);
        leftAccessoryView.contentMode = UIViewContentModeScaleAspectFill;
        self.leftCalloutAccessoryView = leftAccessoryView;
        
        // Right callout accessory view
        self.rightCalloutAccessoryView =
        [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
