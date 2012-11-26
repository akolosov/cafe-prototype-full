//
//  GameViewController.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 19.05.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@property (nonatomic) BOOL played;

@end

@implementation GameViewController

@synthesize myApp, lblOne, lblTwo, lblThree, actionButton, played;

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
}

- (void)viewDidUnload
{
    [self setActionButton:nil];
    [self setLblOne:nil];
    [self setLblTwo:nil];
    [self setLblThree:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)letsPlay:(id)sender {
    if (!myApp.code) {
    	[[ServerAPI sharedServer] getRandomCode: self];
    }
}

#pragma mark - Delegate
- (void) didFinishLoading: (NSArray *) objects {
    if (played) {
	UserAccount * account = [objects objectAtIndex: 0];
	if (account.bonus > 0) {
	    [[ServerAPI sharedServer] alertWindow: @"You have BONUS!!!"];
	}
    } else {
    	myApp.code = [objects objectAtIndex: 0];
    	lblOne.text = myApp.code.one;
    	lblTwo.text = myApp.code.two;
    	lblThree.text = myApp.code.three;
	played = YES;
	[[ServerAPI sharedServer] putUserBonus: [NSString stringWithFormat: @"%@%@%@", myApp.code.one, myApp.code.two, myApp.code.three] delegate: self];
    }
}

@end
