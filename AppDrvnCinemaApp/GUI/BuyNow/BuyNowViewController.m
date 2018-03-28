//
//  BuyNowViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 08/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "BuyNowViewController.h"
#import "BuyNowHeaderView.h"
#import "BuyNowTableViewCell.h"
#import "ChooseCalendarSectionView.h"
#import "ShowTimeModel.h"
#import "ChooseDateUIModel.h"
#import "CinemaDetailViewController.h"
#import "MovieDetailViewController.h"

@interface BuyNowViewController ()<ChooseCalendarSectionViewDelegate, BuyNowTableViewCellDelegate, BuyNowHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *buyNowTableView;
@property (strong, nonatomic) BuyNowHeaderView *headerView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *datesArray;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic) NSTimeInterval selectedTimeStamp;
@property (nonatomic, strong) NSIndexPath *selectedDateIndexPath;
@property (nonatomic) NSInteger selectedIndexCinema;

@end

@implementation BuyNowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.titleView = [GeneralHelper setNavTitle:[NSString stringWithFormat:@"%@", self.selectedMovieModel.name] withNavItem:self.navigationItem];
    [self.buyNowTableView registerNib:[UINib nibWithNibName:@"BuyNowTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuyNowTableViewCell"];
    [self.buyNowTableView registerNib:[UINib nibWithNibName:@"ChooseCalendarSectionView" bundle:nil] forCellReuseIdentifier:@"ChooseCalendarSectionView"];
    
    self.selectedTimeStamp = [[NSDate date] timeIntervalSince1970];
    self.selectedDate = [NSDate dateWithTimeIntervalSince1970:self.selectedTimeStamp];
    
    self.datesArray = [NSMutableArray new];
    for (int i=0; i<7; i++)
    {
        ChooseDateUIModel *model = [ChooseDateUIModel ChooseDateUIModelWithTimestamp:[[self.selectedDate dateByAddingTimeInterval:60*60*24*(i)] timeIntervalSince1970]];
        [self.datesArray addObject:model];
    }
    
    [self addHeaderView];
    [self loadData];
}

#pragma mark - UIButtons Actions
- (IBAction)backPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Add Header View
- (void) addHeaderView
{
    self.headerView = nil;
    self.headerView = [[BuyNowHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.buyNowTableView.frame.size.width, 120.0f)];
    self.headerView.delegate = self;
    [self.headerView updateDisplay:self.selectedMovieModel];
    
    self.buyNowTableView.tableHeaderView = self.headerView;
}

#pragma mark - BuyNowHeaderViewDelegate
- (void) BuyNowHeaderViewDelegateDidClickOn
{
    if (self.isFromMovieDetialVC)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self performSegueWithIdentifier:@"gotoMovieDetailVCFromBuyNow" sender:self];
    }
}

#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ChooseCalendarSectionView *sectionHeaderView = [[ChooseCalendarSectionView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50.0f)];
    sectionHeaderView.delegate = self;
    [sectionHeaderView updateDisplay:self.datesArray selectedDate:self.selectedDate];
    
    return sectionHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 122;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyNowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyNowTableViewCell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.currentIndex = indexPath.row;
    [cell updateDisplay:self.dataArray[indexPath.section][indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - ChooseCalendarSectionViewDelegate
- (void) ChooseCalendarSectionViewDelegateDidSelectedTimeStamp:(NSTimeInterval)selectedTimeStamp atIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTimeStamp = selectedTimeStamp;
    self.selectedDate = [GeneralHelper getDateFromTimestamp:selectedTimeStamp];
    self.selectedDateIndexPath = indexPath;
    
    NSLog(@"Choose Date to get Cinema list->%@->%ld", self.selectedDate, (long)self.selectedDateIndexPath.row);
    [self loadData];
}

#pragma mark - BuyNowTableViewCellDelegate
- (void) BuyNowTableViewCellDelegateDidSelectedTimeAtCellIndex:(NSInteger)cellIndex withSelected:(NSInteger)selected
{
    CinemaModel *cinema = (CinemaModel *)self.dataArray[0][cellIndex];
    ShowTimeModel *schedule = (ShowTimeModel *)cinema.showtimes[selected];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"(EEE) dd,MMM"];
    NSString *selectedDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[GeneralHelper getDateFromTimestamp:self.selectedTimeStamp]]];
    
    [GeneralHelper showAlertMsg:[NSString stringWithFormat:@"Please integrate your own Ticketing Sytem with choosing movie:\n%@ at %@, %@ [%@ %@]", self.selectedMovieModel.name, cinema.name, selectedDate, schedule.time, schedule.session]];
    
    // TODO: Integrate your own ticketing system
}

- (void) BuyNowTableViewCellDelegateDidClickCinemaAtCellIndex:(NSInteger)cellIndex
{
    self.selectedIndexCinema = cellIndex;
    [self performSegueWithIdentifier:@"gotoCinemaDetailVCFromBuyNow" sender:self];
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotoCinemaDetailVCFromBuyNow"])
    {
        CinemaDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.cinemaModel = self.dataArray[0][self.selectedIndexCinema];
    }
    else if ([segue.identifier isEqualToString:@"gotoMovieDetailVCFromBuyNow"])
    {
        MovieDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.isFromCinemaVC = YES;
        destinationVC.selectedMovieModel = self.selectedMovieModel;
    }
}

#pragma mark - Private
- (void) loadData
{
    // TODO: call the API to get the Cinema list by the selected Time Stamp
    
    // Dummy Data
    // Schedules
    ShowTimeModel *schedule1 = [ShowTimeModel new];
    schedule1.showtimeId = @"1";
    schedule1.time = @"10.30";
    schedule1.session = @"AM";
    
    ShowTimeModel *schedule2 = [ShowTimeModel new];
    schedule2.showtimeId = @"2";
    schedule2.time = @"12.30";
    schedule2.session = @"PM";
    
    ShowTimeModel *schedule3 = [ShowTimeModel new];
    schedule3.showtimeId = @"3";
    schedule3.time = @"12.45";
    schedule3.session = @"PM";
    
    ShowTimeModel *schedule4 = [ShowTimeModel new];
    schedule4.showtimeId = @"4";
    schedule4.time = @"1.45";
    schedule4.session = @"PM";
    
    ShowTimeModel *schedule5 = [ShowTimeModel new];
    schedule5.showtimeId = @"5";
    schedule5.time = @"6.45";
    schedule5.session = @"PM";
    
    ShowTimeModel *schedule6 = [ShowTimeModel new];
    schedule6.showtimeId = @"6";
    schedule6.time = @"8.45";
    schedule6.session = @"PM";
    
    // Cinema Model
    CinemaModel *cinema1 = [CinemaModel new];
    cinema1.cinemaId = @"1";
    cinema1.name = @"KSL CITY, JOHOR BAHRU";
    cinema1.address = @"Cinema A LEVEL 2";
    cinema1.imageUrl = @"https://images.unsplash.com/photo-1505686994434-e3cc5abf1330?ixlib=rb-0.3.5&s=f87c34f8d6ad76aba3f1440508e6cf42&auto=format&fit=crop&w=200&q=80";
    cinema1.phoneNo = @"03-123123123";
    cinema1.latitude = 3.073237;
    cinema1.longitude = 101.606500;
    cinema1.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule4, schedule5, nil];
    
    CinemaModel *cinema2 = [CinemaModel new];
    cinema2.cinemaId = @"2";
    cinema2.name = @"U MALL, SKUDAI";
    cinema2.address = @"Cinema B 1ST FLOOR, U-MALL SHOPPING COMPLEX, 45 JALAN PULAI UTAMA, 20, TAMAN PULAI UTAMA, 81110 SKUDAI, JOHOR";
    cinema2.imageUrl = @"https://images.unsplash.com/photo-1485095329183-d0797cdc5676?ixlib=rb-0.3.5&s=965d140de0f480b90363613fffe3ecb1&auto=format&fit=crop&w=200&q=80";
    cinema2.phoneNo = @"03-123123123";
    cinema2.latitude = 3.073237;
    cinema2.longitude = 101.606500;
    cinema2.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule4, schedule5, nil];
    
    CinemaModel *cinema3 = [CinemaModel new];
    cinema3.cinemaId = @"3";
    cinema3.name = @"SQUARE ONE SHOPPING MALL, BATU PAHAT";
    cinema3.address = @"Cinema C LEVEL 3, SQUARE ONE SHOPPING MALL, JALAN FLORA UTAMA 4, TAMAN FLORA UTAMA, 83000 BATU PAHAT, JOHOR";
    cinema3.imageUrl = @"https://images.unsplash.com/photo-1513106580091-1d82408b8cd6?ixlib=rb-0.3.5&s=2c0ae0768dd5bda0328ccb8162be150f&auto=format&fit=crop&w=200&q=80";
    cinema3.phoneNo = @"03-123123123";
    cinema3.latitude = 3.073237;
    cinema3.longitude = 101.606500;
    cinema3.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule4, schedule5, nil];
    
    CinemaModel *cinema4 = [CinemaModel new];
    cinema4.cinemaId = @"4";
    cinema4.name = @"HERITAGE MALL, KOTA TINGGI";
    cinema4.address = @"Cinema D HERITAGE MALL, JALAN WARISAN 3, 81900 KOTA TINGGI, JOHOR.";
    cinema4.imageUrl = @"https://images.unsplash.com/photo-1478720568477-152d9b164e26?ixlib=rb-0.3.5&s=37937acb13d989c510d0645cde73a388&auto=format&fit=crop&w=200&q=80";
    cinema4.phoneNo = @"03-123123123";
    cinema4.latitude = 3.073237;
    cinema4.longitude = 101.606500;
    cinema4.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule4, schedule5, nil];
    
    CinemaModel *cinema5 = [CinemaModel new];
    cinema5.cinemaId = @"5";
    cinema5.name = @"KLUANG MALL, KLUANG";
    cinema5.address = @"Cinema E 2ND FLOOR, KLUANG MALL, JALAN RAMBUTAN, 86000 KLUANG";
    cinema5.imageUrl = @"https://images.unsplash.com/photo-1502033491742-0e11fb057e16?ixlib=rb-0.3.5&s=bc52f4fefff5245f500de04d7f1c811e&auto=format&fit=crop&w=200&q=80";
    cinema5.phoneNo = @"03-123123123";
    cinema5.latitude = 3.073237;
    cinema5.longitude = 101.606500;
    cinema5.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule5, nil];
    
    CinemaModel *cinema6 = [CinemaModel new];
    cinema6.cinemaId = @"6";
    cinema6.name = @"VIVA HOME, CHERAS";
    cinema6.address = @"Cinema F 3RD FLOOR, VIVA HOME, 85 JALAN LOKE YEW, 55200 KUALA LUMPUR";
    cinema6.imageUrl = @"https://images.unsplash.com/photo-1443741297594-4e8e351ba02f?ixlib=rb-0.3.5&s=aa879b9d535db70e2d59366b972cd157&auto=format&fit=crop&w=200&q=80";
    cinema6.phoneNo = @"03-123123123";
    cinema6.latitude = 3.073237;
    cinema6.longitude = 101.606500;
    cinema6.showtimes = [NSArray arrayWithObjects:schedule1, schedule4, schedule5, nil];
    
    CinemaModel *cinema7 = [CinemaModel new];
    cinema7.cinemaId = @"7";
    cinema7.name = @"SUBANG PARADE, SUBANG JAYA";
    cinema7.address = @"Cinema G FIRST FLOOR, SUBANG PARADE, NO. 5, JALAN SS 16/1, 47500 SUBANG JAYA, SELANGOR";
    cinema7.imageUrl = @"https://images.unsplash.com/photo-1519452635265-7b1fbfd1e4e0?ixlib=rb-0.3.5&s=a688a98cde4e4d0b53e5c93c29c38f85&auto=format&fit=crop&w=200&q=80";
    cinema7.phoneNo = @"03-123123123";
    cinema7.latitude = 3.073237;
    cinema7.longitude = 101.606500;
    cinema7.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule4, nil];
    
    CinemaModel *cinema8 = [CinemaModel new];
    cinema8.cinemaId = @"8";
    cinema8.name = @"SPACE U8, BUKIT JELUTONG";
    cinema8.address = @"Cinema H SPACE U8, NO 6, PERSIARAN PASAK BUMI, TAMAN BUKIT JELUTONG, SEKSYEN U8, 40150 SELANGOR";
    cinema8.imageUrl = @"https://images.unsplash.com/photo-1458053688450-eef5d21d43b3?ixlib=rb-0.3.5&s=e535df43ae0a54ec2bf5bd03a7eeeb52&auto=format&fit=crop&w=200&q=80";
    cinema8.phoneNo = @"03-123123123";
    cinema8.latitude = 3.073237;
    cinema8.longitude = 101.606500;
    cinema8.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, nil];
    
    NSMutableArray *temp = [NSMutableArray new];
    [temp addObject:@[cinema1, cinema2, cinema3, cinema4, cinema5, cinema6, cinema7, cinema8]];
    
    self.dataArray = [NSArray arrayWithArray:temp];
    [self.buyNowTableView reloadData];
    
    // Scroll to the selected Date animation
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNOTIFICATION_CENTER_MOVE_COLLECTIONVIEW" object:self.selectedDateIndexPath];
    });
}
@end
