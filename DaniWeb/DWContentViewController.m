//
//  DWContentViewController.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/23/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWContentViewController.h"
#import "DWNavigationViewController.h"

@interface DWContentViewController ()
@property (strong, nonatomic) IBOutlet UITableView *postsTable;
@property (strong, nonatomic) NSDictionary * totalPosts;
@end

@implementation DWContentViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.shadowOffset = CGSizeZero;
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.totalPosts = @{@"first": @"first value",
                        @"second": @"second value",
                        @"third": @"third value"
                        };
}

- (IBAction)toggleContent:(UIButton *)sender
{
    DWNavigationViewController * parent = (DWNavigationViewController*)self.parentViewController;
    [parent toggleContent];
}

#pragma - TableView datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.totalPosts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* keys = [self.totalPosts allKeys];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Post" forIndexPath:indexPath];
    cell.textLabel.text = keys[[indexPath row]];
    return cell;
}

@end
