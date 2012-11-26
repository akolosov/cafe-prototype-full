//
//  LoginViewController.h
//  cafePrototype
//
//  Created by Alexey Kolosov on 21.05.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerAPI.h"
#import "AppDelegate.h"

@interface LoginViewController : UIViewController

@property (nonatomic, strong) AppDelegate * myApp;

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;

@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblPassword;

@end
