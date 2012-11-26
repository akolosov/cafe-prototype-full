//
//  GroupItemsViewController.h
//  cafePrototype
//
//  Created by Alexey Kolosov on 17.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerAPI.h"
#import "AppDelegate.h"

@interface GroupItemsViewController : UITableViewController

@property (nonatomic, strong) NSArray * loadedObjects;
@property (nonatomic, strong) AppDelegate * myApp;

@end
