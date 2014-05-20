//
//  DWContentViewController.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/23/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWArticleViewController.h"
#import "DWContentViewController.h"
#import "DWNavigationViewController.h"
#import "DWContentCellView.h"
#import "DWDealer.h"

#define CELL_HEIGHT 80.0

@interface DWContentViewController ()

@property (strong, nonatomic) IBOutlet UIView *tableCellBackground;

@property (strong, nonatomic) IBOutlet UITableView *postsTable;
@property (strong, nonatomic) NSArray * totalPosts;
@property (strong, nonatomic) DWDealer * dealer;
@end

@implementation DWContentViewController
{
    UIFont * _cellTitleFont;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.shadowOffset = CGSizeZero;
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;

}

-(void)viewWillAppear:(BOOL)animated
{
    // clear the selection of the menu item.
    NSIndexPath * selectedIndex = self.postsTable.indexPathForSelectedRow;
    if (selectedIndex)
        [self.postsTable deselectRowAtIndexPath:selectedIndex animated:animated];
}

-(DWDealer *)dealer
{
    if(!_dealer)
    {
        _dealer = [[DWDealer alloc] init];
    }
    return _dealer;
}

-(void)openMenuForItem:(NSDictionary *)menuitem
{
    // set the title
    self.title =menuitem[@"title"];
    
    // get the data from the dealer
    // set the data to data holder
    self.totalPosts = [self.dealer getContentForForumID:menuitem[@"id"]];
    
    
    // reload the table
    [self.postsTable reloadData];
    [self.postsTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                           atScrollPosition:UITableViewScrollPositionTop
                                   animated:NO];
}

- (IBAction)toggleContent:(UIButton *)sender
{
    DWNavigationViewController * parent = (DWNavigationViewController*)self.parentViewController;
    [parent toggleContent];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"article"])
    {
        DWArticleViewController* destination = [segue destinationViewController];
        DWContentCellView * selectedPostCell = (DWContentCellView*)sender;
        destination.textContent = selectedPostCell.titleText;
         NSLog(@"%@", selectedPostCell.textLabel.text);
        
    }
}

#pragma - TableView datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.totalPosts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWContentCellView * cell = [tableView dequeueReusableCellWithIdentifier:@"Post" forIndexPath:indexPath];
    if (!_cellTitleFont) {
        _cellTitleFont = cell.txtTitle.font;
    }
    cell.titleText = self.totalPosts[[indexPath row]][@"title"];
    cell.txtAuthor.text = self.totalPosts[[indexPath row]][@"last_post"][@"poster"][@"username"];
    cell.timestamp = self.totalPosts[[indexPath row]][@"last_post"][@"timestamp"];
    NSString* tag = self.totalPosts[[indexPath row]][@"id"];
    cell.tag  =[tag integerValue];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * title = self.totalPosts[[indexPath row]][@"title"];
    UIFont * titleFont  =    [UIFont fontWithName:@"Helvetica" size:16.0];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: titleFont}];

    if (size.width < 288)
        return CELL_HEIGHT - titleFont.lineHeight;
    else
        return CELL_HEIGHT;
}

@end
