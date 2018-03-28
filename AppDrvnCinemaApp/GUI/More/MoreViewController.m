//
//  MoreViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/20/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreUIModel.h"
#import "MoreTableViewCell.h"

@interface MoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *moreTableView;

@end

@implementation MoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [GeneralHelper setNavTitle:[NSString stringWithFormat:@"More"] withNavItem:self.navigationItem];
    
    [self createData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreTableViewCell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateDisplay:self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"gotoAboutPageVC" sender:self];
}

#pragma mark - Private
- (void) createData
{
    MoreUIModel *aboutUs = [MoreUIModel MoreUIModelWithTitle:@"About"];
    
    self.dataArray = [NSMutableArray new];
    [self.dataArray addObjectsFromArray:@[aboutUs]];
    [self.moreTableView reloadData];
}

@end
