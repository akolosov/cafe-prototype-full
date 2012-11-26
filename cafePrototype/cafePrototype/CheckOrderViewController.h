//
//  CheckOrderViewController.h
//  cafePrototype
//
//  Created by Alexey Kolosov on 22.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CheckOrderViewController : UIViewController

@property (nonatomic, strong) AppDelegate * myApp;

@property (strong, nonatomic) IBOutlet UITextField *textName;

@property (strong, nonatomic) IBOutlet UITextField *textPhone;

@property (strong, nonatomic) IBOutlet UITextField *textAddress;

@property (strong, nonatomic) IBOutlet UITextField *textAdditions;

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblAdditions;

- (IBAction)whiteBG:(UITextField *)sender;

@end
