//
//  ServerAPI.m
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "ServerAPI.h"

static ServerAPI *sharedServer = nil;

@implementation ServerAPI

@synthesize delegate = _delegate;
@synthesize lang = _lang;

+ (ServerAPI *)sharedServer {
    return sharedServer;
}

+ (void)setSharedServer:(ServerAPI *)server {
    sharedServer = nil;
    sharedServer = server;
}

+ (ServerAPI *)serverWithBaseURL:(NSURL *)baseURL {
    ServerAPI *server = [[self alloc] initWithBaseServerURL:baseURL];
    return server;
}

- (id)initWithBaseServerURL:(NSURL *)baseURL {
    if (self = [super init]) {
        [RKObjectManager setSharedManager:[RKObjectManager objectManagerWithBaseURL:baseURL]];
        [RKObjectManager sharedManager].client.requestQueue.concurrentRequestsLimit = 2;
        [RKObjectManager sharedManager].client.requestQueue.requestTimeout = 10;
        [RKObjectManager sharedManager].client.requestQueue.suspended = YES;
        [RKObjectManager sharedManager].client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
        [RKObjectManager sharedManager].client.cachePolicy = RKRequestCachePolicyLoadIfOffline | RKRequestCachePolicyTimeout;
        [RKObjectManager sharedManager].client.requestCache.storagePolicy = RKRequestCacheStoragePolicyPermanently;

        [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:RKMIMETypeJSON];

        self.lang = [[NSLocale preferredLanguages] objectAtIndex:0]; // en es ru

        if (sharedServer == nil) {
            [ServerAPI setSharedServer:self];
            RKLogInitialize();
        }
#if DEBUG
    RKLogSetAppLoggingLevel(5);
#endif
    }
    return (self);
}

- (void)getGroupsList:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"groups"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[Group class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"photo" toAttribute:@"photo"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"groups"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getgroupslist/%@/json", self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"groups"] delegate:self];
}

- (void)getCurrentMenuHeaders:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"currentmenus"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[Menu class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"startdate" toAttribute:@"startdate"];
        [objectMapping mapKeyPath:@"enddate" toAttribute:@"enddate"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"currentmenus"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getcurrentmenuheaders/%@/json", self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"currentmenus"] delegate:self];
}

- (void)getMenuItems:(int)menu_id delegate:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"menuitems"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[MenuItem class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"menu_id" toAttribute:@"menuID"];
        [objectMapping mapKeyPath:@"group_id" toAttribute:@"groupID"];
        [objectMapping mapKeyPath:@"item_id" toAttribute:@"itemID"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"photo" toAttribute:@"photo"];
        [objectMapping mapKeyPath:@"cost" toAttribute:@"cost"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"menuitems"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getmenuitems/%d/locale/%@/json", menu_id, self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"menuitems"] delegate:self];
}

- (void)getCurrentMenuItems:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"menuitems"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[MenuItem class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"menu_id" toAttribute:@"menuID"];
        [objectMapping mapKeyPath:@"group_id" toAttribute:@"groupID"];
        [objectMapping mapKeyPath:@"item_id" toAttribute:@"itemID"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"photo" toAttribute:@"photo"];
        [objectMapping mapKeyPath:@"cost" toAttribute:@"cost"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"menuitems"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getcurrentmenuitems/%@/json", self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"menuitems"] delegate:self];
}

- (void)getMenuItem:(int)item_id delegate:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"menuitems"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[MenuItem class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"menu_id" toAttribute:@"menuID"];
        [objectMapping mapKeyPath:@"group_id" toAttribute:@"groupID"];
        [objectMapping mapKeyPath:@"item_id" toAttribute:@"itemID"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"photo" toAttribute:@"photo"];
        [objectMapping mapKeyPath:@"cost" toAttribute:@"cost"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"menuitems"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getmenuitem/%d/locale/%@/json", item_id, self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"menuitems"] delegate:self];
}

- (void)getMenuItems:(int)menu_id byGroup:(int)group_id delegate:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"menuitems"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[MenuItem class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"menu_id" toAttribute:@"menuID"];
        [objectMapping mapKeyPath:@"group_id" toAttribute:@"groupID"];
        [objectMapping mapKeyPath:@"item_id" toAttribute:@"itemID"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"photo" toAttribute:@"photo"];
        [objectMapping mapKeyPath:@"cost" toAttribute:@"cost"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"menuitems"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getmenuitems/%d/bygroup/%d/locale/%@/json", menu_id, group_id, self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"menuitems"] delegate:self];
}

- (void)getCurrentMenuItemsbyGroup:(int)group_id delegate:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"menuitems"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[MenuItem class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"menu_id" toAttribute:@"menuID"];
        [objectMapping mapKeyPath:@"group_id" toAttribute:@"groupID"];
        [objectMapping mapKeyPath:@"item_id" toAttribute:@"itemID"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"photo" toAttribute:@"photo"];
        [objectMapping mapKeyPath:@"cost" toAttribute:@"cost"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"menuitems"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getcurrentmenuitemsbygroup/%d/locale/%@/json", group_id, self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"menuitems"] delegate:self];
}

- (void)getMenuGroups:(int)menu_id delegate:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"groups"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[Group class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"photo" toAttribute:@"photo"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"groups"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getmenugroups/%d/locale/%@/json", menu_id, self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"groups"] delegate:self];
}

- (void)getCurrentMenuGroups:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"groups"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[Group class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"photo" toAttribute:@"photo"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"groups"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getcurrentmenugroups/%@/json", self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"groups"] delegate:self];
}

- (void)getCurrentUser:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"currentuser"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[User class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"email" toAttribute:@"email"];
        [objectMapping mapKeyPath:@"phone" toAttribute:@"phone"];
        [objectMapping mapKeyPath:@"address" toAttribute:@"address"];
        [objectMapping mapKeyPath:@"birthday" toAttribute:@"birthday"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"currentuser"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/main/getcurrentuser/json" objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"currentuser"] delegate:self];
}

- (void)getUserAccounts:(int)user_id delegate:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"useraccounts"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[UserAccount class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"user_id" toAttribute:@"userID"];
        [objectMapping mapKeyPath:@"bonus" toAttribute:@"bonus"];
        [objectMapping mapKeyPath:@"used" toAttribute:@"used"];
        [objectMapping mapKeyPath:@"expired_at" toAttribute:@"expireday"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"useraccounts"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getuseraccounts/%d/json", user_id] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"useraccounts"] delegate:self];
}

- (void)getItemProperties:(int)item_id delegate:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"itemproperties"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[ItemProperty class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"item_id" toAttribute:@"itemID"];
        [objectMapping mapKeyPath:@"itemname" toAttribute:@"itemName"];
        [objectMapping mapKeyPath:@"property_id" toAttribute:@"propertyID"];
        [objectMapping mapKeyPath:@"propertyname" toAttribute:@"propertyName"];
        [objectMapping mapKeyPath:@"value" toAttribute:@"value"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"itemproperties"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getitemproperties/%d/locale/%@/json", item_id, self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"itemproperties"] delegate:self];
}

- (void)getCurrentOrderHeader:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"currentorder"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[Order class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"user_id" toAttribute:@"userID"];
        [objectMapping mapKeyPath:@"session" toAttribute:@"session"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"phone" toAttribute:@"phone"];
        [objectMapping mapKeyPath:@"address" toAttribute:@"address"];
        [objectMapping mapKeyPath:@"status" toAttribute:@"status"];
        [objectMapping mapKeyPath:@"summ" toAttribute:@"summ"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"currentorder"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/main/getcurrentorderheader/json" objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"currentorder"] delegate:self];
}

- (void)getOrderItems:(int)order_id delegate:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"orderitems"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[OrderItem class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"order_id" toAttribute:@"orderID"];
        [objectMapping mapKeyPath:@"menu_item_id" toAttribute:@"itemID"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"photo" toAttribute:@"photo"];
        [objectMapping mapKeyPath:@"cost" toAttribute:@"cost"];
        [objectMapping mapKeyPath:@"count" toAttribute:@"count"];
        [objectMapping mapKeyPath:@"summ" toAttribute:@"summ"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"orderitems"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/getorderitems/%d/locale/%@/json", order_id, self.lang] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"orderitems"] delegate:self];
}

- (void)putOrderItem:(int)order_id menuItem:(int)item_id count:(int)count delegate:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"orderitems"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[OrderItem class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"order_id" toAttribute:@"orderID"];
        [objectMapping mapKeyPath:@"menu_item_id" toAttribute:@"itemID"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"photo" toAttribute:@"photo"];
        [objectMapping mapKeyPath:@"cost" toAttribute:@"cost"];
        [objectMapping mapKeyPath:@"count" toAttribute:@"count"];
        [objectMapping mapKeyPath:@"summ" toAttribute:@"summ"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"orderitems"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/putorderitem/%d/item/%d/count/%d/json", order_id, item_id, count] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"orderitems"] delegate:self];
}

- (void)checkOrder:(int)order_id withName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withAdditions:(NSString *)additions delegate:(id)delegate {

    RKParams *params = [RKParams params];

    [params setValue:name forParam:@"name"];
    [params setValue:phone forParam:@"phone"];
    [params setValue:address forParam:@"address"];
    [params setValue:additions forParam:@"additions"];

    self.delegate = delegate;

    [[RKObjectManager sharedManager].client post:[NSString stringWithFormat:@"/main/checkorder/%d/json", order_id] params:params delegate:self];
}

- (void)userRegister:(NSString *)email withPassword:(NSString *)password passwordConfirm:(NSString *)confirm withName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withBirthday:(NSString *)birthday delegate:(id)delegate {

    RKParams *params = [RKParams params];

    [params setValue:email forParam:@"email"];
    [params setValue:password forParam:@"password"];
    [params setValue:confirm forParam:@"password_confirmation"];
    [params setValue:name forParam:@"name"];
    [params setValue:phone forParam:@"phone"];
    [params setValue:address forParam:@"address"];
    [params setValue:birthday forParam:@"birthday"];

    self.delegate = delegate;

    [[RKObjectManager sharedManager].client post:@"/main/userregister/json" params:params delegate:self];
}

- (void)userLogin:(NSString *)email withPassword:(NSString *)password delegate:(id)delegate {
    RKParams *params = [RKParams params];
    
    [params setValue:email forParam:@"email"];
    [params setValue:password forParam:@"password"];
    
    self.delegate = delegate;
    
    [[RKObjectManager sharedManager].client post:@"/main/userlogin/json" params:params delegate:self];
}

- (void) getOrderSumm:(int) order_id delegate:(id)delegate {
    RKParams *params = [RKParams params];

    self.delegate = delegate;

    [[RKObjectManager sharedManager].client post: [NSString stringWithFormat:@"/main/getordersumm/%d/json", order_id] params:nil delegate:self];
}

- (void)userLogout:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"response"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[Response class]];
        [objectMapping mapKeyPath:@"user_id" toAttribute:@"identifier"]; // fake mapping
        [objectMapping mapKeyPath:@"user_id" toAttribute:@"userID"];
        [objectMapping mapKeyPath:@"session" toAttribute:@"session"];
        [objectMapping mapKeyPath:@"result" toAttribute:@"result"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"response"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/main/userlogout/json" objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"response"] delegate:self];
}

- (void)getCurrentSession:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"response"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[Response class]];
        [objectMapping mapKeyPath:@"user_id" toAttribute:@"identifier"]; // fake mapping
        [objectMapping mapKeyPath:@"user_id" toAttribute:@"userID"];
        [objectMapping mapKeyPath:@"session" toAttribute:@"session"];
        [objectMapping mapKeyPath:@"result" toAttribute:@"result"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"response"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/main/getcurrentsesion/json" objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"response"] delegate:self];
}

- (void)putUserBonus:(NSString *)code delegate:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"useraccounts"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[UserAccount class]];
        [objectMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [objectMapping mapKeyPath:@"user_id" toAttribute:@"userID"];
        [objectMapping mapKeyPath:@"bonus" toAttribute:@"bonus"];
        [objectMapping mapKeyPath:@"used" toAttribute:@"used"];
        [objectMapping mapKeyPath:@"expired_at" toAttribute:@"expireday"];

        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"useraccounts"];
    }

    self.delegate = delegate;

    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/main/putuserbonus/%@/json", code] objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"useraccounts"] delegate:self];
}

- (void)getRandomCode:(id)delegate {
    if (![[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"gamecodes"]) {
        RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[GameCode class]];
        [objectMapping mapKeyPath:@"one" toAttribute:@"one"];
        [objectMapping mapKeyPath:@"two" toAttribute:@"two"];
        [objectMapping mapKeyPath:@"three" toAttribute:@"three"];
	
        [[RKObjectManager sharedManager].mappingProvider setMapping:objectMapping forKeyPath:@"gamecodes"];
    }
    
    self.delegate = delegate;
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: @"/main/getrandomcode/json" objectMapping:(RKObjectMapping *) [[RKObjectManager sharedManager].mappingProvider mappingForKeyPath:@"gamecodes"] delegate:self];    
}

- (void) alertWindow: (NSString *) message {
    [[[UIAlertView alloc] initWithTitle:nil message: message
			       delegate:self
		      cancelButtonTitle:@"OK"
		      otherButtonTitles:nil] show];
    [SVProgressHUD dismiss];
}

- (BOOL) isRussian {
	return [self.lang isEqualToString: @"ru"];
}

- (BOOL) isEspanian {
    return [self.lang isEqualToString: @"es"];
}

#pragma mark - Delegate
- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    if ([request isGET]) {
        if ([response isOK]) {
            RKLogDebug(@"Retrieved OK: %@", [response bodyAsString]);
        }
        if ([response isJSON]) {
            RKLogDebug(@"Got a JSON response back from our GET!");
            if ([self.delegate respondsToSelector:@selector(didFinishGetting:)]) {
                [self.delegate didFinishGetting:[response bodyAsString]];
            }
        }
    } else if ([request isPOST]) {
        if ([response isOK]) {
            RKLogDebug(@"Posted OK: %@", [response bodyAsString]);
        }
        if ([response isJSON]) {
            RKLogDebug(@"Got a JSON response back from our POST!");
            if ([self.delegate respondsToSelector:@selector(didFinishPosting:)]) {
                [self.delegate didFinishPosting:[response bodyAsString]];
            }
        }
    } else if ([request isDELETE]) {
        if ([response isOK]) {
            RKLogDebug(@"Deleted OK: %@", [response bodyAsString]);
        }
        if ([response isNotFound]) {
            RKLogDebug(@"The resource path '%@' was not found.", [request resourcePath]);
        }
    }
}

#pragma mark - Delegate
- (void)request:(RKRequest *)request didReceivedData:(NSInteger)bytesReceived totalBytesReceived:(NSInteger)totalBytesReceived totalBytesExectedToReceive:(NSInteger)totalBytesExpectedToReceive {
    RKLogDebug(@"Request recieved data from %@, recieved %d bytes, total recieved %d bytes, expected %d bytes", [request resourcePath], bytesReceived, totalBytesReceived, totalBytesExpectedToReceive);
}

#pragma mark - Delegate
- (void)requestDidStartLoad:(RKRequest *)request {
    RKLogDebug(@"Request did start load - %@", [request resourcePath]);
}

#pragma mark - Delegate
- (void)requestDidCancelLoad:(RKRequest *)request {
    [self alertWindow: [NSString stringWithFormat:@"Request did cancel load - %@", [request resourcePath]]];
}

#pragma mark - Delegate
- (void)requestDidTimeout:(RKRequest *)request {
    [self alertWindow: [NSString stringWithFormat:@"Request did timeout - %@", [request resourcePath]]];
}

#pragma mark - Delegate
- (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error {

    if (request.method == RKRequestMethodGET) {
        [self alertWindow: [NSString stringWithFormat:@"GET: %@ - %@", [request resourcePath], error.localizedDescription]];
    } else if (request.method == RKRequestMethodPOST) {
        [self alertWindow: [NSString stringWithFormat:@"POST: %@ - %@", [request resourcePath], error.localizedDescription]];
    } else if (request.method == RKRequestMethodDELETE) {
        [self alertWindow: [NSString stringWithFormat:@"DELETE: %@ - %@", [request resourcePath], error.localizedDescription]];
    } else if (request.method == RKRequestMethodPUT) {
        [self alertWindow: [NSString stringWithFormat:@"PUT: %@ - %@", [request resourcePath], error.localizedDescription]];
    }
}

#pragma mark - Delegate
- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    RKLogDebug(@"Load collection: %@", objects);
}

#pragma mark - Delegate
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    [self alertWindow: error.localizedDescription];
}

#pragma mark - Delegate
- (void)objectLoaderDidFinishLoading:(RKObjectLoader *)objectLoader {
    RKLogDebug(@"Load collection with loader result: %@", [objectLoader.result asCollection]);

    if ([self.delegate respondsToSelector:@selector(didFinishLoading:)]) {
        [self.delegate didFinishLoading:[objectLoader.result asCollection]];
    }
}

@end
