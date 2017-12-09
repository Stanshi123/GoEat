//
//  GoEatViewController.m
//  GoEat
//
//  Created by Zifan Shi on 12/5/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import "GoEatViewController.h"
#import "BusinessModel.h"
#import "RestaurantViewController.h"

@interface GoEatViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *GoEatButton;
@property (strong, nonatomic) NSString *productURL;
@property (strong, nonatomic) BusinessModel *dataModel;
@property CLLocationManager* locationManager;
@end

@implementation GoEatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.productURL = @"";
    
    NSURL *url = [NSURL URLWithString:self.productURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
     [self.webView loadRequest: request];

    _dataModel = [BusinessModel sharedModel];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
}

- (IBAction)goEatTabbed:(id)sender {
    NSLog(@"Go Eat tabbed");
    
    NSUInteger randomIndex = arc4random_uniform(20);
    NSLog(@"Number of Business here: %lu", (unsigned long)[_dataModel numberOfBusiness]);
    if ([_dataModel businessAtIndex:randomIndex] != nil) {
        NSURL *url = [_dataModel businessAtIndex:randomIndex].URL;
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSString *path = [url absoluteString];
        NSLog(@"URL is: %@", path);
        
        if ([self.webView isLoading]){
            [self.webView stopLoading];
        }
        
        self.webView.UIDelegate = nil;
        
        [self.webView loadRequest: request];
        
    }
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
        [_dataModel searchWithCoordinateWithLatitude:latitude longitude:longitude];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    RestaurantViewController *rVC = [segue destinationViewController];
    [rVC.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
