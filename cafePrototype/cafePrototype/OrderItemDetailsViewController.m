//
//  ItemDetailsViewController.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 18.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "OrderItemDetailsViewController.h"
#import "ServerAPI.h"

@interface OrderItemDetailsViewController ()

@end

@implementation OrderItemDetailsViewController
@synthesize minusButton;
@synthesize plusButton;

@synthesize summLabel, itemImage, nameLabel, descrLabel, menuItem, myApp, count, priceLabel, actionButton;

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

    myApp = [[UIApplication sharedApplication] delegate];
    
    itemImage.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: [NSString stringWithFormat: @"%@/assets/%@", [[[RKObjectManager sharedManager] baseURL] absoluteString], myApp.currentOrderItem.photo]]]];
    nameLabel.text = myApp.currentOrderItem.name;
    descrLabel.text = myApp.currentOrderItem.description;
    
    NSLog(@"%@: 0x%x", [actionButton class], actionButton);
    
    if ([[ServerAPI sharedServer] isRussian]) {
    	priceLabel.text = [NSString stringWithFormat: @"Цена: %.2f", myApp.currentOrderItem.cost.floatValue];
    	summLabel.text = [NSString stringWithFormat: @"Сумма: %.2f", myApp.currentOrderItem.summ.floatValue];
	[actionButton setTitle: @"Изменить кол-во" forState: UIControlStateNormal];
    } else if ([[ServerAPI sharedServer] isEspanian]) {
    	priceLabel.text = [NSString stringWithFormat: @"Precios: %.2f", myApp.currentOrderItem.cost.floatValue];
    	summLabel.text = [NSString stringWithFormat: @"Suma: %.2f", myApp.currentOrderItem.summ.floatValue];
	[actionButton setTitle: @"Modificar el número de" forState: UIControlStateNormal];
    } else {
    	priceLabel.text = [NSString stringWithFormat: @"Price: %.2f", myApp.currentOrderItem.cost.floatValue];
    	summLabel.text = [NSString stringWithFormat: @"Summ: %.2f", myApp.currentOrderItem.summ.floatValue];
	[actionButton setTitle: @"Change count" forState: UIControlStateNormal];
    }
    count.text = [NSString stringWithFormat: @"%d", myApp.currentOrderItem.count.intValue];

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

- (IBAction)minusPressed:(id)sender {
    int currentCount = [count.text integerValue];
    
    if (currentCount > 0) {
	currentCount--;
    }
    [count setText: [NSString stringWithFormat:@"%d", currentCount]];
    
    if ([[ServerAPI sharedServer] isRussian]) {
    	summLabel.text = [NSString stringWithFormat: @"Сумма: %.2f", myApp.currentOrderItem.cost.floatValue*[count.text integerValue]];
    } else if ([[ServerAPI sharedServer] isEspanian]) {
    	summLabel.text = [NSString stringWithFormat: @"Suma: %.2f", myApp.currentOrderItem.cost.floatValue*[count.text integerValue]];
    } else {
    	summLabel.text = [NSString stringWithFormat: @"Summ: %.2f", myApp.currentOrderItem.cost.floatValue*[count.text integerValue]];	
    }
}

- (IBAction)plusPressed:(id)sender {
    int currentCount = [count.text integerValue];
    
    if (currentCount < 1000) {
	currentCount++;
    }
    [count setText: [NSString stringWithFormat:@"%d", currentCount]];

    if ([[ServerAPI sharedServer] isRussian]) {
    	summLabel.text = [NSString stringWithFormat: @"Сумма: %.2f", myApp.currentOrderItem.cost.floatValue*[count.text integerValue]];
    } else if ([[ServerAPI sharedServer] isEspanian]) {
    	summLabel.text = [NSString stringWithFormat: @"Suma: %.2f", myApp.currentOrderItem.cost.floatValue*[count.text integerValue]];
    } else {
    	summLabel.text = [NSString stringWithFormat: @"Summ: %.2f", myApp.currentOrderItem.cost.floatValue*[count.text integerValue]];	
    }
}

- (IBAction)addToOrder:(id)sender {
    [[ServerAPI sharedServer] putOrderItem: myApp.currentOrder.identifier.intValue menuItem: myApp.currentOrderItem.itemID.intValue count: [count.text integerValue] delegate: self];
}

#pragma mark - Delegate
- (void) didFinishLoading: (NSArray *) objects {
    BOOL changed = false;

    if ([objects count] > 0) {
	OrderItem * currentItem = (OrderItem *)[objects objectAtIndex: 0];
	
	if (currentItem) {
	    for (int i = 0; i < [myApp.orderItems count]; i++) {
		OrderItem * orderItem= (OrderItem *)[myApp.orderItems objectAtIndex: i];
		if ([orderItem.name isEqualToString: currentItem.name]) {
		    if ([count.text integerValue] > 0) {
			[myApp.orderItems replaceObjectAtIndex: i withObject: currentItem];
			changed = true;
		    } else {
			[myApp.orderItems removeObjectAtIndex: i];
			changed = true;
		    }
		}
	    }
	}
	if (!changed) {
	    [myApp.orderItems addObject: currentItem];
	}
    } else {
	for (int i = 0; i < [myApp.orderItems count]; i++) {
	    OrderItem * orderItem= (OrderItem *)[myApp.orderItems objectAtIndex: i];
	    if ([orderItem.name isEqualToString: myApp.currentOrderItem.name]) {
		if ([count.text integerValue] > 0) {
		    [myApp.orderItems replaceObjectAtIndex: i withObject: myApp.currentOrderItem];
		    changed = true;
		} else {
		    [myApp.orderItems removeObjectAtIndex: i];
		    changed = true;
		}
	    }
	}
	if (!changed) {
	    [myApp.orderItems addObject: myApp.currentOrderItem];
	}	
    }
    [myApp.navigationController popViewControllerAnimated: YES];
}

@end
