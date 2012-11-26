//
//  LoginViewController.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 21.05.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

- (BOOL) isLoginCorrectly: (NSString *) login;

@end

@implementation LoginViewController

@synthesize txtEmail, myApp, txtPassword, lblEmail, lblPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.myApp = [[UIApplication sharedApplication] delegate];
    
    if ([[ServerAPI sharedServer] isRussian]) {
	lblPassword.text = @"Пароль";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Войти" style:UIBarButtonItemStyleBordered target:self action:@selector(loginUser:)];
    } else if ([[ServerAPI sharedServer] isEspanian]) {
	lblPassword.text = @"Сontraseña";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Iniciar sesión" style:UIBarButtonItemStyleBordered target:self action:@selector(loginUser:)];	    
    } else {
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStyleBordered target:self action:@selector(loginUser:)];	    
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.txtEmail.text = [userDefaults objectForKey:@"userEmail"];
    self.txtPassword.text = [userDefaults objectForKey:@"userPassword"];

}

- (void)viewDidUnload
{
    [self setLblEmail:nil];
    [self setLblPassword:nil];
    [self setTxtEmail:nil];
    [self setTxtPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL) isLoginCorrectly: (NSString *) login
{
    NSString *regEx = @"[0-9a-z@.]+"; //перечень допустимых символов
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [regExPredicate evaluateWithObject:[login lowercaseString]];
}

- (BOOL) validateForm {
    txtEmail.text = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    return [self isLoginCorrectly: txtEmail.text];
}

- (void) loginUser: (id) sender
{
    if ([self validateForm])
	[[ServerAPI sharedServer] userLogin: txtEmail.text withPassword: txtPassword.text delegate: self];
    else 
	if ([[ServerAPI sharedServer] isRussian]) {
	    [[ServerAPI sharedServer] alertWindow: @"Ошибка входа!" ];
	} else if ([[ServerAPI sharedServer] isEspanian]) {
	    [[ServerAPI sharedServer] alertWindow: @"No se pudo entrar!" ];
	} else {
	    [[ServerAPI sharedServer] alertWindow: @"Login failed!" ];
	}	
}

#pragma mark - Delegate
- (void) didFinishPosting: (NSString *) response {
    NSLog(@"RESPONSE Objects: %@", response);
    NSDictionary * objects = [[[RKParserRegistry sharedRegistry] parserForMIMEType: RKMIMETypeJSON] objectFromString: response error: nil];

    if ((objects) && ([[objects objectForKey: @"result"] isEqualToString: @"ok"])) {
	[[ServerAPI sharedServer] getCurrentUser: self];

	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject: txtEmail.text forKey: @"userEmail"];
	[userDefaults setObject: txtPassword.text forKey: @"userPassword"];
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

#pragma mark - Delegate
- (void) didFinishLoading: (NSArray *) objects {
    if ([objects count] > 0) {
	myApp.user = [objects objectAtIndex: 0];
	if (myApp.user.email) {
	    if ([[ServerAPI sharedServer] isRussian]) {
		[SVProgressHUD showSuccessWithStatus: @"Успешный вход!"];
	    } else if ([[ServerAPI sharedServer] isEspanian]) {
		[SVProgressHUD showSuccessWithStatus: @"Haber entrado!"];
	    } else {
		[SVProgressHUD showSuccessWithStatus: @"Successfully login!"];	    
	    }
	    myApp.loggedIn = YES;
	    myApp.currentOrder = nil;
	    myApp.currentOrderItem = nil;
	    myApp.orderSumm = nil;
	    myApp.orderItems = nil;

	    [myApp.navigationController popViewControllerAnimated: YES];
	}
    }
}

@end
