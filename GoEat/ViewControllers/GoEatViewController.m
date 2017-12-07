//
//  GoEatViewController.m
//  GoEat
//
//  Created by Zifan Shi on 12/5/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import "GoEatViewController.h"

@interface GoEatViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *GoEatButton;
@property (strong, nonatomic) NSString *productURL;
@end

@implementation GoEatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.productURL = @"https://www.google.com";
    
    NSURL *url = [NSURL URLWithString:self.productURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
     [self.webView loadRequest: request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
