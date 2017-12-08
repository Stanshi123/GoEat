//
//  MapViewController.m
//  GoEat
//
//  Created by Zifan Shi on 12/7/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import "MapViewController.h"
#import "MapAnnotation.h"
#import "MapAnnotationView.h"
#import "BusinessModel.h"

@interface MapViewController ()
@property (strong, nonatomic) BusinessModel *dataModel;
@property (strong, nonatomic) NSMutableArray *annotations;
@property CLLocationManager* locationManager;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
    _dataModel = [BusinessModel sharedModel];
    _annotations = [[NSMutableArray alloc] init];
    [self displayAnnotation];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // Don't create annotation views for the user location annotation
    if ([annotation isKindOfClass:[MapAnnotation class]])
    {
        static NSString *myAnnotationId = @"myAnnotation";
        
        // Create an annotation view, but reuse a cached one if available
        MapAnnotationView *annotationView =
        (MapAnnotationView *)[self.mapView
                             dequeueReusableAnnotationViewWithIdentifier:myAnnotationId];
        if(annotationView)
        {
            // Cached view found, associate it with the annotation
            annotationView.annotation = annotation;
        }
        else
        {
            // No cached view were available, create a new one
            annotationView = [[MapAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:myAnnotationId];
        }
        return annotationView;
    }
    // Use a default annotation view for the user location annotation
    return nil;
}

- (void) displayAnnotation{
    NSLog(@"Display tabbed!");
    [_annotations removeAllObjects];
    for (YLPBusiness *b in [_dataModel allBusinesses]) {
        if (b.location.coordinate != nil) {
            double longitude = b.location.coordinate.longitude;
            double latitude = b.location.coordinate.latitude;
            MapAnnotation *ann = [[MapAnnotation alloc]
                                  initWithCoordinate: CLLocationCoordinate2DMake(latitude, longitude)
                                  title: b.name];
            [_annotations addObject:ann];
        }
    }
    
    [self.mapView addAnnotations:_annotations];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                        message:@"Can't find your location"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle: @"OK"
                                                       style: UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         NSLog(@"OK button pressed");
                                                     }];
    [errorAlert addAction:okAction];
    [self presentViewController:errorAlert
                       animated:YES
                     completion:^(){
                         NSLog(@"presentViewController completion");
                     }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        double latitude = currentLocation.coordinate.latitude;
        double longitude = currentLocation.coordinate.longitude;
        
        MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(latitude, longitude), MKCoordinateSpanMake(0.1, 0.1));
        [_mapView setRegion:region animated:true];
        [self displayAnnotation];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
