//
//  MovieDetailViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/24/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieDetailUIModel.h"
#import "MovieTitleTableViewCell.h"
#import "MovieInfoTableViewCell.h"
#import "MovieSynopsisTableViewCell.h"
#import "SubtitleModel.h"
#import "GenreModel.h"
#import "UIScrollView+VGParallaxHeader.h"
#import "MovieDetailHeaderView.h"
#import "MZFormSheetPresentationViewController.h"
#import "MZFormSheetPresentationViewControllerSegue.h"
#import "BuyNowViewController.h"

@interface MovieDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *infos;
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) MovieDetailHeaderView *headerView;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.titleView = [GeneralHelper setNavTitle:[NSString stringWithFormat:@"%@", self.selectedMovieModel.name] withNavItem:self.navigationItem];
    
    [self createData];
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

#pragma mark - Set TableView Header View
- (void) addHeaderView
{
    self.headerView = nil;
    self.headerView = [[MovieDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.detailTableView.frame.size.width, CINEMA_VIEW_HEIGHT+20)];
    self.headerView.view.backgroundColor = [UIColor blackColor];
    [self.headerView updateDisplay:self.selectedMovieModel.trailerUrl];
    [self.detailTableView setParallaxHeaderView:self.headerView
                                           mode:VGParallaxHeaderModeTopFill
                                         height:self.headerView.frame.size.height];
}

#pragma mark - UIButtons Actions
- (IBAction)backPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sharePressed:(id)sender
{
    // Movie Name
    NSString *shareText = [NSString stringWithFormat:@"%@", self.selectedMovieModel.name];
    
    // Movie Trailer
    NSURL *trailerUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", self.selectedMovieModel.trailerUrl]];
    
    NSArray *objectsToShare = @[shareText, trailerUrl];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)buyTicketPressed:(id)sender
{
    if (self.isFromCinemaVC)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
//        [self openOptionsVC];
        [self performSegueWithIdentifier:@"gotoBuyNowVCFromMovieDetail" sender:self];
    }
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailUIModel *model = (MovieDetailUIModel *)self.infos[indexPath.row];
    switch (model.cellType)
    {
        case MovieDetailCellTypesTitle:
        {
            NSString *reuseIdentifier = NSStringFromClass([MovieTitleTableViewCell class]);
            
            MovieTitleTableViewCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
            if(cell == nil)
            {
                cell = (MovieTitleTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            }
            [cell updateDisplay:self.infos[indexPath.row]];
            
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
            
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            
            CGFloat height = 0.0;
            height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            
            height += 1;
            
            return height;
        }
            break;
            
        case MovieDetailCellTypesInfo:
        {
            NSString *reuseIdentifier = NSStringFromClass([MovieInfoTableViewCell class]);
            
            MovieInfoTableViewCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
            if(cell == nil)
            {
                cell = (MovieInfoTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            }
            [cell updateDisplay:self.infos[indexPath.row]];
            
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
            
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            
            CGFloat height = 0.0;
            height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            
            height += 1;
            
            return height;
        }
            break;
            
        case MovieDetailCellTypesSynopsis:
        {
            NSString *reuseIdentifier = NSStringFromClass([MovieSynopsisTableViewCell class]);
            
            MovieSynopsisTableViewCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
            if(cell == nil)
            {
                cell = (MovieSynopsisTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            }
            [cell updateDisplay:self.infos[indexPath.row]];
            
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
            
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            
            CGFloat height = 0.0;
            height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            
            height += 1;
            
            return height;
        }
            break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.infos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MovieTitleTableViewCell class])];
    MovieDetailUIModel *model = (MovieDetailUIModel *)self.infos[indexPath.row];
    switch (model.cellType)
    {
        case MovieDetailCellTypesTitle:
        {
            MovieTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MovieTitleTableViewCell class])];
            cell.backgroundColor = [UIColor clearColor];
            [cell updateDisplay:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self.offscreenCells setObject:cell forKey:@"MovieTitleTableViewCell"];
            
            return cell;
        }
            break;
            
        case MovieDetailCellTypesInfo:
        {
            MovieInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MovieInfoTableViewCell class])];
            cell.backgroundColor = [UIColor clearColor];
            [cell updateDisplay:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self.offscreenCells setObject:cell forKey:@"MovieInfoTableViewCell"];
            
            return cell;
        }
            break;
            
        case MovieDetailCellTypesSynopsis:
        {
            MovieSynopsisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MovieSynopsisTableViewCell class])];
            cell.backgroundColor = [UIColor clearColor];
            [cell updateDisplay:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self.offscreenCells setObject:cell forKey:@"MovieSynopsisTableViewCell"];
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.detailTableView shouldPositionParallaxHeader];
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotoBuyNowVCFromMovieDetail"])
    {
        BuyNowViewController *destinationVC = segue.destinationViewController;
        destinationVC.selectedMovieModel = self.selectedMovieModel;
        destinationVC.isFromMovieDetialVC = YES;
    }
}

#pragma mark - Private
- (void) createData
{
    self.infos = [NSMutableArray new];
    
    // Movie Name
    if ([self.selectedMovieModel.name length] > 0)
    {
        MovieDetailUIModel *title = [MovieDetailUIModel MovieDetailUIModelWithContent:[NSString stringWithFormat:@"%@", self.selectedMovieModel.name] cellType:MovieDetailCellTypesTitle];
        [self.infos addObject:title];
    }
    
    // Movie Release Date
    if ([self.selectedMovieModel.releaseDate length] > 0)
    {
        MovieDetailUIModel *releaseDate = [MovieDetailUIModel MovieDetailUIModelWithTitle:@"Release Date" content:[NSString stringWithFormat:@"%@", self.selectedMovieModel.releaseDate] cellType:MovieDetailCellTypesInfo];
        [self.infos addObject:releaseDate];
    }
    
    // Movie Language
    if ([self.selectedMovieModel.language length] > 0)
    {
        MovieDetailUIModel *language = [MovieDetailUIModel MovieDetailUIModelWithTitle:@"Language" content:[NSString stringWithFormat:@"%@", self.selectedMovieModel.language] cellType:MovieDetailCellTypesInfo];
        [self.infos addObject:language];
    }
    
    // Movie Subtitles
    if ([self.selectedMovieModel.subtitles count] > 0)
    {
        NSMutableArray *contents = [NSMutableArray new];
        for (SubtitleModel *model in self.selectedMovieModel.subtitles)
        {
            [contents addObject:model.name];
        }
        
        MovieDetailUIModel *subtitles = [MovieDetailUIModel MovieDetailUIModelWithTitle:@"Subtitle" content:[NSString stringWithFormat:@"%@", [contents componentsJoinedByString:@", "]] cellType:MovieDetailCellTypesInfo];
        [self.infos addObject:subtitles];
    }
    
    // Movie Genres
    if ([self.selectedMovieModel.genres count] > 0)
    {
        NSMutableArray *contents = [NSMutableArray new];
        for (GenreModel *model in self.selectedMovieModel.genres)
        {
            [contents addObject:model.name];
        }
        MovieDetailUIModel *genres = [MovieDetailUIModel MovieDetailUIModelWithTitle:@"Genres" content:[NSString stringWithFormat:@"%@", [contents componentsJoinedByString:@", "]] cellType:MovieDetailCellTypesInfo];
        [self.infos addObject:genres];
    }
    
    // Movie Running Time
    if ([self.selectedMovieModel.runningTime length] > 0)
    {
        MovieDetailUIModel *runningTime = [MovieDetailUIModel MovieDetailUIModelWithTitle:@"Running Time" content:[NSString stringWithFormat:@"%@", self.selectedMovieModel.runningTime] cellType:MovieDetailCellTypesInfo];
        [self.infos addObject:runningTime];
    }
    
    // Movie Director
    if ([self.selectedMovieModel.cast length] > 0)
    {
        MovieDetailUIModel *director = [MovieDetailUIModel MovieDetailUIModelWithTitle:@"Director" content:[NSString stringWithFormat:@"%@", self.selectedMovieModel.director] cellType:MovieDetailCellTypesInfo];
        [self.infos addObject:director];
    }
    
    // Movie Cast
    if ([self.selectedMovieModel.cast length] > 0)
    {
        MovieDetailUIModel *cast = [MovieDetailUIModel MovieDetailUIModelWithTitle:@"Distributor" content:[NSString stringWithFormat:@"%@", self.selectedMovieModel.cast] cellType:MovieDetailCellTypesInfo];
        [self.infos addObject:cast];
    }
    
    // Movie Distributor
    if ([self.selectedMovieModel.distributor length] > 0)
    {
        MovieDetailUIModel *distributor = [MovieDetailUIModel MovieDetailUIModelWithTitle:@"Distributor" content:[NSString stringWithFormat:@"%@", self.selectedMovieModel.distributor] cellType:MovieDetailCellTypesInfo];
        [self.infos addObject:distributor];
    }
    
    // Movie Synopsis
    if ([self.selectedMovieModel.synopsis length] > 0)
    {
        MovieDetailUIModel *synopsis = [MovieDetailUIModel MovieDetailUIModelWithContent:[NSString stringWithFormat:@"%@", self.selectedMovieModel.synopsis] cellType:MovieDetailCellTypesSynopsis];
        [self.infos addObject:synopsis];
    }
    
    [self.detailTableView reloadData];
    
    // Displaying the Trailer
    if ([self.selectedMovieModel.trailerUrl length] > 0)
    {
        [self addHeaderView];
    }
}

@end
