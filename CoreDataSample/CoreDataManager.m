//
//  CoreDataManager.m
//  CoreDataSample
//
//  Created by Sudarshan Shetty on 3/10/14.
//  Copyright (c) 2014 Sudarshan Shetty. All rights reserved.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"

@implementation CoreDataManager


+ (NSArray *)retrieveAllRecordsForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate
{
    
    AppDelegate *appdelgate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:appdelgate.managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    
    return [appdelgate.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
}

+ (BOOL) isClubExist:(NSString *)clubname
{
    //NSFetchRequest
    
   AppDelegate *appdelgate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSFetchRequest * _NSFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Clubs"];
    
    _NSFetchRequest.predicate =  [NSPredicate predicateWithFormat:@"clubname == %@",clubname];
    
    NSError *error = nil;
    NSArray * _NSArray = [appdelgate.managedObjectContext executeFetchRequest:_NSFetchRequest error:&error];
    
    if ([_NSArray count] == 0) {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (BOOL) isPlayerExist:(NSString *)clubname
{
    //NSFetchRequest
    
    AppDelegate *appdelgate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSFetchRequest * _NSFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Players"];
    
    _NSFetchRequest.predicate =  [NSPredicate predicateWithFormat:@"playerName == %@",clubname];
    
    NSError *error = nil;
    NSArray * _NSArray = [appdelgate.managedObjectContext executeFetchRequest:_NSFetchRequest error:&error];
    
    if ([_NSArray count] == 0) {
        return NO;
    }
    else
    {
        return YES;
    }
}



@end
