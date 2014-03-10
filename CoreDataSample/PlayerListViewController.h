//
//  PlayerListViewController.h
//  CoreDataSample
//
//  Created by Sudarshan Shetty on 3/10/14.
//  Copyright (c) 2014 Sudarshan Shetty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerListViewController : UITableViewController

{
    
    NSMutableArray *mPlayerlistArray;
}

-(void)getClubName:(NSString*)inClubname;
@end
