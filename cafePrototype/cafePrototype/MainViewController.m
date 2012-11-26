//
//  MainViewController.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 25.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "MainViewController.h"
#import "MenuGroupViewController.h"
#import "OrderViewController.h"
// #import "GameViewController.h"
#import "ServerAPI.h"
#import "ZAction.h"
#import "ZFloatingManager.h"
#import "ZActionSheet.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AboutViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UITabBarItem *orderTab;
@property (strong, nonatomic) IBOutlet UITabBarItem *vipTab;
@property (strong, nonatomic) NSString *userEmail;
@property (strong, nonatomic) NSString *userPassword;

@end

@implementation MainViewController

@synthesize vipTab, orderTab, tabBar, loadedObjects, myApp, changeOrder, userEmail, userPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setCustomTitle {
    if (myApp.loggedIn) {
	if ([[ServerAPI sharedServer] isRussian]) {
	    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Выйти" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutUser:)];
	} else if ([[ServerAPI sharedServer] isEspanian]) {
	    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cierre" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutUser:)];
	} else {
	    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutUser:)];
	}

	self.title = myApp.user.email;
    } else {
//	if ([[ServerAPI sharedServer] isRussian]) {
//	    self.title = @"прототип";
//	} else if ([[ServerAPI sharedServer] isEspanian]) {
//	    self.title = @"prototipo";
//	} else {
//	    self.title = @"prototype";
//	}

	self.title = @"iTartarelka";

	self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    if ([[ServerAPI sharedServer] isRussian]) {
//	[[ServerAPI sharedServer] alertWindow: @"Данная версия программы является демонстрационной и все Ваши заказы не будут обработаны!"];
//    } else if ([[ServerAPI sharedServer] isEspanian]) {
//	[[ServerAPI sharedServer] alertWindow: @"Esta es una versión demo del programa y todas sus órdenes no serán procesados​​!"];
//    } else {
//	[[ServerAPI sharedServer] alertWindow: @"This is a demo version of the program and all your orders will not be processed!"];
//    }

    self.myApp = [[UIApplication sharedApplication] delegate];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    self.userEmail = [userDefaults objectForKey:@"userEmail"];
    self.userPassword = [userDefaults objectForKey:@"userPassword"];

    self.changeOrder = NO;

    self.tabBar.delegate = self;

    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"logo.png"]];
    
    if ((userEmail) && (userPassword) && (!myApp.loggedIn) && (!myApp.user)) {
	if ([[ServerAPI sharedServer] isRussian]) {
	    [SVProgressHUD showWithStatus: @"Загрузка..."];
	} else if ([[ServerAPI sharedServer] isEspanian]) {
	    [SVProgressHUD showWithStatus: @"Carga..."];
	} else {
	    [SVProgressHUD showWithStatus: @"Loading..."];	    
	}
	[[ServerAPI sharedServer] userLogin:userEmail withPassword:userPassword delegate:self];
    }
}


- (void)viewWillAppear: (BOOL) animated {
    [super viewWillAppear: animated];

    if (myApp.currentOrder) {
	self.changeOrder = YES;
	[[ServerAPI sharedServer] getOrderItems: myApp.currentOrder.identifier.intValue delegate: self];
    }

    if (myApp.code) {
	self.vipTab.enabled = NO;
    }
}

- (void)viewDidAppear: (BOOL) animated {
    [super viewDidAppear: animated];

    if ([myApp.orderItems count] > 0) {
	self.orderTab.badgeValue = [NSString stringWithFormat: @"%d", [myApp.orderItems count]];
    } else {
	self.orderTab.badgeValue = @"0";
    }

    [self setCustomTitle];    
    self.vipTab.enabled = !myApp.loggedIn;    
}

- (void)viewDidUnload
{
    [self setTabBar:nil];
    [self setOrderTab:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) activateTab: (int) index {    
    switch (index) {
	case 1:
	    [myApp.navigationController pushViewController: [[MenuGroupViewController alloc] initWithNibName: @"MenuGroupViewController" bundle: [NSBundle mainBundle]] animated: YES];
	    break;
	case 2:
	    [myApp.navigationController pushViewController: [[OrderViewController alloc] initWithNibName: @"OrderViewController" bundle: [NSBundle mainBundle]] animated: YES];
	    break;
	case 3:
	    if (myApp.loggedIn) {
//	    	[myApp.navigationController pushViewController: [[GameViewController alloc] initWithNibName: @"GameViewController" bundle: [NSBundle mainBundle]] animated: YES];
	    } else {
		if ([ZFloatingManager shouldFloatingWithIdentifierAppear:@"login"]) {
		    
		    ZAction *cancel = [ZAction actionWithTitle:@"Cancel" target:self action:nil object:nil];
		    ZAction *login = [ZAction actionWithTitle:@"Login.." target:self action:@selector(loginUser:) object:nil];
		    ZAction *regis = [ZAction actionWithTitle:@"Register..." target:self action:@selector(registerUser:) object:nil];

		    if ([[ServerAPI sharedServer] isRussian]) {
			[cancel setTitle: @"Отмена"];
			[login setTitle: @"Вход..."];
			[regis setTitle: @"Регистрация..."];
		    } else if ([[ServerAPI sharedServer] isEspanian]) {
			[cancel setTitle: @"Cancelar"];
			[login setTitle: @"Iniciar sesión..."];
			[regis setTitle: @"Registrar..."];
		    }

		    ZActionSheet *sheet = [[ZActionSheet alloc] initWithTitle:@"Authorize" cancelAction:cancel destructiveAction:nil otherActions:[NSArray arrayWithObjects:login, regis, nil]];

		    if ([[ServerAPI sharedServer] isRussian]) {
			[sheet setTitle: @"Авторизация"];
		    } else if ([[ServerAPI sharedServer] isEspanian]) {
			[sheet setTitle: @"Autorización"];
		    }		    
		
		    sheet.identifier = @"login";
		    [sheet showFromTabBar: tabBar];
		}
	    }
	    break;
	default:
	    break;
    }
}

- (void)logoutUser:(id)object
{
    [[ServerAPI sharedServer] userLogout: self];
}

- (void)loginUser:(id)object
{
    [myApp.navigationController pushViewController: [[LoginViewController alloc] initWithNibName: @"LoginViewController" bundle: [NSBundle mainBundle]] animated: YES];
}

- (void)registerUser:(id)object
{
    [myApp.navigationController pushViewController: [[RegisterViewController alloc] initWithNibName: @"RegisterViewController" bundle: [NSBundle mainBundle]] animated: YES];
}

- (void) tabBar: (UITabBar *) tabBar didSelectItem: (UITabBarItem *) item {
    [self activateTab: item.tag];   
}

- (IBAction)aboutProgram:(id)sender {
    [myApp.navigationController pushViewController: [[AboutViewController alloc] initWithNibName: @"AboutViewController" bundle: [NSBundle mainBundle]] animated: YES];
}

#pragma mark - Delegate
- (void) didFinishLoading: (NSArray *) objects {
    if (self.changeOrder) {
	self.changeOrder = NO;
	myApp.orderItems = [[NSMutableArray alloc] initWithArray: objects];
	self.orderTab.badgeValue = [NSString stringWithFormat: @"%d", [myApp.orderItems count]];
    } else {
	if (([objects count] > 0) && (!myApp.loggedIn)) {
	    myApp.user = [objects objectAtIndex: 0];
	    if (myApp.user.email) {
		if ([[ServerAPI sharedServer] isRussian]) {
		    [SVProgressHUD dismissWithSuccess: @"Успешный вход!"];
		} else if ([[ServerAPI sharedServer] isEspanian]) {
		    [SVProgressHUD dismissWithSuccess: @"Haber entrado!"];
		} else {
		    [SVProgressHUD dismissWithSuccess: @"Successfully login!"];	    
		}
		myApp.loggedIn = YES;
		self.vipTab.enabled = NO;    
	    }
	} else {
	    myApp.code = nil;
	    myApp.loggedIn = NO;
	    myApp.user = nil;
	    myApp.currentOrder = nil;
	    myApp.currentOrderItem = nil;
	    myApp.orderSumm = nil;
	    myApp.orderItems = nil;
	    self.vipTab.enabled = YES;
	}
    }
    [self setCustomTitle];
}

#pragma mark - Delegate
- (void) didFinishPosting: (NSString *) response {
    if (!myApp.loggedIn) {
	NSLog(@"RESPONSE Objects: %@", response);
	NSDictionary * objects = [[[RKParserRegistry sharedRegistry] parserForMIMEType: RKMIMETypeJSON] objectFromString: response error: nil];
	
	if ((objects) && ([[objects objectForKey: @"result"] isEqualToString: @"ok"])) {
	    [[ServerAPI sharedServer] getCurrentUser: self];
	    
	    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	    [userDefaults setObject: self.userEmail forKey: @"userEmail"];
	    [userDefaults setObject: self.userPassword forKey: @"userPassword"];
	    [userDefaults synchronize];
	} else {
	    if ([[ServerAPI sharedServer] isRussian]) {
		[[ServerAPI sharedServer] alertWindow: @"Ошибка входа!" ];
	    } else if ([[ServerAPI sharedServer] isEspanian]) {
		[[ServerAPI sharedServer] alertWindow: @"No se pudo entrar!" ];
	    } else {
		[[ServerAPI sharedServer] alertWindow: @"Login failed!" ];
	    }
	}
    }
}

@end
