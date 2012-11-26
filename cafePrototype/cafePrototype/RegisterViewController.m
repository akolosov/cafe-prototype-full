//
//  RegisterViewController.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 21.05.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "RegisterViewController.h"
#import "ServerAPI.h"

@interface RegisterViewController ()

- (BOOL) isLoginCorrectly: (NSString *) login;

@end

@implementation RegisterViewController

@synthesize myApp, txtEmail, txtPassword, txtConfirm, txtName, txtPhone, txtAddress, txtBirthday;
@synthesize lblEmail, lblPassword, lblConfirm, lblName, lblPhone, lblAddress, lblBirthday;

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
	lblName.text = @"Имя";
	lblPhone.text = @"Телефон";
	lblAddress.text = @"Адрес";
	lblPassword.text = @"Пароль";
	lblConfirm.text = @"Подтвердить";
	lblBirthday.text = @"День рождения";
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Регистрация" style:UIBarButtonItemStyleBordered target:self action:@selector(registerUser:)];
    } else if ([[ServerAPI sharedServer] isEspanian]) {
	lblName.text = @"Nombre";
	lblPhone.text = @"Teléfono";
	lblAddress.text = @"Dirección";
	lblPassword.text = @"Сontraseña";
	lblConfirm.text = @"Сonfirmar";
	lblBirthday.text = @"Сumpleaños";

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Registrar" style:UIBarButtonItemStyleBordered target:self action:@selector(registerUser:)];	    
    } else {
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Register" style:UIBarButtonItemStyleBordered target:self action:@selector(registerUser:)];	    
    }
}

- (void)viewDidUnload
{
    [self setTxtEmail:nil];
    [self setTxtPassword:nil];
    [self setTxtConfirm:nil];
    [self setTxtName:nil];
    [self setTxtPhone:nil];
    [self setTxtAddress:nil];
    [self setTxtBirthday:nil];
    [self setLblEmail:nil];
    [self setLblPassword:nil];
    [self setLblConfirm:nil];
    [self setLblName:nil];
    [self setLblPhone:nil];
    [self setLblAddress:nil];
    [self setLblBirthday:nil];
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
    BOOL result = YES;
    
    txtEmail.text = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    txtAddress.text = [txtAddress.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    txtName.text = [txtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    txtPhone.text = [txtPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (txtName.text.length == 0) {
	txtName.backgroundColor = [UIColor redColor];
	result = NO;
    }
    
    if ((txtEmail.text.length == 0) || (![self isLoginCorrectly: txtEmail.text])) {
	txtEmail.backgroundColor = [UIColor redColor];
	result = NO;
    }

    if (txtPassword.text.length == 0) {
	txtPassword.backgroundColor = [UIColor redColor];
	result = NO;
    }

    if (txtConfirm.text.length == 0) {
	txtConfirm.backgroundColor = [UIColor redColor];
	result = NO;
    }
    
    if (![txtPassword.text isEqualToString: txtConfirm.text]) {
	txtPassword.backgroundColor = [UIColor redColor];
	txtConfirm.backgroundColor = [UIColor redColor];
	result = NO;
    }
    
    return result;
}

- (void) registerUser: (id) sender
{
    if ([self validateForm]) {
    	[[ServerAPI sharedServer] userRegister: txtEmail.text withPassword: txtPassword.text passwordConfirm: txtConfirm.text withName:txtName.text withPhone:txtPhone.text withAddress:txtAddress.text withBirthday:txtBirthday.text delegate: self];
    }
}


- (IBAction)whiteBG:(UITextField *)sender {
    sender.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Delegate
- (void) didFinishPosting: (NSString *) response {
    NSLog(@"RESPONSE Objects: %@", response);
    NSDictionary * objects = [[[RKParserRegistry sharedRegistry] parserForMIMEType: RKMIMETypeJSON] objectFromString: response error:nil];

    if ((objects) && ([[objects objectForKey: @"result"] isEqualToString: @"ok"])) {    
	[[ServerAPI sharedServer] getCurrentUser: self];
	
    	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    	[userDefaults setObject: txtEmail.text forKey: @"userEmail"];
    	[userDefaults setObject: txtPassword.text forKey: @"userPassword"];
    	[userDefaults synchronize];
	myApp.loggedIn = YES;
	myApp.code = nil;
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
	    
	    [myApp.navigationController popViewControllerAnimated: YES];
	}
    }
}

@end
