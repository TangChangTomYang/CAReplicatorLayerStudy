//
//  YRViewController.m
//  repeatLayerDemo
//
//  Created by TangchangTomYang on 08/02/2017.
//  Copyright (c) 2017 TangchangTomYang. All rights reserved.
//

#import "YRViewController.h"
#import "YRAnimation.h"

@interface YRViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentV;

@end

@implementation YRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    ;
    
    
    
    
//     [self .contentV.layer addSublayer:[YRAnimation replicatorLayer_Wave]];
//     [self .contentV.layer addSublayer:[YRAnimation replicatorLayer_Grid]];
//     [self .contentV.layer addSublayer:[YRAnimation replicatorLayer_Circle]];
     [self .contentV.layer addSublayer:[YRAnimation replicatorLayer_Triangle]];
}

@end
