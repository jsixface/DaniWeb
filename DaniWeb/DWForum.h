//
//  DWForum.h
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 7/7/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWForum : NSObject

@property(nonatomic, retain) NSNumber * forumId;
@property(nonatomic, retain) NSString * title;
@property(nonatomic, retain) NSString * forumDescription;
@property(nonatomic, retain) NSURL * uri;
@property(nonatomic, retain) NSArray * children;



@end
