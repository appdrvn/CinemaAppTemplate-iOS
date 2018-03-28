//
//  CinemaViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/20/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "CinemaViewController.h"
#import "CinemaModel.h"
#import "CinemaTableViewCell.h"
#import "CinemaDetailViewController.h"

@interface CinemaViewController ()

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation CinemaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [GeneralHelper setNavTitle:[NSString stringWithFormat:@"Cinema"] withNavItem:self.navigationItem];
    
    [self triggerManualRefresh];
}

- (BOOL)prefersStatusBarHidden
{
    return self.navigationController.isNavigationBarHidden;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CINEMA_VIEW_HEIGHT+5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CinemaTableViewCell class])];
    cell.backgroundColor = [UIColor clearColor];
    [cell updateDisplay:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"gotoCinemaDetailVC" sender:self];
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotoCinemaDetailVC"])
    {
        CinemaDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.cinemaModel = self.dataArray[self.selectedIndex];
    }
}

#pragma mark - Private
- (void) loadData
{
    CinemaModel *cinema1 = [CinemaModel new];
    cinema1.cinemaId = @"1";
    cinema1.name = @"KSL CITY, JOHOR BAHRU";
    cinema1.address = @"Cinema A LEVEL 2";
    cinema1.imageUrl = @"https://images.unsplash.com/photo-1505686994434-e3cc5abf1330?ixlib=rb-0.3.5&s=f87c34f8d6ad76aba3f1440508e6cf42&auto=format&fit=crop&w=200&q=80";
    cinema1.phoneNo = @"03-123123123";
    cinema1.latitude = 3.073237;
    cinema1.longitude = 101.606500;
    
    CinemaModel *cinema2 = [CinemaModel new];
    cinema2.cinemaId = @"2";
    cinema2.name = @"U MALL, SKUDAI";
    cinema2.address = @"Cinema B 1ST FLOOR, U-MALL SHOPPING COMPLEX, 45 JALAN PULAI UTAMA, 20, TAMAN PULAI UTAMA, 81110 SKUDAI, JOHOR";
    cinema2.imageUrl = @"https://images.unsplash.com/photo-1485095329183-d0797cdc5676?ixlib=rb-0.3.5&s=965d140de0f480b90363613fffe3ecb1&auto=format&fit=crop&w=200&q=80";
    cinema2.phoneNo = @"03-123123123";
    cinema2.latitude = 3.073237;
    cinema2.longitude = 101.606500;
    
    CinemaModel *cinema3 = [CinemaModel new];
    cinema3.cinemaId = @"3";
    cinema3.name = @"SQUARE ONE SHOPPING MALL, BATU PAHAT";
    cinema3.address = @"Cinema C LEVEL 3, SQUARE ONE SHOPPING MALL, JALAN FLORA UTAMA 4, TAMAN FLORA UTAMA, 83000 BATU PAHAT, JOHOR";
    cinema3.imageUrl = @"https://images.unsplash.com/photo-1513106580091-1d82408b8cd6?ixlib=rb-0.3.5&s=2c0ae0768dd5bda0328ccb8162be150f&auto=format&fit=crop&w=200&q=80";
    cinema3.phoneNo = @"03-123123123";
    cinema3.latitude = 3.073237;
    cinema3.longitude = 101.606500;
    
    CinemaModel *cinema4 = [CinemaModel new];
    cinema4.cinemaId = @"4";
    cinema4.name = @"HERITAGE MALL, KOTA TINGGI";
    cinema4.address = @"Cinema D HERITAGE MALL, JALAN WARISAN 3, 81900 KOTA TINGGI, JOHOR.";
    cinema4.imageUrl = @"https://images.unsplash.com/photo-1478720568477-152d9b164e26?ixlib=rb-0.3.5&s=37937acb13d989c510d0645cde73a388&auto=format&fit=crop&w=200&q=80";
    cinema4.phoneNo = @"03-123123123";
    cinema4.latitude = 3.073237;
    cinema4.longitude = 101.606500;
    
    CinemaModel *cinema5 = [CinemaModel new];
    cinema5.cinemaId = @"5";
    cinema5.name = @"KLUANG MALL, KLUANG";
    cinema5.address = @"Cinema E 2ND FLOOR, KLUANG MALL, JALAN RAMBUTAN, 86000 KLUANG";
    cinema5.imageUrl = @"https://images.unsplash.com/photo-1502033491742-0e11fb057e16?ixlib=rb-0.3.5&s=bc52f4fefff5245f500de04d7f1c811e&auto=format&fit=crop&w=200&q=80";
    cinema5.phoneNo = @"03-123123123";
    cinema5.latitude = 3.073237;
    cinema5.longitude = 101.606500;
    
    CinemaModel *cinema6 = [CinemaModel new];
    cinema6.cinemaId = @"6";
    cinema6.name = @"VIVA HOME, CHERAS";
    cinema6.address = @"Cinema F 3RD FLOOR, VIVA HOME, 85 JALAN LOKE YEW, 55200 KUALA LUMPUR";
    cinema6.imageUrl = @"https://images.unsplash.com/photo-1443741297594-4e8e351ba02f?ixlib=rb-0.3.5&s=aa879b9d535db70e2d59366b972cd157&auto=format&fit=crop&w=200&q=80";
    cinema6.phoneNo = @"03-123123123";
    cinema6.latitude = 3.073237;
    cinema6.longitude = 101.606500;
    
    CinemaModel *cinema7 = [CinemaModel new];
    cinema7.cinemaId = @"7";
    cinema7.name = @"SUBANG PARADE, SUBANG JAYA";
    cinema7.address = @"Cinema G FIRST FLOOR, SUBANG PARADE, NO. 5, JALAN SS 16/1, 47500 SUBANG JAYA, SELANGOR";
    cinema7.imageUrl = @"https://images.unsplash.com/photo-1519452635265-7b1fbfd1e4e0?ixlib=rb-0.3.5&s=a688a98cde4e4d0b53e5c93c29c38f85&auto=format&fit=crop&w=200&q=80";
    cinema7.phoneNo = @"03-123123123";
    cinema7.latitude = 3.073237;
    cinema7.longitude = 101.606500;
    
    CinemaModel *cinema8 = [CinemaModel new];
    cinema8.cinemaId = @"8";
    cinema8.name = @"SPACE U8, BUKIT JELUTONG";
    cinema8.address = @"Cinema H SPACE U8, NO 6, PERSIARAN PASAK BUMI, TAMAN BUKIT JELUTONG, SEKSYEN U8, 40150 SELANGOR";
    cinema8.imageUrl = @"https://images.unsplash.com/photo-1458053688450-eef5d21d43b3?ixlib=rb-0.3.5&s=e535df43ae0a54ec2bf5bd03a7eeeb52&auto=format&fit=crop&w=200&q=80";
    cinema8.phoneNo = @"03-123123123";
    cinema8.latitude = 3.073237;
    cinema8.longitude = 101.606500;
    
    // This method used to check for Load More
    [self finishLoadingDataFromCms:[NSArray arrayWithObjects:cinema1, cinema2, cinema3, cinema4, cinema5, cinema6, cinema7, cinema8, nil]];
}

- (void)finishLoadingDataFromCms:(NSArray *)results
{
    int limit = DEFAULT_TAKE;
    
    if ([results count] == 0)
    {
        self.canLoadMore = false;
        self.shouldShowNoDataImageViewAndLabel = YES;
        [self doneLoading];
        return;
    }
    else if([results count] == limit)
    {
        self.currentPage++;
        self.canLoadMore = true;
    }
    else
    {
        self.canLoadMore = false;
    }
    
    if (self.isLoadingMore)
    {
        NSMutableArray * temp = [[NSMutableArray alloc] initWithArray:self.dataArray];
        [temp addObjectsFromArray:results];
        self.dataArray = [NSArray arrayWithArray:temp];
    }
    else
    {
        self.dataArray = results;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self doneLoading];
        
        // You may do the empty data checking at here
    });
}


@end
