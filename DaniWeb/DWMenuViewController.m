//
//  DWViewController.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 2/26/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWMenuViewController.h"
#import "DWInitialViewController.h"
#import "DWNavigationViewController.h"
#import "DWMenuView.h"
#import "DWMenuItem.h"
#import "DWDealer.h"
#import "UIColor+ColourTheme.h"

@interface DWMenuViewController ()
{
    NSMutableArray * menuStack;
    DWMenuView * tableMainMenu;
}

@end


@implementation DWMenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dealer = [[DWDealer alloc] init];
    
    // Initialize the menu stack to add / dismiss submenus
    menuStack =     [[NSMutableArray alloc] init];
    
    
    // Draw the main menu - the parent menu
    CGRect frame = CGRectMake(self.view.bounds.origin.x,
                              self.view.bounds.origin.y,
                              self.view.bounds.size.width * DW_CONTENT_SLIDE_PERCENT,
                              self.view.bounds.size.height);
    
    tableMainMenu = [[DWMenuView alloc] initWithFrame:frame];
    [tableMainMenu setDelegate:self];
    [menuStack addObject:tableMainMenu];
    [self.entireContiner addSubview:tableMainMenu];
    [tableMainMenu setDataSource:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMainMenu:) name:@"com.sixface.DaniWeb.mainMenuLoaded" object:nil];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"com.sixface.DaniWeb.mainMenuLoaded" object:nil];
}

#pragma mark -
#pragma mark Main Menu Helpers


-(void) refreshMainMenu: (NSNotification *) notif
{
    //reload the datasource in all menu in menu stack
    for (DWMenuView * menu in menuStack) {
        NSLog(@"reloading the data for menu - %d", [menu tag]);
        [menu reloadData];
    }
}

-(void)resetCellColours: (UITableView *) tableview
{
    NSInteger count = [self tableView:tableview numberOfRowsInSection:0];
    for (int i = 0; i< count; i++) {
        UITableViewCell * cell = [tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.backgroundColor = [UIColor clearColor];
    }
}


-(void) deleteTopTableAndMask: (id)sender
{
    UITableView * topview = [menuStack lastObject];
    [UIView animateWithDuration:0.35
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect newRect = CGRectMake(tableMainMenu.bounds.size.width,
                                                     tableMainMenu.frame.origin.y,
                                                     tableMainMenu.bounds.size.width,
                                                     tableMainMenu.bounds.size.height );
                         
                         topview.frame = newRect;}
                     completion:^(BOOL completed){
                         [menuStack removeObject:topview];
                         [topview removeFromSuperview];
                         [[(UITapGestureRecognizer * )sender view] removeFromSuperview];
                     }];
    
}
-(void) openSubmenu: (id) sender
{
    // Get the tag from the touched cell
    
    NSInteger parentId = [[sender view] tag];
    
    // the top most row must be the last object in the stack. Reset the
    // colours of the selected cells and select the touched cell.
    DWMenuView * topMostTable = [menuStack lastObject];
    [self resetCellColours:topMostTable];
    
    CGRect markins = CGRectMake(320,
                                tableMainMenu.bounds.origin.y,
                                tableMainMenu.bounds.size.width - 50 - ([menuStack count] -1)*10,
                                topMostTable.bounds.size.height);
    
    DWMenuView * newTableView = [[DWMenuView alloc] initWithFrame:markins];
    [newTableView setTag:parentId];
    [newTableView setDataSource:self];
    [newTableView setDelegate:self ];
    [self.entireContiner addSubview:newTableView];
    
    [menuStack addObject:newTableView];
    
    
    UIView *masklayer = [[UIView alloc]initWithFrame:tableMainMenu.frame];
    [masklayer setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.25]];
    [masklayer addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(deleteTopTableAndMask:) ]];
    
    [self.entireContiner addSubview:masklayer];
    [self.entireContiner bringSubviewToFront:newTableView];
    
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect newRect = CGRectMake(tableMainMenu.bounds.origin.x + 50 + ([menuStack count] -1)*10,
                                                     tableMainMenu.bounds.origin.y,
                                                     newTableView.bounds.size.width,
                                                     newTableView.bounds.size.height );
                         
                         newTableView.frame = newRect;}
                     completion:Nil];
    
}


#pragma mark -
#pragma mark Table view Delegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [self resetCellColours:tableView];
    [selectedCell setBackgroundColor:[UIColor DWMenuLineColour]];
    
    [self.stuffController  openMenuForItem:@{@"id":[NSString stringWithFormat:@"%d", [selectedCell tag]],
                                             @"title": selectedCell.textLabel.text
                                             }];

}

#pragma mark -
#pragma mark Table view datasource


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // find the item for the cell from the Json dictionary.
//    NSNumber * parentId = [NSNumber numberWithInteger:[tableView tag ]];
    NSArray * children = [self.dealer getSubMenuForItemID:[tableView tag ]];
    NSDictionary * itemForCell = children[[indexPath row]];

    // Create the cell and return
    DWMenuItem * cell = [[DWMenuItem alloc] init];
        if (itemForCell[@"relatives"][@"children"])
        {
            CGRect accessoryViewFrame = CGRectMake(cell.bounds.origin.x +(cell.bounds.size.width -80),
                                                   cell.bounds.origin.y,
                                                   40,
                                                   cell.bounds.size.height-20);
            
            UIView * accessoryView = [[UIView alloc] initWithFrame:accessoryViewFrame];
            UIImageView * arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
            CGRect arrowFrame = CGRectMake(10, 2, 20, 20);
            arrowView.frame = arrowFrame;
            [accessoryView addSubview:arrowView];
            accessoryView.frame = accessoryViewFrame;
            cell.accessoryView = accessoryView;
            UITapGestureRecognizer * tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openSubmenu:)];
            tapper.numberOfTapsRequired =1;
            [accessoryView setTag:[itemForCell [@"id"] integerValue]];
            [accessoryView addGestureRecognizer:tapper];
        }
    [[cell textLabel] setText:itemForCell[@"title"]];
    [cell setTag:[itemForCell[@"id"] integerValue]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    
    NSArray * menuItems = [self.dealer getSubMenuForItemID:tableView.tag];
    count = [menuItems count];
    return count;
}

@end
