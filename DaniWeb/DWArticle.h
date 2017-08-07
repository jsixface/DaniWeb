//
//  DWArticle.h
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 7/6/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWArticle : NSObject

@property(nonatomic, retain) NSString * title;
@property(nonatomic, retain) NSNumber * upvotes;
@property(nonatomic, retain) NSString * uri;
@property(nonatomic, retain) NSNumber * articleId;
@property(nonatomic, retain) NSNumber * repliesCount;
@property(nonatomic, retain) NSNumber * viewsCount;
@property(nonatomic, retain) NSString * type;
@property(nonatomic, retain) NSArray * related;
@property(nonatomic, retain) NSArray * posters;



@end
