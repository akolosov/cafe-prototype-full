//
//  ServerAPI.h
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "RestKit.h"
#import "RKJSONParserJSONKit.h"
#import "Group.h"
#import "MenuItem.h"
#import "Menu.h"
#import "Order.h"
#import "OrderItem.h"
#import "ItemProperty.h"
#import "User.h"
#import "UserAccount.h"
#import "Response.h"
#import "GameCode.h"

@protocol ServerAPIDelegate <NSObject>

@optional

- (void)didFinishLoading:(NSArray *)objects;
- (void)didFinishGetting:(NSString *)response;
- (void)didFinishPosting:(NSString *)response;

@end

@interface ServerAPI : NSObject <RKRequestDelegate, RKObjectLoaderDelegate>

@property(nonatomic, strong) NSObject <ServerAPIDelegate> *delegate;
@property(nonatomic, strong) NSString *lang;


+ (ServerAPI *)sharedServer;

+ (void)setSharedServer:(ServerAPI *)server;

+ (ServerAPI *)serverWithBaseURL:(NSURL *)baseURL;

- (id)initWithBaseServerURL:(NSURL *)baseURL;

- (void)getGroupsList:(id)delegate;

- (void)getCurrentMenuHeaders:(id)delegate;

- (void)getMenuItem:(int)item_id delegate:(id)delegate;

- (void)getMenuItems:(int)menu_id delegate:(id)delegate;

- (void)getCurrentMenuItems:(id)delegate;

- (void)getMenuItems:(int)menu_id byGroup:(int)group_id delegate:(id)delegate;

- (void)getCurrentMenuItemsbyGroup:(int)group_id delegate:(id)delegate;

- (void)getMenuGroups:(int)menu_id delegate:(id)delegate;

- (void)getCurrentMenuGroups:(id)delegate;

- (void)getCurrentUser:(id)delegate;

- (void)getUserAccounts:(int)user_id delegate:(id)delegate;

- (void)getItemProperties:(int)item_id delegate:(id)delegate;

- (void)getCurrentOrderHeader:(id)delegate;

- (void)getOrderItems:(int)order_id delegate:(id)delegate;

- (void)getOrderSumm:(int)order_id delegate:(id)delegate;

- (void)putOrderItem:(int)order_id menuItem:(int)item_id count:(int)count delegate:(id)delegate;

- (void)checkOrder:(int)order_id withName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withAdditions:(NSString *)additions delegate:(id)delegate;

- (void)userRegister:(NSString *)email withPassword:(NSString *)password passwordConfirm:(NSString *)confirm withName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withBirthday:(NSString *)birthday delegate:(id)delegate;

- (void)userLogin:(NSString *)email withPassword:(NSString *)password delegate:(id)delegate;

- (void)userLogout:(id)delegate;

- (void)getCurrentSession:(id)delegate;

- (void)putUserBonus:(NSString *)code delegate:(id)delegate;

- (void)getRandomCode:(id)delegate;

- (void) alertWindow: (NSString *) message;

- (BOOL) isRussian;

- (BOOL) isEspanian;

// delegated
- (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error;

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error;

@end
