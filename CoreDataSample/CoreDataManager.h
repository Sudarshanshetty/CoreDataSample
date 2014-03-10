//
//  CoreDataManager.h
//  CoreDataSample
//
//  Created by Sudarshan Shetty on 3/10/14.
//  Copyright (c) 2014 Sudarshan Shetty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

+ (NSArray *)retrieveAllRecordsForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate;
+ (BOOL) isClubExist:(NSString *)clubname;
+ (BOOL) isPlayerExist:(NSString *)clubname;
@end
