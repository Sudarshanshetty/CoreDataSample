//
//  Clubs.h
//  CoreDataSample
//
//  Created by Sudarshan Shetty on 3/10/14.
//  Copyright (c) 2014 Sudarshan Shetty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Players;

@interface Clubs : NSManagedObject

@property (nonatomic, retain) NSString *clubname;
@property (nonatomic, retain) NSSet *players;
@end

@interface Clubs (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(Players *)value;
- (void)removePlayersObject:(Players *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
