//
//  AppDelegate.h
//  cafePrototype
//
//  Created by Alexey Kolosov on 25.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerAPI.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) MenuItem *currentMenuItem;
@property (strong, nonatomic) OrderItem *currentOrderItem;
@property (strong, nonatomic) Group *currentGroup;
@property (strong, nonatomic) Order *currentOrder;
@property (strong, nonatomic) GameCode *code;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *orderSumm;

@property (strong, nonatomic) NSMutableArray *menuGroups;
@property (strong, nonatomic) NSMutableArray *orderItems;

@property (nonatomic) BOOL orderChecked;
@property (nonatomic) BOOL loggedIn;

@end
