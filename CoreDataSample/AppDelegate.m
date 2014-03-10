//
//  AppDelegate.m
//  CoreDataSample
//
//  Created by Sudarshan Shetty on 3/10/14.
//  Copyright (c) 2014 Sudarshan Shetty. All rights reserved.
//

#import "AppDelegate.h"
#import "ClublistViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    ClublistViewController *clublist=[[ClublistViewController alloc]init];
    UINavigationController *thecntrl=[[UINavigationController alloc]initWithRootViewController:clublist];
  
    self.window.rootViewController=thecntrl;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 * Method Name	: managedObjectContext
 * Description	:  Returns the managed object context for the application.  If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 * Parameters	: NSManagedObjectContext
 * Return value	: None
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        [_managedObjectContext setUndoManager:nil];
        [_managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        
    }
    return _managedObjectContext;
}


/*
 * Method Name	: managedObjectModel
 * Description	:
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 * Parameters	: NSPersistentStoreCoordinator
 * Return value	: None
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/*
 * Method Name	: persistentStoreCoordinator
 * Description	:Returns the persistent store coordinator for the application.If the coordinator doesn't already exist, it is created and the application's store added to it.
 * Parameters	: NSPersistentStoreCoordinator
 * Return value	: None
 */

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"test.sqlite"];
    
    NSDictionary *persistentStoreOptions = [NSDictionary
                                            dictionaryWithObjectsAndKeys:
                                            NSFileProtectionKey, NSFileProtectionComplete,[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                            [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,nil];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:persistentStoreOptions error:nil]) {
        
    }
    
    return _persistentStoreCoordinator;
}


#pragma mark - Application's Documents directory

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *err = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &err];
    if(!success)
    {
        
    }
    
    return success;
}

/*
 * Method Name	: applicationDocumentsDirectory
 * Description	: Returns the URL to the application's Documents directory.
 * Parameters	: NSURL
 * Return value	: None
 */


- (NSURL *)applicationDocumentsDirectory
{
    [self addSkipBackupAttributeToItemAtURL:[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]];
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
