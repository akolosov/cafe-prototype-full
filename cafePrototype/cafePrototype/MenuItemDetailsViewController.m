//
//  ItemDetailsViewController.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 18.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "MenuItemDetailsViewController.h"
#import "ServerAPI.h"

@interface MenuItemDetailsViewController ()

@end

@implementation MenuItemDetailsViewController
@synthesize plusButton;
@synthesize minusButton;

@synthesize summLabel, itemImage, nameLabel, descrLabel, myApp, count, priceLabel, actionButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myApp = [[UIApplication sharedApplication] delegate];
    
    itemImage.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: [NSString stringWithFormat: @"%@/assets/%@", [[[RKObjectManager sharedManager] baseURL] absoluteString], myApp.currentMenuItem.photo]]]];
    nameLabel.text = myApp.currentMenuItem.name;
    descrLabel.text = myApp.currentMenuItem.description;

    NSLog(@"%@: 0x%x", [actionButton class], actionButton);

    if ([[ServerAPI sharedServer] isRussian]) {
    	priceLabel.text = [NSString stringWithFormat: @"Цена: %.2f", myApp.currentMenuItem.cost.floatValue];
    	summLabel.text = [NSString stringWithFormat: @"Сумма: %.2f", myApp.currentMenuItem.cost.floatValue*[count.text integerValue]];
	[actionButton setTitle: @"Добавить в заказ" forState: UIControlStateNormal];
    } else if ([[ServerAPI sharedServer] isEspanian]) {
    	priceLabel.text = [NSString stringWithFormat: @"Precios: %.2f", myApp.currentMenuItem.cost.floatValue];
    	summLabel.text = [NSString stringWithFormat: @"Suma: %.2f", myApp.currentMenuItem.cost.floatValue*[count.text integerValue]];
	[actionButton setTitle: @"Añadir al pedido" forState: UIControlStateNormal];
    } else {
    	priceLabel.text = [NSString stringWithFormat: @"Price: %.2f", myApp.currentMenuItem.cost.floatValue];
    	summLabel.text = [NSString stringWithFormat: @"Summ: %.2f", myApp.currentMenuItem.cost.floatValue*[count.text integerValue]];	
	[actionButton setTitle: @"Add to order" forState: UIControlStateNormal];
    }
    [actionButton useGreenConfirmStyle];
    [minusButton useRedDeleteStyle];
    [plusButton useRedDeleteStyle];
}

- (void)viewDidUnload
{
    [self setItemImage:nil];
    [self setNameLabel:nil];
    [self setDescrLabel:nil];
    [self setPriceLabel:nil];
    [self setCount:nil];
    [self setSummLabel:nil];
    [self setActionButton:nil];
    [self setMinusButton:nil];
    [self setPlusButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) valueChanged: (UIStepper *) sender {
    [count setText: [NSString stringWithFormat:@"%d", (int)[sender value]]];
}

- (IBAction) minusPressed: (id) sender {
    int currentCount = [count.text integerValue];
    
    if (currentCount > 0) {
	currentCount--;
    }
    [count setText: [NSString stringWithFormat:@"%d", currentCount]];
    
    if ([[ServerAPI sharedServer] isRussian]) {
    	summLabel.text = [NSString stringWithFormat: @"Сумма: %.2f", myApp.currentMenuItem.cost.floatValue*[count.text integerValue]];
    } else if ([[ServerAPI sharedServer] isEspanian]) {
    	summLabel.text = [NSString stringWithFormat: @"Suma: %.2f", myApp.currentMenuItem.cost.floatValue*[count.text integerValue]];
    } else {
    	summLabel.text = [NSString stringWithFormat: @"Summ: %.2f", myApp.currentMenuItem.cost.floatValue*[count.text integerValue]];	
    }
}

- (IBAction) plusPressed: (id) sender {
    int currentCount = [count.text integerValue];
    
    if (currentCount < 1000) {
	currentCount++;
    }
    [count setText: [NSString stringWithFormat:@"%d", currentCount]];
    
    if ([[ServerAPI sharedServer] isRussian]) {
    	summLabel.text = [NSString stringWithFormat: @"Сумма: %.2f", myApp.currentMenuItem.cost.floatValue*[count.text integerValue]];
    } else if ([[ServerAPI sharedServer] isEspanian]) {
    	summLabel.text = [NSString stringWithFormat: @"Suma: %.2f", myApp.currentMenuItem.cost.floatValue*[count.text integerValue]];
    } else {
    	summLabel.text = [NSString stringWithFormat: @"Summ: %.2f", myApp.currentMenuItem.cost.floatValue*[count.text integerValue]];	
    }
}

- (IBAction) addToOrder: (id) sender {
    if (!myApp.currentOrder) {
	[[ServerAPI sharedServer] getCurrentOrderHeader: self];
    } else {
	[[ServerAPI sharedServer] putOrderItem: myApp.currentOrder.identifier.intValue menuItem: myApp.currentMenuItem.identifier.intValue count: [count.text integerValue] delegate: self];
    }
}

#pragma mark - Delegate
- (void) didFinishLoading: (NSArray *) objects {
    if (!myApp.currentOrder) {
	myApp.currentOrder = [objects objectAtIndex: 0];

	[[ServerAPI sharedServer] putOrderItem: myApp.currentOrder.identifier.intValue menuItem: myApp.currentMenuItem.identifier.intValue count: [count.text integerValue] delegate: self];
    } else {
	[myApp.navigationController popViewControllerAnimated: YES];
    }
}

@end
