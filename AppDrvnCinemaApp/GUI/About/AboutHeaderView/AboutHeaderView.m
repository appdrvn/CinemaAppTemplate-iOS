//
//  AboutHeaderView.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 9/27/17.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "AboutHeaderView.h"

@interface AboutHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation AboutHeaderView

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

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    self.contentLabel.backgroundColor = [UIColor clearColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.contentLabel.preferredMaxLayoutWidth = screenRect.size.width - 15 - 15;
}

- (void) updateDisplay:(NSString *)content
{
    self.contentLabel.text = [NSString stringWithFormat:@"%@", content];
}

#pragma mark - UIButtons Actions
- (IBAction)findUsPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(AboutHeaderViewDelegateDidClickOnFacebookButton)])
    {
        [self.delegate AboutHeaderViewDelegateDidClickOnFacebookButton];
    }
}

- (IBAction)mailPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(AboutHeaderViewDelegateDidClickOnMailButton)])
    {
        [self.delegate AboutHeaderViewDelegateDidClickOnMailButton];
    }
}

- (IBAction)websitePressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(AboutHeaderViewDelegateDidClickOnWebsiteButton)])
    {
        [self.delegate AboutHeaderViewDelegateDidClickOnWebsiteButton];
    }
}

@end
