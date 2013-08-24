//
//  ExpansionTableView.m
//  ZYNestedTables
//
//  Created by Xinling Zhang on 8/24/13.
//  Copyright (c) 2013 Xinling Zhang. All rights reserved.
//

#import "ZYExpansionTableView.h"

@interface ZYExpansionTableView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray* openIndexPathArray;
@property (nonatomic, assign) id<UITableViewDelegate> expansionDelegate;
@end

@implementation ZYExpansionTableView

- (void)setDataSourceArray:(NSMutableArray *)dataSourceArray
{
    if ( _dataSourceArray == dataSourceArray )
    {
        return;
    }
    
    [_dataSourceArray release];
    _dataSourceArray = [dataSourceArray retain];
    self.dataSource = self;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    [super setDelegate:self];
    self.expansionDelegate = delegate;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if ( self )
    {
        _openIndexPathArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    self.dataSourceArray = nil;
    self.openIndexPathArray = nil;
    
    [super dealloc];
}

#pragma mark delegate / sourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSourceArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    for ( NSIndexPath* indexPath in self.openIndexPathArray )
    {
        if ( indexPath.section == section )
        {
            return [self.dataSourceArray[section] count];
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* className = self.dataSourceArray[indexPath.section][indexPath.row][@"CellClassName"];
    ZYExpansionTableViewCell* cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:className];
    if ( !cell )
    {
        cell = [[[NSClassFromString(className) alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:className] autorelease];
    }
    cell.dataSource = self.dataSourceArray[indexPath.section][indexPath.row][@"DataSource"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber* canExpansion = self.dataSourceArray[indexPath.section][indexPath.row][@"CanExpansion"];
    if ( [canExpansion boolValue] )
    {
        if ( [self.openIndexPathArray containsObject:indexPath] )
        {
            [self collapseWithIndexPath:indexPath];
        }
        else
        {
            [self expansionWithIndexPath:indexPath];
        }
    }
    
    if ( [self.expansionDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)] )
    {
        [self.expansionDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
}


- (void)expansionWithIndexPath:(NSIndexPath *)indexPath
{
    if ( self.canOnlyOneExpansion )
    {
        NSArray* array = [NSArray arrayWithArray:self.openIndexPathArray];
        for ( NSIndexPath* path in array )
        {
            [self collapseWithIndexPath:path];
        }
    }
    
    {
        [self.openIndexPathArray addObject:indexPath];
        ZYExpansionTableViewCell* cell = (ZYExpansionTableViewCell*)[self cellForRowAtIndexPath:indexPath];
        cell.isExpansion = YES;
        [self beginUpdates];
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        NSInteger count = [self.dataSourceArray[indexPath.section] count];
        for (NSUInteger i = 1; i < count; i++)
        {
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [rowToInsert addObject:indexPathToInsert];
        }
        [self insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        [self endUpdates];
        [rowToInsert release];
    }
}


- (void)collapseWithIndexPath:(NSIndexPath *)indexPath
{
    [self.openIndexPathArray removeObject:indexPath];
    ZYExpansionTableViewCell* cell = (ZYExpansionTableViewCell*)[self cellForRowAtIndexPath:indexPath];
    cell.isExpansion = NO;
    [self beginUpdates];
    NSMutableArray* rowToDelete = [[NSMutableArray alloc] init];
    NSInteger count = [self.dataSourceArray[indexPath.section] count];
    for (NSUInteger i = 1; i < count; i++)
    {
        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
        [rowToDelete addObject:indexPathToInsert];
    }
    [self deleteRowsAtIndexPaths:rowToDelete withRowAnimation:UITableViewRowAnimationTop];
	[self endUpdates];
    [rowToDelete release];
}





@end
