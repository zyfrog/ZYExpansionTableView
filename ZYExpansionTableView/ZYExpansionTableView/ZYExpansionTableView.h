//
//  ExpansionTableView.h
//  ZYNestedTables
//
//  Created by Xinling Zhang on 8/24/13.
//  Copyright (c) 2013 Xinling Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYExpansionTableViewCell.h"

/**
 *	能够伸展的table view
 */
@interface ZYExpansionTableView : UITableView

/**
 *	同一时间只能有一个可以展开，默认为No
 */
@property (nonatomic, assign) BOOL canOnlyOneExpansion;

/**
 *	数据源
 */
@property (nonatomic, strong) NSMutableArray* dataSourceArray;
@end
