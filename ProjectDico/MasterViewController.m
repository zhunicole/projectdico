//
//  MasterViewController.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/24/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import <Parse/Parse.h>
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TaskCategory.h"
#import "SubCategory.h"
#import "StarView.h"

@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *masterTable;
@property (nonatomic, strong) NSMutableArray *TasksArray;


@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void) viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //load categories
    [TaskCategory uploadCategories];
    [SubCategory uploadSubCategories];
    [self setTasksArray];
    
}

- (void)setTasksArray{
    if (!_TasksArray){
        _TasksArray = [[NSMutableArray alloc] init];
        
        PFQuery *query = [PFQuery queryWithClassName:@"tasks"];
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.TasksArray = [[NSMutableArray alloc] initWithCapacity:objects.count];
                for (PFObject *object in objects) {
                    NSString *title = object[@"taskTitle"];
                    if(title)  [self.TasksArray addObject:title] ;           // title is nil?? store results
                }
                [self.tableView reloadData];   // Reload table
                
            } else {
                NSLog(@"Parse errro");
            }
        }];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)newTaskBtn:(id)sender {
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.TasksArray.count;
    
}


-(NSDate*) getDatefromTitle:(NSString*)title {
    PFQuery *query = [PFQuery queryWithClassName:@"tasks"];
    [query whereKey:@"taskTitle" equalTo:title];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    NSArray *results = [query findObjects];
    PFObject *obj = [results objectAtIndex:0];
    NSDate *date = [obj createdAt];
    return date;
}

-(NSInteger) getProgressfromTitle:(NSString*)title {
    PFQuery *query = [PFQuery queryWithClassName:@"tasks"];
    [query whereKey:@"taskTitle" equalTo:title];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    NSArray *results = [query findObjects];
    PFObject *obj = [results objectAtIndex:0];
    NSInteger progress = [obj[@"progress"] integerValue];
    
    return progress;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    
    [cell.textLabel setText:[self.TasksArray objectAtIndex:indexPath.row]];
    NSString *title = [self.TasksArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE, MMM d, h:mm a"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:[self getDatefromTitle:title]]];
    
    NSInteger progress = [self getProgressfromTitle:title];
    [self updateImage:progress forCell:cell];
    
    return cell;
    
}

-(void) updateImage:(NSInteger) progress forCell: (UITableViewCell*)cell {
    switch (progress)
    
    {
            //saved to Parse
        case 0:
            
            cell.imageView.image = [UIImage imageNamed:@"onesDonut.png"];
            
            break;
            
        case 1: //outsource is clicked
            
            cell.imageView.image = [UIImage imageNamed:@"halfDonut.png"];
            
            break;
            
        case 3: //assistant is on it!
            
            cell.imageView.image = [UIImage imageNamed:@"thirdsDonut.png"];

            break;

        case 4://task is finished
            
            cell.imageView.image = [UIImage imageNamed:@"fullDonut.png"];
            
            break;

        default:
            
            cell.imageView.image = [UIImage imageNamed:@"fullDonut.png"];
            
            break;
            
    }
}




#pragma mark - Navigation

- (NSString *)getObjectIdForTitle: (NSString *) taskTitle {
    NSLog(@"taskTitle: %@", taskTitle);
    PFQuery *query = [PFQuery queryWithClassName:@"tasks"];
    [query whereKey:@"taskTitle" equalTo:taskTitle];
    
    NSString *objectID = nil;
    NSArray *tasks=[query findObjects];
    PFObject *task = [tasks objectAtIndex:0];
    objectID = task.objectId;
    
    return objectID;
    
}
- (void)prepareVC:(DetailViewController *)ivc
          forTask:(NSString *)taskTitle

{
    //get current taskId
    ivc.taskId = [self getObjectIdForTitle:taskTitle];
    ivc.taskTitle = taskTitle;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSInteger path = [[[self tableView] indexPathForSelectedRow] row];
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"showDetail"]) {
                NSString *taskTitle = [self.TasksArray objectAtIndex: path];
                [self prepareVC:segue.destinationViewController forTask:taskTitle];
                
            }
        }
    }
}



- (IBAction)goToMasterViewController :(UIStoryboardSegue*)segue {
    
}

@end
