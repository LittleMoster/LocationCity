//
//  ViewController.m
//  LocationCity
//
//  Created by cguo on 2017/9/9.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "ViewController.h"
#import "MyLocationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"点击屏幕跳转";
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MyLocationViewController *vc=[[MyLocationViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
