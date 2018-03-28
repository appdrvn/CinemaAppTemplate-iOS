## [Cinema App Template iOS]

## Introduction
Cinema App Template consider is a sample template of entertainment app which is showing the latest movies and cinemas. All the data is consisting of list view, grid view to display the information. Besides that, you might integrate your own ticketing system to complete the app. The main objective of this template is to assist startups to buy their mobile application faster and easier. 

## Demo


## How to start
1. This template comes with dummy data in it, if the app need to connect to Web API, then modify ```-(void)loadData``` methods to integrate Web API library.
2. All list is accepting the NSArray/NSMutableArray and also added the method for appending data for the following pages from this method ```-(void)finishLoadingDataFromCms:(NSArray *)results```.
3. Data binding from Web API result to Model object is not included, you have to implement your own data binding.

## What is inside
### Model Classes
#### MovieModel.h
This model class is used for all the movie object. It is the main object in this template. You might set your own property in to this model class.

#### CinemaModel.h
This model class is used for the cinema object and contains some basic properties which are cinemaId, name, address, imageUrl, phoneNo, showtimes, longtitude and latitude. You might set your own property for the cinema object in this model class.

### Core Classes
#### AppConstants.h
This class used to define some important GLOBAL CONSTANT for the others classes needed which are:
1. `DEFAULT_TAKE`
This used for pagination feature while pulling the number of data from Web API.
2. `BANNER_VIEW_HEIGHT`
This is the ratio of all the banners image to fit all the devices with different resolution sizes.
3. `CINEMA_VIEW_HEIGHT`
This is the ratio of all the cinema thumbnail images to fit all the devices with different resolution sizes.
4. `appThemeColor`

#### GeneralHelper.h & .m
This class used to define some GLOBAL methods which able to call by the other classes which are:
1. ```+ (UILabel *) setNavTitle:(NSString *)title withNavItem:(UINavigationItem *)navItem;```
This method used to set the Title in UINavigationBar and able to customise the UILabel.
2. ```+ (void) openBrowserInUrl:(NSString *)urlString;```
This method contains the default opening Safari browser with the url
3. ```+ (void)showAlertMsg:(NSString *)msg;```
This method contains the UIAlertView to display the alert message.
4. There have some screen size checking methods which are 
```+ (BOOL) isDeviceiPhone4;```
```+ (BOOL) isDeviceiPhone5;```
```+ (BOOL) isDeviceiPhone6;```
```+ (BOOL) isDeviceiPhone6plus;```
```+ (BOOL) isDeviceiPhoneX;```
5. ```+ (NSDate *) getDateFromTimestamp:(NSTimeInterval)timeStamp;```
This method used to display NSDate from NSTimeInterval format.
6.These 2 methods used to redirect  and showing the location in GoogleMapp and Waze
```+ (void) navigateToLatitude:(double)latitude longitude:(double)longitude;```
```+ (void) navigateToGoogleMapWithLatitude:(double)latitude longitude:(double)longitude;```

#### BaseViewController.h & .m
This is the superclass for all the ```UIViewController``` classes to inherit. And also able to create some methods are calling by the certain ```UIViewController```.

#### BaseTableViewController.h & .m
This is the superclass of all the ```UIViewController``` classes which contain ```UITableView``` and integrated the Pull To Refresh and Load More features.

#### BaseCollectionViewController.h & .m
This is the superclass of all the ```UIViewController``` classes which contain ```UICollectionView``` and integrated the Pull To Refresh and Load More features.

### ViewController Classes
There are sample of ViewController classes which used to integrate with Web API:

#### MainPageViewController.h & .m
This view controller is using to display the latest / hot information which is advertisement banners and the movies. There also have a popup view to show the movie trailer which using MZFormSheetPresentationViewController library to present the view. Able to integrate the Web API to display data from this method ```- (void) loadData```.

#### MovieViewController.h & .m
This view controller used to list out all the latest movies with pagination effect. First of all, remove all the dummy data from ```-(void)loadData``` method before integrating Web API and putting ```DEFAULT_TAKE``` to pull the number of data when calling the Web API. 

#### CinemaViewController.h & .m
This view controller is specially used to display all the cinema. First of all, remove all the dummy data from ```-(void)loadData``` method before integrating Web API. While integrating Web API, remember to put ```DEFAULT_TAKE``` to pull the number of data.


## File Structure
```
AppDrvnCinemaApp
|AppDrvnCinemaApp
|        |---AppDelegate.h
|        |---AppDelegate.m
|        |---Assets.xcassets
|        |---LaunchScreen.storyboard
|        |---Main.storyboard
|        |---Info.plist
|        |---Model
|        |        |---UIModel
|        |        |        |---AboutUIModel.h
|        |        |        |---AboutUIModel.m
|        |        |        |---MovieDetailUIModel.h
|        |        |        |---MovieDetailUIModel.m
|        |        |        |---MoreUIModel.h
|        |        |        |---MoreUIModel.m
|        |        |        |---ChooseDateUIModel.h
|        |        |        |---ChooseDateUIModel.m
|        |        |---MovieModel.h
|        |        |---MovieModel.m
|        |        |---GenreModel.h
|        |        |---GenreModel.m
|        |        |---SubtitleModel.h
|        |        |---SubtitleModel.m
|        |        |---CinemaModel.h
|        |        |---CinemaModel.m
|        |        |---ShowTimeModel.h
|        |        |---ShowTimeModel.m
|        |        |---BannerModel.h
|        |        |---BannerModel.m
|        |---Core
|        |        |---AppConstants.h
|        |        |---GeneralHelper.h
|        |        |---GeneralHelper.m
|        |        |---ServerEnum.h
|        |---GUI
|        |        |---BaseCollectionViewController.h
|        |        |---BaseCollectionViewController.m
|        |        |---BaseTableViewController.h
|        |        |---BaseTableViewController.m
|        |        |---BaseViewController.h
|        |        |---BaseViewController.m
|        |        |---Preview
|        |        |        |---PreviewViewController.h
|        |        |        |---PreviewViewController.m
|        |        |---BuyNow
|        |        |        |---BuyNowViewController.h
|        |        |        |---BuyNowViewController.m
|        |        |        |---BuyNowTableViewCells
|        |        |        |        |---BuyNowTableViewCell.h
|        |        |        |        |---BuyNowTableViewCell.m
|        |        |        |        |---BuyNowTableViewCell.xib
|        |        |        |---BuyNowHeaderView
|        |        |        |        |---BuyNowHeaderView.h
|        |        |        |        |---BuyNowHeaderView.m
|        |        |        |        |---BuyNowHeaderView.xib
|        |        |---About
|        |        |        |---AboutPageViewController.h
|        |        |        |---AboutPageViewController.m
|        |        |        |---AboutHeaderView
|        |        |        |        |---AboutHeaderView.h
|        |        |        |        |---AboutHeaderView.m
|        |        |        |        |---AboutHeaderView.xib
|        |        |        |---AboutTableViewCells
|        |        |        |        |---AboutTableViewCell.h
|        |        |        |        |---AboutTableViewCell.m
|        |        |---Cinema
|        |        |        |---CinemaViewController.h
|        |        |        |---CinemaViewController.m
|        |        |        |---CinemaTableViewCells
|        |        |        |        |---CinemaTableViewCell.h
|        |        |        |        |---CinemaTableViewCell.m
|        |        |        |---CinemaDetailTableViewCells
|        |        |        |        |---CinemaDetailTableViewCell.h
|        |        |        |        |---CinemaDetailTableViewCell.m
|        |        |        |        |---CinemaDetailTableViewCell.xib
|        |        |        |        |---ChooseCalendarSectionView.h
|        |        |        |        |---ChooseCalendarSectionView.m
|        |        |        |        |---ChooseCalendarSectionView.xib
|        |        |        |        |---DateCollectionViewCell.h
|        |        |        |        |---DateCollectionViewCell.m
|        |        |        |        |---DateCollectionViewCell.xib
|        |        |        |        |---ScheduleCollectionViewCell.h
|        |        |        |        |---ScheduleCollectionViewCell.m
|        |        |        |        |---ScheduleCollectionViewCell.xib
|        |        |---Main
|        |        |        |---MainPageViewController.h
|        |        |        |---MainPageViewController.m
|        |        |---More
|        |        |        |---MoreViewController.h
|        |        |        |---MoreViewController.m
|        |        |        |---MoreTableViewCells
|        |        |        |        |---MoreTableViewCell.h
|        |        |        |        |---MoreTableViewCell.m
|        |        |---Movie
|        |        |        |---MovieViewController.h
|        |        |        |---MovieViewController.m
|        |        |        |---MovieCollectionViewCells
|        |        |        |        |---MovieCollectionViewCell.h
|        |        |        |        |---MovieCollectionViewCell.m
|        |        |        |        |---MovieCollectionViewCell.xib
|        |        |        |---MovieDetailHeaderViews
|        |        |        |        |---MovieDetailHeaderView.h
|        |        |        |        |---MovieDetailHeaderView.m
|        |        |        |        |---MovieDetailHeaderView.xib
|        |        |        |---MovieDetailTableViewCells
|        |        |        |        |---MovieTitleTableViewCell.h
|        |        |        |        |---MovieTitleTableViewCell.m
|        |        |        |        |---MovieInfoTableViewCell.h
|        |        |        |        |---MovieInfoTableViewCell.m
|        |        |        |        |---MovieSynopsisTableViewCell.h
|        |        |        |        |---MovieSynopsisTableViewCell.m
|        |---Library
|        |        |---LCBannerView
|        |        |---MSPullToRefreshController
|        |        |---MZFormSheetPresentationController
|        |        |---PureLayout
|        |        |---SDWebImage
|        |        |---VGParallaxHeader
|        |---Resources
|        |        |---Images
|        |---Supporting FIles
|        |        |---main.m
|---Products
|        |---AppDrvnCinemaApp.app
```

## Tools and Libraries used
1. LCBannerView - https://github.com/iTofu/LCBannerView
2. MSPullToRefreshController - https://github.com/bogardon/MSPullToRefreshController
3. MZFormSheetPresentationController - https://github.com/m1entus/MZFormSheetPresentationController
4. PureLayout - https://github.com/smileyborg/PureLayout
5. VGParallaxHeader - https://github.com/stoprocent/VGParallaxHeader
6. SDWebImage - https://github.com/rs/SDWebImage
7. Icons8 - https://icons8.com/

## Useful Links
1. Appdrvn official website - http://appdrvn.com/ 
2. Appdrvn official facebook page - https://www.facebook.com/appdrvn/ 
3. Appdrvn email address - hello@appdrvn.com 
