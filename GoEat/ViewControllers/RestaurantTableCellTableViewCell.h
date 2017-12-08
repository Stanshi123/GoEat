//
//  RestaurantTableCellTableViewCell.h
//  GoEat
//
//  Created by Zifan Shi on 12/8/17.
//  Copyright © 2017 Zifan Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantTableCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@end
