//
//  DWInitialViewController.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/20/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWInitialViewController.h"
#import "DWContentViewController.h"
#import "DWMenuViewController.h"
#import "DWNavigationViewController.h"

@interface DWInitialViewController ()
@property(nonatomic) DWNavigationViewController * contentViewController;
@end

@implementation DWInitialViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DWMenuViewController * menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    [self addChildViewController:menuViewController];
    [menuViewController didMoveToParentViewController:self];
    [self.view addSubview:menuViewController.view ];
    
    menuViewController.stuffController = self.contentViewController;
    
}


-(DWNavigationViewController * ) contentViewController
{
    if (!_contentViewController) {
        
        DWNavigationViewController * navigator = [self.storyboard instantiateViewControllerWithIdentifier:@"navigator"];
        
        [self addChildViewController:navigator];
        
        CGRect windowBounds = self.view.bounds;
        [navigator.view setFrame:windowBounds];
        [self.view addSubview:navigator.view];
        _contentViewController = navigator;

    }
    return _contentViewController;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
