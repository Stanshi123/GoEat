//
//  RestaurantViewController.m
//  GoEat
//
//  Created by Zifan Shi on 12/6/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import "RestaurantViewController.h"
#import "BusinessModel.h"
#import "RestaurantTableCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "RestaurantWebViewViewController.h"

@interface RestaurantViewController ()
@property (strong, nonatomic) BusinessModel *dataModel;
@end

@implementation RestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 100;
    self.dataModel = [BusinessModel sharedModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantTableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Restaurant Cell" forIndexPath:indexPath];
    
    if (indexPath.item > [_dataModel numberOfBusiness]) {
        cell.image.image = nil;
        cell.name.text = @"";
        cell.rating.text = @"";
        cell.categoryName.text = @"";
        
    }
    else {
        YLPBusiness *business = [_dataModel businessAtIndex:indexPath.row];
        cell.bussiness = business;
        //cell.textLabel.text = self.search.businesses[indexPath.item].name;
        [cell.image setImageWithURL:business.imageURL];
        cell.name.text = business.name;
        cell.rating.text = [NSString stringWithFormat:@"rating: %.f", business.rating];
        NSString* categories = @"";
        for (int i = 0; i < [business.categories count]; i++) {
            YLPCategory *cate = business.categories[i];
            categories = [categories stringByAppendingString:cate.name];
            if (i != [business.categories count] - 1) {
                categories = [categories stringByAppendingString:@", "];
            }
        }
        cell.categoryName.text = categories;
    }
    
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    RestaurantWebViewViewController *webVC = [segue destinationViewController];
    
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    RestaurantTableCellTableViewCell *selectedCell  = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
    webVC.url = selectedCell.bussiness.URL;
    
}


@end
