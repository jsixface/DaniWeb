//
//  DWConfigurator.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 7/7/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWConfigurator.h"
#import "DWArticle.h"
#import "DWForum.h"
#import <RestKit/RestKit.h>

@implementation DWConfigurator


+(void)config
{
    [self configRestKit];
}

+(void) configRestKit
{
    
    // create an object manager and configure it
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://www.daniweb.com/api/"]];
    
    
    // map for the individual objects first like article and post and users.
    
    RKObjectMapping * articleMap = [RKObjectMapping mappingForClass:[DWArticle class]];
    [articleMap addAttributeMappingsFromDictionary:@{
                                                     @"title": @"title",
                                                     @"upvotes": @"upvotes",
                                                     @"uri": @"uri",
                                                     @"id": @"articleId",
                                                     @"replies_count": @"repliesCount",
                                                     @"views_count": @"viewsCount",
                                                     @"type": @"type"
                                                     }] ;
    NSIndexSet *statusSuccess = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *articleResponse = [RKResponseDescriptor responseDescriptorWithMapping:articleMap
                                                                                         method:RKRequestMethodAny
                                                                                    pathPattern:nil
                                                                                        keyPath:@"data"
                                                                                    statusCodes:statusSuccess];
    
    RKObjectMapping * forumMap = [RKObjectMapping mappingForClass:[DWForum class]];
    [forumMap addAttributeMappingsFromDictionary:@{
                                                     @"title": @"title",
                                                     @"uri": @"uri",
                                                     @"id": @"forumId",
                                                     @"description": @"forumDescription"
                                                     }] ;
    [forumMap addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"relatives.children"
                                                                             toKeyPath:@"children"
                                                                           withMapping:forumMap]];

    RKResponseDescriptor *forumResponse = [RKResponseDescriptor responseDescriptorWithMapping:forumMap
                                                                                         method:RKRequestMethodAny
                                                                                    pathPattern:nil
                                                                                        keyPath:@"data"
                                                                                    statusCodes:statusSuccess];
    
 
    
    // create routes for object access
    [manager.router.routeSet addRoute:[RKRoute routeWithName:@"forum_articles" pathPattern:@"forums/:forumId/articles" method:RKRequestMethodGET]];
    [manager.router.routeSet addRoute:[RKRoute routeWithName:@"forums" pathPattern:@"forums/" method:RKRequestMethodGET]];

    
    // add mapping to the object manager.
    [manager addResponseDescriptorsFromArray:@[ articleResponse, forumResponse ]];
    
}


@end
