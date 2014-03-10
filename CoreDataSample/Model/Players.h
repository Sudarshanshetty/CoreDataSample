//
//  Players.h
//  CoreDataSample
//
//  Created by Sudarshan Shetty on 3/10/14.
//  Copyright (c) 2014 Sudarshan Shetty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Players : NSManagedObject

@property (nonatomic, retain) NSString *playerName;
@property (nonatomic, retain) NSManagedObject *club;

@end
