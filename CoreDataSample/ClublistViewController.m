//
//  ClublistViewController.m
//  CoreDataSample
//
//  Created by Sudarshan Shetty on 3/10/14.
//  Copyright (c) 2014 Sudarshan Shetty. All rights reserved.
//

#import "ClublistViewController.h"
#import "AppDelegate.h"
#import "Clubs.h"
#import "Players.h"
#import  "CoreDataManager.h"
#import "PlayerListViewController.h"

@interface ClublistViewController ()

@end

@implementation ClublistViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        // Insert the Clubs
        
        AppDelegate *appdelgate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        NSMutableArray *theArray=[[NSMutableArray alloc]init];
        [theArray addObject:@"Barcelona"];
        [theArray addObject:@"Real Madrid"];
        [theArray addObject:@"Manchester City"];
        [theArray addObject:@"Manchester United"];
        
        for(int i=0; i<[theArray count]; i++)
        {
            
            if (![CoreDataManager isClubExist:[theArray objectAtIndex:i]]) {
            
            Clubs *aManagedObject =(Clubs*) [NSEntityDescription insertNewObjectForEntityForName:@"Clubs" inManagedObjectContext:appdelgate.managedObjectContext];
            
            [aManagedObject setValue:[theArray objectAtIndex:i] forKey:@"clubname"];
            }
            
        }
        
        NSError *err=nil;
        
        if (![appdelgate.managedObjectContext save:&err])
        {
            NSLog (@"error while saving managed object context :%@",err);
        }
        
        
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.navigationItem.title=@"Clubs";
    
    // Insert the Players for each club
    
    
    NSMutableArray *barcelonaplayers=[[NSMutableArray alloc]initWithObjects:@"Messi",@"XaVi",@"Iniesta",@"Puyol" ,nil];
    [self insertPlayers:barcelonaplayers clubname:@"Barcelona"];
    
    NSMutableArray *mancityPlayers=[[NSMutableArray alloc]initWithObjects:@"Silva",@"Aguero",@"Nasri",@"Negredo" ,nil];
    [self insertPlayers:mancityPlayers clubname:@"Manchester City"];

    
    NSMutableArray *madridPlayers=[[NSMutableArray alloc]initWithObjects:@"Ronaldo",@"Benzima",@"Alonso",@"Bale" ,nil];
    [self insertPlayers:madridPlayers clubname:@"Real Madrid"];

    
    NSMutableArray *unitedPlayers=[[NSMutableArray alloc]initWithObjects:@"Persi",@"Rooney",@"Giggs",@"Carrick" ,nil];
    [self insertPlayers:unitedPlayers clubname:@"Manchester United"];

       mclubArray= [[NSMutableArray alloc]initWithArray: [CoreDataManager retrieveAllRecordsForEntity:@"Clubs" withPredicate:nil]];
    
    [self.tableView reloadData];
    
    
}


-(void)insertPlayers:(NSArray*)inArray clubname:(NSString*)inclubname
{
    
    AppDelegate *appdelgate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSPredicate *thePredicate= [NSPredicate predicateWithFormat:@"clubname == %@",inclubname];
    Clubs  *theclub= (Clubs*)[[CoreDataManager retrieveAllRecordsForEntity:@"Clubs" withPredicate:thePredicate] lastObject];
    
    for(int i=0; i<[inArray count]; i++)
    {
      if (![CoreDataManager isPlayerExist:[inArray objectAtIndex:i]]) {
        Players *aManagedObject1 =(Players*) [NSEntityDescription insertNewObjectForEntityForName:@"Players" inManagedObjectContext:appdelgate.managedObjectContext];
        
        [aManagedObject1 setValue:[inArray objectAtIndex:i] forKey:@"playerName"];
        
        aManagedObject1.club=theclub ;
      }
    }
    
    
    
    NSError *err=nil;
    
    if (![appdelgate.managedObjectContext save:&err])
    {
        NSLog (@"error while saving managed object context :%@",err);
    }
    

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [mclubArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Clubs  *theclub= (Clubs*)[mclubArray objectAtIndex:indexPath.row];
    cell.textLabel.text=theclub.clubname;
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    Clubs  *theclub= (Clubs*)[mclubArray objectAtIndex:indexPath.row];
    PlayerListViewController  *playercntrl=[[PlayerListViewController alloc]init];

    
    [self.navigationController pushViewController:playercntrl animated:YES];
    
    [playercntrl getClubName:theclub.clubname];
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Clubs  *theclub= (Clubs*)[mclubArray objectAtIndex:indexPath.row];
        AppDelegate *appdelgate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        [appdelgate.managedObjectContext deleteObject:theclub];
        [mclubArray removeObjectAtIndex:indexPath.row];
        
        NSError *err=nil;
        
        if (![appdelgate.managedObjectContext save:&err])
        {
            NSLog (@"error while saving managed object context :%@",err);
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
