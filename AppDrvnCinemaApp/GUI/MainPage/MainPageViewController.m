//
//  MainPageViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/20/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MainPageViewController.h"
#import "MovieModel.h"
#import "GenreModel.h"
#import "SubtitleModel.h"
#import "MovieCollectionViewCell.h"
#import "LCBannerView.h"
#import "MovieDetailViewController.h"
#import "BannerModel.h"
#import "BuyNowViewController.h"
#import "PreviewViewController.h"
#import "MZFormSheetPresentationViewController.h"
#import "MZFormSheetPresentationViewControllerSegue.h"

@interface MainPageViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, LCBannerViewDelegate, PreviewViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *movieCollectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *banners;
@property (weak, nonatomic) IBOutlet UIView *topPartView;
@property (nonatomic) NSInteger selectedIndex;
@property (weak, nonatomic) IBOutlet UIView *statusBarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusBarViewHeight;
@property (nonatomic, strong) MZFormSheetPresentationViewController *formSheet;
@property (nonatomic) BOOL isPreviewOpenned;

@end

@implementation MainPageViewController

- (void) layoutSetup
{
    self.topPartView.backgroundColor = [UIColor clearColor];
    self.movieCollectionView.backgroundColor = [UIColor clearColor];
    
    self.statusBarView.backgroundColor = [UIColor appThemeColor];
    if ([GeneralHelper isDeviceiPhoneX])
    {
        self.statusBarViewHeight.constant = 60.0f;
    }
    else
    {
        self.statusBarViewHeight.constant = 20.0f;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [GeneralHelper setNavTitle:[NSString stringWithFormat:@"What's Hot"] withNavItem:self.navigationItem];
    
    [self layoutSetup];
    [self.movieCollectionView registerNib:[UINib nibWithNibName:@"MovieCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MovieCollectionViewCell"];
    
    [self loadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.isPreviewOpenned)
    {
        [self.formSheet dismissViewControllerAnimated:YES completion:^{
            self.isPreviewOpenned = NO;
        }];
    }
}

#pragma mark UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [cell updateDisplay:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [self openPreview];
}

- (CGSize)fillSizeArray:(int)index
{
    float height = [UIScreen mainScreen].bounds.size.height - BANNER_VIEW_HEIGHT - 64 - 64;
    if ([GeneralHelper isDeviceiPhoneX])
    {
        height = [UIScreen mainScreen].bounds.size.height - BANNER_VIEW_HEIGHT - 20 - 64 - 64 - 40;
    }
    float width = (height * 14) / 17;
    
    return CGSizeMake(width/1.3, height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fillSizeArray:(int)indexPath.row];
}

#pragma mark - Open Preview VC
- (void) openPreview
{
    if (self.isPreviewOpenned)
    {
        [self.formSheet dismissViewControllerAnimated:YES completion:^{
            self.isPreviewOpenned = NO;
        }];
    }
    
    PreviewViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PreviewViewController"];
    vc.delegate = self;
    vc.selectedMovieModel = [MovieModel new];
    vc.selectedMovieModel = (MovieModel *)self.dataArray[self.selectedIndex];
    
    self.formSheet = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:vc];
    self.formSheet.allowDismissByPanningPresentedView = YES;
    self.formSheet.presentationController.backgroundColor = [UIColor clearColor];
    self.formSheet.presentationController.transparentTouchEnabled = YES;
    self.formSheet.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideAndBounceFromTop;
    self.formSheet.presentationController.movementActionWhenKeyboardAppears = MZFormSheetActionWhenKeyboardAppearsMoveToTop;
    self.formSheet.presentationController.contentViewSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, BANNER_VIEW_HEIGHT+20); // or pass in UILayoutFittingCompressedSize to size automatically with auto-layout
    self.formSheet.presentationController.frameConfigurationHandler = ^CGRect(UIView * _Nonnull presentedView, CGRect currentFrame, BOOL isKeyboardVisible) {
        return CGRectMake(0, 20, currentFrame.size.width, currentFrame.size.height);
    };
    
    [self presentViewController:self.formSheet animated:YES completion:^{
        self.isPreviewOpenned = YES;
    }];
}

#pragma mark - PreviewViewControllerDelegate
- (void) PreviewViewControllerDelegateDidClickOnBuyNow
{
    [self.formSheet dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"gotoBuyNowVC" sender:self];
    }];
}

- (void) PreviewViewControllerDelegateDidClickOnMoreInfo
{
    [self.formSheet dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"gotoMovieDetailVCFromMainPage" sender:self];
    }];
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotoMovieDetailVCFromMainPage"])
    {
        MovieDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.selectedMovieModel = self.dataArray[self.selectedIndex];
    }
    else if ([segue.identifier isEqualToString:@"gotoBuyNowVC"])
    {
        BuyNowViewController *destinationVC = segue.destinationViewController;
        destinationVC.selectedMovieModel = self.dataArray[self.selectedIndex];
    }
}

#pragma mark - LCBannerViewDelegate
- (void) bannerView:(LCBannerView *)bannerView didClickedImageIndex:(NSInteger)index
{
    BannerModel *bannerModel = (BannerModel *)self.banners[index];
    [GeneralHelper openBrowserInUrl:bannerModel.link];
}

#pragma mark - Private
- (void) loadData
{
    // Banner
    BannerModel *banner1 = [BannerModel new];
    banner1.bannerId = @"1";
    banner1.imageUrl = @"https://images.unsplash.com/photo-1505489435671-80a165c60816?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=af3fb5171edc0c520c99c8061510f4b8&auto=format&fit=crop&w=500&q=80";
    banner1.link = @"https://www.google.com";
    
    BannerModel *banner2 = [BannerModel new];
    banner2.bannerId = @"2";
    banner2.imageUrl = @"https://images.unsplash.com/photo-1509347528160-9a9e33742cdb?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=0c4f2a14750d20448e999ea905502d4b&auto=format&fit=crop&w=500&q=80";
    banner2.link = @"https://www.google.com";
    
    BannerModel *banner3 = [BannerModel new];
    banner3.bannerId = @"3";
    banner3.imageUrl = @"https://images.unsplash.com/photo-1432139523732-e9d8af332501?ixlib=rb-0.3.5&s=005d6e1ffa209928b2e59976e896e96d&auto=format&fit=crop&w=500&q=80";
    banner3.link = @"https://www.google.com";
    
    self.banners = [NSMutableArray new];
    [self.banners addObjectsFromArray:@[banner1, banner2, banner3]];
    
    NSMutableArray *temp = [NSMutableArray new];
    for (BannerModel *model in self.banners)
    {
        [temp addObject:model.imageUrl];
    }
    
    LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, BANNER_VIEW_HEIGHT)
                                                        delegate:self
                                                       imageURLs:temp
                                                placeholderImage:@"placeholder.png"
                                                   timerInterval:4.0f
                                   currentPageIndicatorTintColor:[UIColor clearColor]
                                          pageIndicatorTintColor:[UIColor clearColor]];
    bannerView.backgroundColor = [UIColor whiteColor];
    
    [self.topPartView addSubview:bannerView];
    
    
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
    movie3.cast = @"In the epic finale to the Maze Runner saga, Thomas leads his group of escapedGladers on their final and most dangerous mission yet. To save their friends, they must break into the legendary Last City, a WCKD-controlled labyrinth that may turn out to be the deadliest maze of all. Anyone who makes it out alive will get answers to the questions the Gladers have been asking since they first arrived in the maze.";
    
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
    
    MovieModel *movie7 = [MovieModel new];
    movie7.movieId = @"8";
    movie7.name = @"Den of Thieves";
    movie7.imageUrl = @"https://assets.voxcinemas.com/posters/P_HO00005080.jpg";
    movie7.trailerUrl = @"https://www.youtube.com/embed/WFTNhN8RA7M";
    movie7.releaseDate = @"11 Jan 2018";
    movie7.language = @"English";
    movie7.subtitles = [NSArray arrayWithObjects:subtitle1, subtitle2, nil];
    movie7.genres = [NSArray arrayWithObjects:genre1, genre2, genre3, nil];
    movie7.runningTime = @"140 minutes";
    movie7.director = @"Christian Gudegast";
    movie7.distributor = @"GSC Movies";
    movie7.cast = @"Gerard Butler, Pablo Schreiber, Sonya Balmores";
    movie7.synopsis = @"While planning a bank heist, a thief gets trapped between two sets of criminals.";
    
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
    
    self.dataArray = @[movie1, movie2, movie3, movie4, movie5, movie6, movie7, movie8];
}

@end
