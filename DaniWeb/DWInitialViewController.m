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

@interface DWInitialViewController ()
@property(nonatomic) DWContentViewController * contentView;
@end

@implementation DWInitialViewController

@synthesize contentView = _containerView;

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
    // Do any additional setup after loading the view.


    
    DWMenuViewController * menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    [self addChildViewController:menuViewController];
    
    [menuViewController didMoveToParentViewController:self];


    [self.view addSubview:menuViewController.view ];
    menuViewController.stuffController = self.contentView;

}


-(DWContentViewController * ) contentView
{
    if (!_containerView) {
        DWContentViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentView"];
        [self addChildViewController:controller];
        
        
        CGRect windowBounds = self.view.bounds;
        [controller.view setFrame:windowBounds];
        
        [self.view addSubview:controller.view];
        _containerView = controller;
    }
    return _containerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
