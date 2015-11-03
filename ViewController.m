//
//  ViewController.m
//  ListView
//
//  Created by Techno on 10/18/15.
//  Copyright © 2015 Techno. All rights reserved.
//

#import "ViewController.h"
#import "CustemCell.h"
#import "SecondViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>


{
    
    NSMutableArray *DataArray;
    NSMutableArray *datatoPassHere;

}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end


@implementation ViewController

@synthesize activityIndicatorObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DataArray = [[NSMutableArray alloc]init];
    
    // Initialize ActivityIndicator object
    
    activityIndicatorObject = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Set Center Position for ActivityIndicator
    
    activityIndicatorObject.center = self.view.center;
    activityIndicatorObject.color = [UIColor redColor];
    
    // Add ActivityIndicator to your view
    
    [self.view addSubview:activityIndicatorObject];
    
    // Feching Data From server
    
    [activityIndicatorObject startAnimating];
    self.navigationItem.title = @"Add Photos to existing project";
  
    
    [self FeatchDataFromServer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CELL";
    
    CustemCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustemCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    
    [cell.redioButton setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateNormal];
    
    [cell.redioButton setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateSelected];
    
    [cell.redioButton addTarget:self action:@selector(radiobtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.redioButton.tag = indexPath.row;
    
    cell.TitelLab.text = [[DataArray objectAtIndex:indexPath.row]objectForKey:@"title"];
    
    NSMutableArray *portfolioArray = [[NSMutableArray alloc]init];
    
    portfolioArray = [[DataArray objectAtIndex:indexPath.row]objectForKey:@"portfolio"];
    
    NSMutableArray *urlArray = [[NSMutableArray alloc]init];
    
    for (int i=0 ; i<[portfolioArray count] ; i++) {
        
        NSMutableDictionary * location = [[portfolioArray objectAtIndex:i]objectForKey:@"url"];
        
        [urlArray addObject:location];
        
    }
    
    cell.countLab.text = [NSString stringWithFormat:@"%lu Photos",(unsigned long)urlArray.count];
    
    return cell;
}


-(void)radiobtn:(id)sender
{
    
    if([sender isSelected])
    {
        [sender setSelected:NO];
    }
    
    else
    {
        [sender setSelected:YES];
    }
    
    
}

-(void)FeatchDataFromServer {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://skillvo-dev.skillvo.com/api/sampledata?format=json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        DataArray = [responseObject objectForKey:@"pagedList"];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
            [activityIndicatorObject stopAnimating];
        });
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
         [activityIndicatorObject stopAnimating];
    }];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath
                                                                    *)indexPath {
    
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    
    NSMutableArray *portfolioArray = [[NSMutableArray alloc]init];
    
    portfolioArray = [[DataArray objectAtIndex:indexPath.row]objectForKey:@"portfolio"];
    
    datatoPassHere = [[NSMutableArray alloc]init];
    for (int i=0 ; i<[portfolioArray count] ; i++) {
        
        NSMutableDictionary * location = [[portfolioArray objectAtIndex:i]objectForKey:@"url"];

        [datatoPassHere addObject:location];
        
    }

    SecondViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                
                                instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    // Pass the selected object to the new view controller.
    
    wc.myDataFromFirst = datatoPassHere;
    
    [self.navigationController pushViewController:wc animated:YES];
    
}






@end
