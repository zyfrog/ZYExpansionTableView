//
//  ZYExpansionTableViewCel.h
//  ZYNestedTables
//
//  Created by Xinling Zhang on 8/24/13.
//  Copyright (c) 2013 Xinling Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYExpansionTableViewCell : UITableViewCell
@property (nonatomic, strong) id  dataSource;
@property (nonatomic, assign) BOOL isExpansion;
@end
