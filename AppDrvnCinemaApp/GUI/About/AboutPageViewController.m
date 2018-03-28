//
//  AboutPageViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 9/27/17.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "AboutPageViewController.h"
#import "AboutUIModel.h"
#import "AboutHeaderView.h"
#import "AboutTableViewCell.h"
#import <MessageUI/MessageUI.h> 
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutPageViewController ()<AboutHeaderViewDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;
@property (nonatomic, strong) AboutHeaderView *aboutHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *aboutTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation AboutPageViewController

- (void) layoutSetup
{
    self.bottomView.backgroundColor = [UIColor appThemeColor];
    
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
    self.bottomLabel.text = [NSString stringWithFormat:@"Cinema Template v%@ coded by Appdrvn", currentVersion];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutSetup];
    [self createData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - Add Header View
- (void) addHeaderView
{
    self.aboutHeaderView = nil;
    self.aboutHeaderView = [[AboutHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 320.0f)];
    self.aboutHeaderView.backgroundColor = [UIColor clearColor];
    self.aboutHeaderView.view.backgroundColor = [UIColor clearColor];
    self.aboutHeaderView.delegate = self;
    [self.aboutHeaderView updateDisplay:ABOUT_CONTENT];
    [self.aboutHeaderView setNeedsLayout];
    [self.aboutHeaderView layoutIfNeeded];
    [self.aboutHeaderView layoutSubviews];
    
    CGRect headerFrame = self.aboutHeaderView.frame;
    headerFrame.size.height = [self.aboutHeaderView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    self.aboutHeaderView.frame = headerFrame;
    
    self.aboutTableView.tableHeaderView = self.aboutHeaderView;
}

#pragma mark - AboutHeaderViewDelegate
- (void) AboutHeaderViewDelegateDidClickOnFacebookButton
{
    [GeneralHelper openBrowserInUrl:ABOUT_US_FACEBOOK_LINK];
}

- (void) AboutHeaderViewDelegateDidClickOnMailButton
{
    [self sendEmailToUs];
}

- (void) AboutHeaderViewDelegateDidClickOnWebsiteButton
{
    [GeneralHelper openBrowserInUrl:ABOUT_US_WEBSITE_LINK];
}

#pragma mark - Mail Feature
- (void) sendEmailToUs
{
    // From within your active view controller
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailComp = [[MFMailComposeViewController alloc] init];
        mailComp.mailComposeDelegate = self;
        [mailComp setSubject:@""];
        [mailComp setToRecipients:[NSArray arrayWithObject:ABOUT_US_MAIL_ADDRESS]];
        [mailComp setMessageBody:@"" isHTML:NO];
        
        [self presentViewController:mailComp animated:YES completion:nil];
    }
    else
    {
        [GeneralHelper showAlertMsg:@"Please goto Settings to setup your email."];
    }
}

// Then implement the delegate method
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = NSStringFromClass([AboutTableViewCell class]);
    
    AboutTableViewCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
    if(cell == nil)
    {
        cell = (AboutTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    [cell updateDisplay:self.dataArray[indexPath.row]];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AboutTableViewCell class])];
    cell.backgroundColor = [UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:1.0];
    [cell updateDisplay:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.offscreenCells setObject:cell forKey:@"AboutTableViewCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutUIModel *model = (AboutUIModel *)self.dataArray[indexPath.row];
    [GeneralHelper openBrowserInUrl:model.referenceLink];
}

#pragma mark - UIButtons Actions
- (IBAction)backPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private
- (void) createData
{
    self.dataArray = [NSMutableArray new];
    
    AboutUIModel *reference1 = [AboutUIModel AboutUIModelWithReferenceName:@"LCBannerView" referenceLink:@"https://github.com/iTofu/LCBannerView" referenceAuthor:@"Leo"];
    AboutUIModel *reference2 = [AboutUIModel AboutUIModelWithReferenceName:@"MSPullToRefreshController" referenceLink:@"https://github.com/bogardon/MSPullToRefreshController" referenceAuthor:@"John Z Wu & Tim Lee"];
    AboutUIModel *reference3 = [AboutUIModel AboutUIModelWithReferenceName:@"MZFormSheetPresentationController" referenceLink:@"https://github.com/m1entus/MZFormSheetPresentationController" referenceAuthor:@"Michal Zaborowski"];
    AboutUIModel *reference4 = [AboutUIModel AboutUIModelWithReferenceName:@"PureLayout" referenceLink:@"https://github.com/smileyborg/PureLayout" referenceAuthor:@"Tyler Fox"];
    AboutUIModel *reference5 = [AboutUIModel AboutUIModelWithReferenceName:@"VGParallaxHeader" referenceLink:@"https://github.com/smileyborg/PureLayout" referenceAuthor:@"Tyler Fox"];
    AboutUIModel *reference6 = [AboutUIModel AboutUIModelWithReferenceName:@"SDWebImage" referenceLink:@"https://github.com/rs/SDWebImage" referenceAuthor:@"Olivier Poitrey"];
    AboutUIModel *reference7 = [AboutUIModel AboutUIModelWithReferenceName:@"Icons" referenceLink:@"https://icons8.com/" referenceAuthor:@"Icons8"];
    
    [self.dataArray addObjectsFromArray:@[reference1, reference2, reference3, reference4, reference5, reference6, reference7]];
    [self addHeaderView];
    [self.aboutTableView reloadData];
}

@end
