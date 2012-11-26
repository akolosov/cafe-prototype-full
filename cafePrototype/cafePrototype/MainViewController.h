//
//  MainViewController.h
//  cafePrototype
//
//  Created by Alexey Kolosov on 25.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestKit.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
 
@interface MainViewController : UIViewController <UITabBarDelegate, UINavigationBarDelegate>

@property (nonatomic, strong) NSArray * loadedObjects;
@property (nonatomic, strong) AppDelegate * myApp;
@property (nonatomic) BOOL changeOrder;

- (IBAction)aboutProgram:(id)sender;

@end
