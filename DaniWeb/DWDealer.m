//
//  DWDealer.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/29/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#define BASE_URL @"http://www.daniweb.com/api"


#import "DWDealer.h"


@interface DWDealer()
@property (strong, nonatomic)    NSArray * mainMenu;
@end

@implementation DWDealer

#pragma mark - instance methods

-(NSArray *)mainMenu
{
    if(!_mainMenu)
    {
        // Load the main menu from the local file first.
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
        NSString   * directory = [dirPaths objectAtIndex:0];
        NSString *filepath = [directory stringByAppendingPathComponent:@"mainMenu.out"];
        _mainMenu = [NSArray arrayWithContentsOfFile:filepath];
        
        //If the contents is empty, load the menu from URL.
        if(!_mainMenu)
        {
            NSDictionary * menuData = [self getDataFromUrl:[self urlForItem:@"forums" underItem:nil withIds:nil]];
            _mainMenu = menuData[@"data"];
            
            // Save the menu to the file
            [_mainMenu writeToFile:filepath atomically:YES];
            return _mainMenu;
        }
        
        //if the contents is not empty, refresh the contents.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSDictionary * menuData = [self getDataFromUrl:[self urlForItem:@"forums" underItem:nil withIds:nil]];
                _mainMenu = menuData[@"data"];
                [_mainMenu writeToFile:filepath atomically:YES];
                NSLog(@"Reloaded main menu. Posting Notification");
                
                // dispatch a notification to reload the main menu
                [[NSNotificationCenter defaultCenter] postNotificationName:@"com.sixface.DaniWeb.mainMenuLoaded" object:self];
            });
        });
    }
    //return menu loaded from file.
    return _mainMenu;
}

-(NSArray *)getSubMenuForItemID:(NSInteger)parentId
{
    NSArray * subMenu = nil;
    if (parentId)
    {
        NSDictionary * item = [self getMenuItemFromArray:self.mainMenu withId:parentId ];
        subMenu=  item[@"relatives"][@"children"];
    }
    else
    {
        subMenu = self.mainMenu;
    }
    return subMenu;
}

-(NSDictionary *) getMenuItemFromArray:(NSArray *)list withId: (NSInteger) itemId
{
    NSDictionary * menuItem = nil;
    for( NSDictionary* item in list)
    {
        if( [item[@"id"] isEqualToString:[NSString stringWithFormat:@"%d", itemId]] )
        {
            menuItem = item;
            break;
        }
        if (item[@"relatives"][@"children"]) {
            menuItem = [self getMenuItemFromArray:item[@"relatives"][@"children"]
                                           withId:itemId];
            if (menuItem != nil) {
                break;
            }
        }
    }
    
    return menuItem;
}

-(NSArray *)getContentForForumID:(NSString *)forumId
{
    sleep(3);
    NSArray* articles = nil;
    if (forumId)
    {
        NSDictionary* dataArticles = [self getDataFromUrl:[self urlForItem:@"articles" underItem:@"forums" withIds:@[forumId]]];
        articles = dataArticles[@"data"];
    }
    
    return articles;
}

#pragma mark - utility methods

-(NSDictionary * ) getDataFromUrl:(NSURL*) url
{
    NSURLResponse *response = nil;
    NSDictionary* data = nil;
    
    NSLog(@"getting data from url - %@", [url description]);
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSData *urlOutput  = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response
                                                           error:nil];
    //TODO: uncomment the below lines to get data from
    //NSData * data = [NSData dataWithContentsOfFile:@"/Users/sixface/temp/daniweb-menu.json"];
    
    
    //TODO: Handle the error properly when the connection is not available
    if(!urlOutput)
    {
        NSLog(@"Error getting connection");
    }
    
    id json = [NSJSONSerialization JSONObjectWithData:urlOutput
                                              options:0
                                                error:nil];
    if ([json isKindOfClass:[NSDictionary class]])
    {
        data = ((NSDictionary*) json);
    }
    return data;
}

-(NSURL*) urlForItem: (NSString*)item underItem:(NSString*) parentItem withIds:(NSArray * )ids
{
    NSURL* url =nil;
    NSString* tmpUrl = nil;
    if (parentItem)
    {
        tmpUrl = [NSString stringWithFormat:@"%@/%@/%@/%@", BASE_URL, parentItem, [ids componentsJoinedByString:@";"], item];
    }
    else
    {
        tmpUrl = [NSString stringWithFormat:@"%@/%@", BASE_URL, item];
        if(ids)
            tmpUrl = [NSString stringWithFormat:@"%@/%@", tmpUrl, [ids componentsJoinedByString:@";"]];
    }
    url = [NSURL URLWithString:tmpUrl];
    return url;
}

@end
