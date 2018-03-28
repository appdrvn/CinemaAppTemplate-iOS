//
//  CinemaDetailViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/24/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "CinemaDetailViewController.h"
#import "CinemaDetailTableViewCell.h"
#import "ChooseCalendarSectionView.h"
#import "MovieModel.h"
#import "GenreModel.h"
#import "SubtitleModel.h"
#import "ShowTimeModel.h"
#import "MovieDetailViewController.h"
#import "ChooseDateUIModel.h"

@interface CinemaDetailViewController ()<ChooseCalendarSectionViewDelegate, CinemaDetailTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *datesArray;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic) NSTimeInterval selectedTimeStamp;
@property (nonatomic, strong) NSIndexPath *selectedDateIndexPath;

@end

@implementation CinemaDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.titleView = [GeneralHelper setNavTitle:[NSString stringWithFormat:@"%@", self.cinemaModel.name] withNavItem:self.navigationItem];
    
    [self.detailTableView registerNib:[UINib nibWithNibName:@"CinemaDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"CinemaDetailTableViewCell"];
    [self.detailTableView registerNib:[UINib nibWithNibName:@"ChooseCalendarSectionView" bundle:nil] forCellReuseIdentifier:@"ChooseCalendarSectionView"];
    
    self.selectedTimeStamp = [[NSDate date] timeIntervalSince1970];
    self.selectedDate = [NSDate dateWithTimeIntervalSince1970:self.selectedTimeStamp];
    
    self.datesArray = [NSMutableArray new];
    for (int i=0; i<7; i++)
    {
        ChooseDateUIModel *model = [ChooseDateUIModel ChooseDateUIModelWithTimestamp:[[self.selectedDate dateByAddingTimeInterval:60*60*24*(i)] timeIntervalSince1970]];
        [self.datesArray addObject:model];
    }
    [self loadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return self.navigationController.isNavigationBarHidden;
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
    CinemaDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CinemaDetailTableViewCell"];
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

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotoMovieDetailVCFromCinemaDetail"])
    {
        MovieDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.isFromCinemaVC = YES;
        destinationVC.selectedMovieModel = self.dataArray[0][self.selectedIndex];
    }
}

#pragma mark - CinemaDetailTableViewCellDelegate
- (void) CinemaDetailTableViewCellDelegateDidClickAtIndex:(NSInteger)index
{
    self.selectedIndex = index;
    [self performSegueWithIdentifier:@"gotoMovieDetailVCFromCinemaDetail" sender:self];
}

- (void) CinemaDetailTableViewCellDelegateDidSelectedTimeAtCellIndex:(NSInteger)cellIndex withSelected:(NSInteger)selected
{
    MovieModel *movie = (MovieModel *)self.dataArray[0][cellIndex];
    ShowTimeModel *schedule = (ShowTimeModel *)movie.showtimes[selected];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"(EEE) dd,MMM"];
    NSString *selectedDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[GeneralHelper getDateFromTimestamp:self.selectedTimeStamp]]];

    [GeneralHelper showAlertMsg:[NSString stringWithFormat:@"Please integrate your own Ticketing Sytem with choosing movie:\n%@ at %@, %@ [%@ %@]", movie.name, self.cinemaModel.name, selectedDate, schedule.time, schedule.session]];
    
    // TODO: Integrate your own ticketing system
}

#pragma mark - UIButtons Actions
- (IBAction)backPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)phonePressed:(id)sender
{
    [self phoneCallTo:self.cinemaModel.phoneNo];
}

- (IBAction)navigatorPressed:(id)sender
{
    [self openNaviTo:self.cinemaModel];
}

#pragma mark - Private
- (void) loadData
{
    // TODO: call the API to get the Movie list by the selected Time Stamp
    
    // Dummy Data
    // Genres
    GenreModel *genre1 = [GenreModel new];
    genre1.genreId = @"1";
    genre1.name = @"Crime";
    
    GenreModel *genre2 = [GenreModel new];
    genre2.genreId = @"2";
    genre2.name = @"Drama";
    
    GenreModel *genre3 = [GenreModel new];
    genre3.genreId = @"3";
    genre3.name = @"Mystery";
    
    GenreModel *genre4 = [GenreModel new];
    genre4.genreId = @"4";
    genre4.name = @"Action";
    
    // Subtitles
    SubtitleModel *subtitle1 = [SubtitleModel new];
    subtitle1.subtitleId = @"1";
    subtitle1.name = @"Malay";
    
    SubtitleModel *subtitle2 = [SubtitleModel new];
    subtitle2.subtitleId = @"2";
    subtitle2.name = @"Chinese";
    
    SubtitleModel *subtitle3 = [SubtitleModel new];
    subtitle3.subtitleId = @"3";
    subtitle3.name = @"English";
    
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
    
    // Movies
    MovieModel *movie1 = [MovieModel new];
    movie1.movieId = @"1";
    movie1.name = @"The Commuter";
    movie1.imageUrl = @"https://assets.voxcinemas.com/posters/P_HO00005017.jpg";
    movie1.trailerUrl = @"https://www.youtube.com/embed/p7uxHhZxdsQ";
    movie1.releaseDate = @"11 Jan 2018";
    movie1.language = @"English";
    movie1.subtitles = [NSArray arrayWithObjects:subtitle1, subtitle2, nil];
    movie1.genres = [NSArray arrayWithObjects:genre1, genre2, genre3, nil];
    movie1.runningTime = @"106 minutes";
    movie1.director = @"Jaume Collet-Serra";
    movie1.distributor = @"20TH CENTURY FOX";
    movie1.cast = @"Liam Neeson, Vera Farmiga, Sam Neill, Patrick Wilson";
    movie1.synopsis = @"In this action-packed thriller, Liam Neeson plays an insurance salesman, Michael, on his daily commute home, which quickly becomes anything but routine. After being contacted by a mysterious stranger, Michael is forced to uncover the identity of a hidden passenger on his train before the last stop. As he works against the clock to solve the puzzle, he realizes a deadly plan is unfolding and is unwittingly caught up in a criminal conspiracy. One that carries life and death stakes, for himself and his fellow passengers.";
    movie1.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule4, schedule5, nil];
    
    MovieModel *movie2 = [MovieModel new];
    movie2.movieId = @"2";
    movie2.name = @"Crystal Inferno";
    movie2.imageUrl = @"http://www.cinema.com.my/images/movies/2018/7crystalinferno00_450.jpg";
    movie2.trailerUrl = @"https://www.youtube.com/embed/XK1ohcwiSbU";
    movie2.releaseDate = @"11 Jan 2018";
    movie2.language = @"English";
    movie2.subtitles = [NSArray arrayWithObjects:subtitle1, subtitle2, subtitle3, nil];
    movie2.genres = [NSArray arrayWithObjects:genre1, genre2, genre4, nil];
    movie2.runningTime = @"93 minutes";
    movie2.director = @"Eric Summer";
    movie2.distributor = @"Mega Films Distribution Sdn Bhd";
    movie2.synopsis = @"At the 20th floor of a skyscraper, a gas leak has started a fire. Anne and Ben Bronson, two teenage kids, are trapped in a fire inferno 20 storeys above the ground, while the fire is spreading throughout the entire building. From the 60th floor, their parents, Brianna and Tom, who were about to sign their divorce papers, will have to fight together to save their family from the flames. Even if Brianna is a brilliant structural engineer, will she find out a way to stop this uncontrolled fire?";
    movie2.showtimes = [NSArray arrayWithObjects:schedule1, nil];
    
    MovieModel *movie3 = [MovieModel new];
    movie3.movieId = @"3";
    movie3.name = @"Maze Runner: The Death Cure";
    movie3.imageUrl = @"https://assets.voxcinemas.com/posters/P_HO00005023.jpg";
    //    movie3.trailerUrl = @"";
    movie3.releaseDate = @"25 Jan 2018";
    movie3.language = @"English";
    //    movie3.subtitles = [NSArray arrayWithObjects:subtitle1, subtitle2, nil];
    movie3.genres = [NSArray arrayWithObjects:genre1, genre3, nil];
    movie3.runningTime = @"141 minutes";
    movie3.director = @"Wes Ball";
    movie3.distributor = @"20TH CENTURY FOX";
    movie3.synopsis = @"In the epic finale to the Maze Runner saga, Thomas leads his group of escapedGladers on their final and most dangerous mission yet. To save their friends, they must break into the legendary Last City, a WCKD-controlled labyrinth that may turn out to be the deadliest maze of all. Anyone who makes it out alive will get answers to the questions the Gladers have been asking since they first arrived in the maze.";
    movie3.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule4, schedule5, nil];
    
    MovieModel *movie4 = [MovieModel new];
    movie4.movieId = @"4";
    movie4.name = @"Along With The Gods: The Two Worlds";
    movie4.imageUrl = @"http://www.cinema.com.hk/cmsimg/cinweb/movie/movie_1515471622.jpg";
    movie4.trailerUrl = @"https://www.youtube.com/embed/sD7dmu-IWNw";
    movie4.releaseDate = @"18 Jan 2018";
    movie4.language = @"Korean";
    movie4.subtitles = [NSArray arrayWithObjects:subtitle1, subtitle2, subtitle3, nil];
    movie4.genres = [NSArray arrayWithObjects:genre3, nil];
    movie4.runningTime = @"139 minutes";
    movie4.director = @"KIM Yong-hwa";
    movie4.distributor = @"ATriNaga Sdn Bhd";
    movie4.cast = @"KIM Yong-hwa, HA Jung-woo, CHA Tae-hyun, JU Ji-hoon, KIM Hyang-gi, LEE Jung-jae, DOH Kyung-soo, Don LEE";
    movie4.synopsis = @"Having died unexpectedly, firefighter Ja-hong is taken to the afterlife by 3 afterlife guardians.\n\nOnly when he passes 7 trials over 49 days and proves he was innocent in human life, he’s able to reincarnate, and his 3 afterlife guardians are by his side to defend him in trial.";
    movie4.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule5, nil];
    
    MovieModel *movie5 = [MovieModel new];
    movie5.movieId = @"5";
    movie5.name = @"Namiya 解忧杂货店";
    movie5.imageUrl = @"https://cdn.eventcinemas.com.au/cdn/resources/movies/11703/images/largeposter.jpg";
    movie5.trailerUrl = @"https://www.youtube.com/embed/jK5gp12iwr8";
    movie5.releaseDate = @"18 Jan 2018";
    movie5.language = @"Mandarin";
    movie5.subtitles = [NSArray arrayWithObjects:subtitle1, subtitle2, nil];
    movie5.genres = [NSArray arrayWithObjects:genre1, genre2, genre3, nil];
    movie5.runningTime = @"110 minutes";
    movie5.director = @"Han Jie";
    movie5.distributor = @"GSC Movies";
    movie5.cast = @"Karry Wang, Dilraba, Dong Zijian, Lee Hong-chi";
    movie5.synopsis = @"The film is adapted from the best-selling Japanese novel “The Miracles of the Namiya General Store” by Keigo Higashino (writer of White Night, Suspect X). Three orphans on the lam take refuge in a derelict dime store and find time barriers shattered when they receive a letter seeking advice from 1993.";
    movie5.showtimes = [NSArray arrayWithObjects:schedule1, schedule4, schedule5, nil];
    
    MovieModel *movie6 = [MovieModel new];
    movie6.movieId = @"6";
    movie6.name = @"12 Strong";
    movie6.imageUrl = @"http://media.socastsrm.com/wordpress/wp-content/blogs.dir/993/files/2017/12/12S_400x522_IT.jpg";
    movie6.trailerUrl = @"https://www.youtube.com/embed/FCcdpJBy30w";
    movie6.releaseDate = @"18 Jan 2018";
    movie6.language = @"English";
    movie6.subtitles = [NSArray arrayWithObjects:subtitle1, subtitle2, nil];
    movie6.genres = [NSArray arrayWithObjects:genre1, genre2, genre3, nil];
    movie6.runningTime = @"131 minutes";
    movie6.director = @"Nicolai Fuglsig";
    movie6.distributor = @"TGVP";
    movie6.cast = @"Chris Hemsworth, Elsa Pataky, William Fichtner, Michael Shannon";
    movie6.synopsis = @"12 Strong tells the story of the first Special Forces team deployed to Afghanistan after 9/11; under the leadership of a new captain, the team must work with an Afghan warlord to take down the Taliban.";
    movie6.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule4, nil];
    
    MovieModel *movie7 = [MovieModel new];
    movie7.movieId = @"8";
    movie7.name = @"Den of Thieves";
    movie7.imageUrl = @"https://assets.voxcinemas.com/posters/P_HO00005080.jpg";
    movie7.trailerUrl = @"https://youtu.be/WFTNhN8RA7M";
    movie7.releaseDate = @"11 Jan 2018";
    movie7.language = @"English";
    movie7.subtitles = [NSArray arrayWithObjects:subtitle1, subtitle2, nil];
    movie7.genres = [NSArray arrayWithObjects:genre1, genre2, genre3, nil];
    movie7.runningTime = @"140 minutes";
    movie7.director = @"Christian Gudegast";
    movie7.distributor = @"GSC Movies";
    movie7.cast = @"Gerard Butler, Pablo Schreiber, Sonya Balmores";
    movie7.synopsis = @"While planning a bank heist, a thief gets trapped between two sets of criminals.";
    movie7.showtimes = [NSArray arrayWithObjects:schedule1, schedule3, schedule4, schedule5, nil];
    
    MovieModel *movie8 = [MovieModel new];
    movie8.movieId = @"8";
    movie8.name = @"Net-I-Die";
    movie8.imageUrl = @"http://www.cinema.com.my/images/movies/2017/7netidie00_450.jpg";
    movie8.trailerUrl = @"https://www.youtube.com/embed/QWAilGS04gc";
    movie8.releaseDate = @"11 Jan 2018";
    movie8.language = @"Thai";
    movie8.subtitles = [NSArray arrayWithObjects:subtitle1, subtitle2, nil];
    movie8.genres = [NSArray arrayWithObjects:genre1, genre2, genre3, nil];
    movie8.runningTime = @"86 minutes";
    movie8.director = @"Preedee Veeratum, Nuttachai Jiraanont";
    movie8.distributor = @"GSC Movies";
    movie8.cast = @"Pitt Karchai, Sarunthorn Klaiudom, Chicha Amattayakul, Patara Eksangkul";
    movie8.synopsis = @"One year after the mysterious death of the country’s renowned Net Idol “Monica” (Kitty-CHICHA AMATTAYAKUL) a video of her death went viral online. Attached to video was a horrifying hashtag, listing the names of multiple Net Idols.\n\nOne of those names,“Malisa” (Mean-SARUNTHORN KLAIUDOM), the owner of a famous makeup brand, started encountering strange incidents. The others that were tagged started dying one by one which made “Jak” (PITT KARCHAI), Malisa’s boyfriend, determined to know the truth behind what had happened. Jak needed to investigate the situation for himself. Will Malisa be able to make it out alive? How can Jak help his girlfriend? Hurry up and come be surprised by horrors beyond your wildest imagination!!!";
    movie8.showtimes = [NSArray arrayWithObjects:schedule1, schedule2, schedule3, schedule4, schedule5, schedule6, nil];
    
    NSMutableArray *temp2 = [NSMutableArray new];
    [temp2 addObject:@[movie1, movie2, movie3, movie4, movie5, movie6, movie7, movie8]];
    self.dataArray = [NSArray arrayWithArray:temp2];
    [self.detailTableView reloadData];
    
    // Scroll to the selected Date animation
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNOTIFICATION_CENTER_MOVE_COLLECTIONVIEW" object:self.selectedDateIndexPath];
    });
}

- (void) openNaviTo:(CinemaModel *)cinemaModel
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Get Direction" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Google Map" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [GeneralHelper navigateToGoogleMapWithLatitude:cinemaModel.latitude longitude:cinemaModel.longitude];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Waze" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [GeneralHelper navigateToLatitude:cinemaModel.latitude longitude:cinemaModel.longitude];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void) phoneCallTo:(NSString *)mobileNumber
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", mobileNumber]]];
}

@end
