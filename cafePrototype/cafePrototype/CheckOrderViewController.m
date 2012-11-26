//
//  CheckOrderViewController.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 22.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "CheckOrderViewController.h"

@interface CheckOrderViewController ()

@end

@implementation CheckOrderViewController

@synthesize myApp, textName, textPhone, textAddress, textAdditions, lblName, lblPhone, lblAddress, lblAdditions;

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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ((myApp.loggedIn) && (myApp.user)) {
    	self.textName.text = myApp.user.name;
    	self.textPhone.text = myApp.user.phone;
    	self.textAddress.text = myApp.user.address;
    } else {
    	self.textName.text = [userDefaults objectForKey:@"name"];
    	self.textPhone.text = [userDefaults objectForKey:@"phone"];
    	self.textAddress.text = [userDefaults objectForKey:@"address"];
    }
    
    if ([myApp.orderItems count] > 0)
	if ([[ServerAPI sharedServer] isRussian]) {
	    lblName.text = @"Имя";
	    lblPhone.text = @"Телефон";
	    lblAddress.text = @"Адрес";
	    lblAdditions.text = @"Пожелание";
	    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Заказать" style:UIBarButtonItemStyleBordered target:self action:@selector(checkOrder:)];
	} else if ([[ServerAPI sharedServer] isEspanian]) {
	    lblName.text = @"Nombre";
	    lblPhone.text = @"Teléfono";
	    lblAddress.text = @"Dirección";
	    lblAdditions.text = @"Deseos";
	    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Orden" style:UIBarButtonItemStyleBordered target:self action:@selector(checkOrder:)];	    
	} else {
	    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(checkOrder:)];	    
	}
}

- (void)viewDidUnload
{
    [self setTextName:nil];
    [self setTextPhone:nil];
    [self setTextAdditions:nil];
    [self setTextAddress:nil];
    [self setLblName:nil];
    [self setLblPhone:nil];
    [self setLblAddress:nil];
    [self setLblAdditions:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL) validateForm {
    BOOL result = YES;

    textName.text = [textName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];    
    if (textName.text.length == 0) {
	textName.backgroundColor = [UIColor redColor];
	result = NO;
    }

    textAddress.text = [textAddress.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (textAddress.text.length == 0) {
	textAddress.backgroundColor = [UIColor redColor];
	result = NO;
    }

    textPhone.text = [textPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (textPhone.text.length == 0) {
	textPhone.backgroundColor = [UIColor redColor];
	result = NO;
    }

    return result;
}

- (void) checkOrder: (id) sender
{
    if ([self validateForm]) {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject: textName.text forKey: @"name"];
	[userDefaults setObject: textPhone.text forKey: @"phone"];
	[userDefaults setObject: textAddress.text forKey: @"address"];
	[userDefaults synchronize];
	
	[[ServerAPI sharedServer] checkOrder: myApp.currentOrder.identifier.intValue withName:self.textName.text withPhone: self.textPhone.text withAddress: self.textAddress.text withAdditions: self.textAdditions.text delegate: self];
    }
}

- (IBAction)whiteBG: (UITextField *)sender {
    sender.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Delegate
- (void) didFinishPosting: (NSString *) response {
    NSLog(@"RESPONSE Objects: %@", response);
    NSDictionary * objects = [[[RKParserRegistry sharedRegistry] parserForMIMEType: RKMIMETypeJSON] objectFromString: response error:nil];
    myApp.orderChecked = YES;
    if ([[ServerAPI sharedServer] isRussian]) {
    	[[ServerAPI sharedServer] alertWindow: @"Ваш заказ принят! В самое ближайшее время с Вами свяжется наш оператор. Спасибо за заказ!"];
    } else if ([[ServerAPI sharedServer] isEspanian]) {
    	[[ServerAPI sharedServer] alertWindow: @"Su pedido es aceptado! Tan pronto como usted ponerse en contacto con nuestro operador. Gracias por su pedido!"];
    } else {
    	[[ServerAPI sharedServer] alertWindow: @"Your order is accepted! As soon as you contact our operator. Thank you for your order!"];
    }
    [myApp.navigationController popViewControllerAnimated: YES];
}

@end
