//
//  DWViewController.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 2/26/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWMenuViewController.h"
#import "DWMenuView.h"
#import "DWMenuItem.h"
#import "UIColor+ColourTheme.h"

@interface DWMenuViewController ()
{
    NSArray * menuItems ;
    NSDictionary * mainMenuDict;
    NSMutableArray * menuStack;
    DWMenuView * tableMainMenu;
}

@end

@implementation DWMenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize the menu stack to add / dismiss submenus
    menuStack =     [[NSMutableArray alloc] init];
    
    
    // Draw the main menu - the parent menu
    tableMainMenu = [[DWMenuView alloc] initWithFrame:[self.entireContiner frame]];
    [tableMainMenu setDelegate:self];
    [menuStack addObject:tableMainMenu];
    [self.entireContiner addSubview:tableMainMenu];
    
    //TODO: uncomment the below lines to get data from url
    //    NSURL * url = [NSURL URLWithString:@"http://www.daniweb.com/api/forums"];
    //    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //
    //    NSURLResponse *response;
    //    NSData *data  = [NSURLConnection sendSynchronousRequest:request
    //                                          returningResponse:&response
    //                                                      error:nil];
    NSData * data = [NSData dataWithContentsOfFile:@"/Users/sixface/temp/daniweb-menu.json"];
    
    if(!data)
    {
        NSLog(@"Error getting connection");
    }
    
    id json = [NSJSONSerialization JSONObjectWithData:data
                                              options:0
                                                error:nil];
    if ([json isKindOfClass:[NSDictionary class]])
    {
        mainMenuDict = json;
        id dataDict = [mainMenuDict objectForKey:@"data"];
        if ([dataDict isKindOfClass:[NSArray class]])
        {
            menuItems = dataDict;
            [tableMainMenu setDataSource:self];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Main Menu Helpers


-(void)resetCellColours: (UITableView *) tableview
{
    NSInteger count = [self tableView:tableview numberOfRowsInSection:0];
    for (int i = 0; i< count; i++) {
        UITableViewCell * cell = [tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.backgroundColor = [UIColor clearColor];
    }
    
}

-(NSArray *) getChildrenFrom: (NSDictionary *) dict forId:(NSNumber *) parentId
{
    NSDictionary * relative = [dict objectForKey:@"relatives"];
    if (relative != nil)
    {
        NSArray * children =  [relative objectForKey:@"children"];
        if ([[dict valueForKey:@"id"] isEqualToString:[parentId stringValue]])
        {
            return children;
        }
        else if (children != NULL)
        {
            for (NSDictionary * child in children)
            {
                NSArray * gotit = [self getChildrenFrom:child forId:parentId];
                if (gotit != nil)
                {
                    return gotit;
                }
            }
        }
    }
    else if ([dict objectForKey:@"data"] !=nil)
    {
        for (NSDictionary * child in [dict objectForKey:@"data"])
        {
            NSArray * children = [self getChildrenFrom:child forId:parentId];
            if (children != nil)
            {
                return children ;
            }
        }
    }
    return nil;
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
    NSLog(@"Accessory button touched from id %ld", (long)[[sender view] tag]);
    NSInteger parentId = [[sender view] tag];
    
    // the top most row must be the last object in the stack. Reset the
    // colours of the selected cells and select the touched cell.
    DWMenuView * topMostTable = [menuStack lastObject];
    [self resetCellColours:topMostTable];
    [[[[sender view] superview] superview] setBackgroundColor:[UIColor DWMenuLineColour]];
    
    
    NSArray * possibleChildren = [self getChildrenFrom:mainMenuDict
                                                 forId:[NSNumber numberWithInteger:parentId]];
    if (possibleChildren) {
        CGRect markins = CGRectMake(320,
                                    tableMainMenu.frame.origin.y,
                                    topMostTable.frame.size.width - 50,
                                    topMostTable.frame.size.height);
        
        DWMenuView * newTableView = [[DWMenuView alloc] initWithFrame:markins];
        [newTableView setTag:parentId];
        [newTableView setDataSource:self];
        [newTableView setDelegate:self ];
        [self.parentView addSubview:newTableView];
        
        [menuStack addObject:newTableView];
        
        
        UIView *masklayer = [[UIView alloc]initWithFrame:tableMainMenu.frame];
        [masklayer setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.25]];
        [masklayer addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(deleteTopTableAndMask:) ]];
        
        [self.parentView addSubview:masklayer];
        [self.parentView bringSubviewToFront:newTableView];
        
        
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             CGRect newRect = CGRectMake(topMostTable.frame.origin.x+50,
                                                         topMostTable.frame.origin.y,
                                                         newTableView.bounds.size.width,
                                                         newTableView.bounds.size.height );
                             
                             newTableView.frame = newRect;}
                         completion:Nil];
        
    }
}

#pragma mark -
#pragma mark Table view Delegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [self resetCellColours:tableView];
    [selectedCell setBackgroundColor:[UIColor DWMenuLineColour]];
}

#pragma mark -
#pragma mark Table view datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // find the item for the cell from the Json dictionary.
    NSDictionary * itemForCell;
    if (tableView == tableMainMenu)
    {
        itemForCell = [menuItems objectAtIndex:[indexPath row]];
    } else
    {
        NSNumber * parentId = [NSNumber numberWithInteger:[tableView tag ]];
        
        NSArray * children = [self getChildrenFrom:mainMenuDict forId:parentId];
        itemForCell = [children objectAtIndex:[indexPath row]];
    }
    
    
    // Create the cell and return
    DWMenuItem * cell = [[DWMenuItem alloc] init];
    
    NSDictionary * relatives  = [itemForCell valueForKey:@"relatives"];
    if (relatives) {
        if ([relatives valueForKey:@"children"])
        {
            CGRect accessoryViewFrame = CGRectMake(cell.bounds.origin.x +(cell.bounds.size.width -40),
                                                   cell.bounds.origin.y,
                                                   40,
                                                   cell.bounds.size.height-10);
            
            UIView * accessoryView = [[UIView alloc] initWithFrame:accessoryViewFrame];
            UIImageView * arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
            CGRect arrowFrame = CGRectMake(0, 3, 20, 20);
            arrowView.frame = arrowFrame;
            [accessoryView addSubview:arrowView];
            accessoryView.frame = accessoryViewFrame;
            cell.accessoryView = accessoryView;
            UITapGestureRecognizer * tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openSubmenu:)];
            tapper.numberOfTapsRequired =1;
            [accessoryView setTag:[[itemForCell valueForKey:@"id"] integerValue]];
            [accessoryView addGestureRecognizer:tapper];
        }
    }
    
    [[cell textLabel] setText:[itemForCell valueForKey:@"title"]];
    [cell setTag:[[itemForCell valueForKey:@"id"] integerValue]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tableMainMenu)
    {
        return [menuItems count];
    }else
    {
        return [[self getChildrenFrom:mainMenuDict
                                forId:[NSNumber numberWithInteger:[tableView tag]] ]count];
    }
}

@end
