//
//  DWDealer.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/29/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWDealer.h"

@implementation DWDealer


-(id)init
{
    self = [super init];
    
    if (self) {
        
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
             self.mainMenu = ((NSDictionary*) json)[@"data"];
        }
    }
    return self;
}

-(NSArray *)getSubMenuForItemID:(int)parentId
{
    NSArray * subMenu = nil;
    if (parentId)
    {
        NSDictionary * parentItem = [self getMenuItemFromArray:self.mainMenu withId:parentId ];
        subMenu=  parentItem[@"relatives"][@"children"];
    }
    else
    {
        subMenu = self.mainMenu;
    }
    return subMenu;
}

-(NSDictionary *) getMenuItemFromArray:(NSArray *)list withId: (int) itemId
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

@end
