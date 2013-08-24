//
//  ZYExpansionTableViewCel.m
//  ZYNestedTables
//
//  Created by Xinling Zhang on 8/24/13.
//  Copyright (c) 2013 Xinling Zhang. All rights reserved.
//

#import "ZYExpansionTableViewCell.h"

@implementation ZYExpansionTableViewCell
- (void)setDataSource:(id)dataSource
{
    if ( dataSource == _dataSource )
    {
        return;
    }
    [_dataSource release];
    _dataSource = [dataSource retain];
    
    if ( [dataSource isKindOfClass:[NSString class]] )
    {
        self.textLabel.text = dataSource;
    }
}

- (void)setIsExpansion:(BOOL)isExpansion
{
    _isExpansion = isExpansion;
    isExpansion ? [self rotateExpandToExpanded] : [self rotateExpandToCollapsed];
}

- (void)rotateExpandToExpanded
{
    [UIView beginAnimations:@"rotateDisclosureButt" context:nil];
    [UIView setAnimationDuration:0.2];
    self.accessoryView.transform = CGAffineTransformMakeRotation(M_PI*2.5);
    [UIView commitAnimations];
}

- (void)rotateExpandToCollapsed
{
    [UIView beginAnimations:@"rotateDisclosureButt" context:nil];
    [UIView setAnimationDuration:0.2];
    self.accessoryView.transform = CGAffineTransformMakeRotation(M_PI*2);
    [UIView commitAnimations];
}



- (void)dealloc
{
    [_dataSource release];
    [super dealloc];
}
@end
