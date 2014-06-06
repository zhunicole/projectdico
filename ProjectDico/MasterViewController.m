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

@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *masterTable;
@property (nonatomic, strong) NSMutableArray *TasksArray;
//@property (strong, nonatomic) NSMutableArray *cards;


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
    [self.masterTable setDelegate:self];
//    self.TasksArray;
    //load categories
    [TaskCategory uploadCategories];
    [SubCategory uploadSubCategories];
    
}

- (NSMutableArray *)TasksArray{
    if (!_TasksArray){
        _TasksArray = [[NSMutableArray alloc] init];
        [self queryForTasks];
    }
    return self.TasksArray;

}

-(void) queryForTasks {
    PFQuery *query = [PFQuery queryWithClassName:@"tasks"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
//            [self.masterTable reloadData];   // Reload table
            
            self.TasksArray = [[NSMutableArray alloc] initWithCapacity:objects.count];

            for (PFObject *object in objects) {
                NSString *title = object[@"taskTitle"];
                [self.TasksArray addObject:title] ;           // Store results
            }
            [self.masterTable reloadData];   // Reload table

        } else {
            NSLog(@"Parse errro");
        }
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)newTaskBtn:(id)sender {
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    
    
    [cell.textLabel setText:[self.TasksArray objectAtIndex:indexPath.row]];
    return cell;
}


- (IBAction)goToMasterViewController :(UIStoryboardSegue*)segue {
    
}

@end
