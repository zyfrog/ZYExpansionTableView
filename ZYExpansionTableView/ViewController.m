//
//  ViewController.m
//  ZYExpansionTableView
//
//  Created by Xinling Zhang on 8/24/13.
//  Copyright (c) 2013 Xinling Zhang. All rights reserved.
//

#import "ViewController.h"
#import "ZYExpansionTableView.h"

@interface ViewController ()<UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    ZYExpansionTableView* tablew = [[ZYExpansionTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tablew.delegate = self;
    tablew.dataSourceArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ExpansionData" ofType:@"plist"]];
    [self.view addSubview:tablew];
    [tablew release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
