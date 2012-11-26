//
//  OrderViewController.h
//  cafePrototype
//
//  Created by Alexey Kolosov on 15.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerAPI.h"
#import "AppDelegate.h"
#import "OrderItemCell.h"

@interface OrderViewController : UITableViewController

@property (nonatomic, strong) AppDelegate * myApp;
@property (nonatomic) BOOL changeIt;

@property (strong, nonatomic) IBOutlet OrderItemCell *itemCell;

@end
