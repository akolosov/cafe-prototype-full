//
//  ItemDetailsViewController.h
//  cafePrototype
//
//  Created by Alexey Kolosov on 18.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerAPI.h"
#import "AppDelegate.h"
#import "GradientButton.h"

@interface MenuItemDetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *itemImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *descrLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *summLabel;
@property (strong, nonatomic) IBOutlet UITextField *count;
@property (strong, nonatomic) IBOutlet GradientButton *actionButton;
@property (strong, nonatomic) IBOutlet GradientButton *plusButton;
@property (strong, nonatomic) IBOutlet GradientButton *minusButton;

//@property (strong, nonatomic) MenuItem * menuItem;
@property (nonatomic, strong) AppDelegate * myApp;

- (IBAction)minusPressed:(id)sender;
- (IBAction)plusPressed:(id)sender;
- (IBAction)addToOrder:(id)sender;

@end
