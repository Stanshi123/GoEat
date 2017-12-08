//
//  PreferencesTableViewController.m
//  GoEat
//
//  Created by Zifan Shi on 12/6/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import "PreferencesTableViewController.h"
#import "PreferenceModel.h"

@interface PreferencesTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) PreferenceModel *dataModel;

@end

@implementation PreferencesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.dataModel = [PreferenceModel sharedModel];
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
    return [self.dataModel numberOfPreference];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"Food Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    // Configure the cell...
    NSString *tableCellText = [NSString stringWithFormat:@"%@",
                               [self.dataModel preferenceAtIndex:indexPath.row]];
    cell.textLabel.text = tableCellText;
    
    return cell;
}

- (IBAction)addPreference:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Food Preference" message:@"Please enter your preference" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"PreferencePlaceHolder", @"Preference");
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle: @"Cancel"
                                   style: UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action) {
                                       NSLog(@"Cancel button pressed");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle: @"OK"
                                   style: UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       NSLog(@"OK button pressed");
                                       NSString *preference = alertController.textFields.firstObject.text;
                                       [_dataModel addPreference:preference];
                                       [self.tableView reloadData];
                                   }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:^(){
                         NSLog(@"presentViewController completion");
                     }];
}




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.dataModel removePreferenceAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
