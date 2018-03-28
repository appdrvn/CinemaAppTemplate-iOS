//
//  BuyNowHeaderView.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 08/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "BuyNowHeaderView.h"
#import "UIImageView+WebCache.h"

@interface BuyNowHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation BuyNowHeaderView

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.thumbnailImageView.backgroundColor = [UIColor clearColor];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (id)initWithFrame:(CGRect)rect
{
    if (self = [super initWithFrame:rect])
    {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        [self addSubview:self.view];
        
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view":self.view}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view":self.view}]];
    }
    return self;
}

- (void) updateDisplay:(MovieModel *)model
{
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.imageUrl]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.name];
    self.contentLabel.text = [NSString stringWithFormat:@"%@", model.runningTime];
}

#pragma mark - UIButtons Actions
- (IBAction)moviePressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(BuyNowHeaderViewDelegateDidClickOn)])
    {
        [self.delegate BuyNowHeaderViewDelegateDidClickOn];
    }
}

@end
