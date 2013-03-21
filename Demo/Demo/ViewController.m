//
//  ViewController.m
//  Demo
//
//  Created by Dany on 13-2-28.
//  Copyright (c) 2013年 Dany. All rights reserved.
//

#import "ViewController.h"
#import "MJActivityView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
- (IBAction)showUIViewController:(id)sender;
- (IBAction)showUIView:(id)sender;
- (IBAction)showGitHub:(id)sender;

- (IBAction)sliderValueChanged:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *showUIViewControllerBtn;
@property (weak, nonatomic) IBOutlet UIButton *showUIViewBtn;
@property (weak, nonatomic) IBOutlet UIButton *GitHubBtn;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UISlider *widthSlider;
@property (weak, nonatomic) IBOutlet UISlider *heightSlider;

@property (weak, nonatomic) IBOutlet UISwitch *dimBackground;
@property (weak, nonatomic) IBOutlet UISwitch *layerShadow;

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegmented;
@end

@implementation ViewController
{
    UIView              *container_view;
    UIViewController    *container_viewController;
    
    MJActivityView       *dropView;
}

#pragma mark 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"MJNavDropView Test";
    
    self.showUIViewControllerBtn.layer.cornerRadius = 8.0;
    self.showUIViewControllerBtn.layer.borderWidth = 2.0;
    self.showUIViewControllerBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.showUIViewBtn.layer.cornerRadius = 8.0;
    self.showUIViewBtn.layer.borderWidth = 2.0;
    self.showUIViewBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.GitHubBtn.layer.cornerRadius = 8.0;
    self.GitHubBtn.layer.borderWidth = 2.0;
    self.GitHubBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)showUIViewController:(id)sender {
    MJActivityView *drop = [self dropView];
    drop.container = [self container_viewController];
    [drop show];
}

- (IBAction)showUIView:(id)sender {
    MJActivityView *drop = [self dropView];
    drop.container = [self container_view];
    [drop show];
}

- (IBAction)showGitHub:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/DDany"]];
}

- (IBAction)sliderValueChanged:(id)sender {
    self.sizeLabel.text = [NSString stringWithFormat:@"Set container size: CGSize {%d,%d}", (int)self.widthSlider.value, (int)self.heightSlider.value];
}

#pragma mark - Private
- (UIViewController *)container_viewController {
    if (!container_viewController) {
        container_viewController = [[UIViewController alloc] init];
        container_viewController.view.backgroundColor = [UIColor whiteColor];
    }
    
    container_viewController.view.bounds = CGRectMake(0, 0, self.widthSlider.value, self.heightSlider.value);
    
    return container_viewController;
}

- (UIView *)container_view {
    if (!container_view) {
        container_view = [[UIView alloc] initWithFrame:CGRectZero];
        container_view.backgroundColor = [UIColor whiteColor];
    }
    container_view.bounds = CGRectMake(0, 0, self.widthSlider.value, self.heightSlider.value);
    
    return container_view;
}

- (MJActivityView *)dropView {
    if (!dropView) {
        dropView = [[MJActivityView alloc] init];
        [self.view addSubview:dropView];
    }
    
    [dropView setType:self.typeSegmented.selectedSegmentIndex];
    [dropView setIsDimBackground:self.dimBackground.on];
    [dropView setIsBorderShadow:self.layerShadow.on];
    
    return dropView;
}

- (void)viewDidUnload {
    [self setTypeSegmented:nil];
    [super viewDidUnload];
}
@end
