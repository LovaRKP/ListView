//
//  SecondViewController.m
//  ListView
//
//  Created by Techno on 10/19/15.
//  Copyright © 2015 Techno. All rights reserved.
//

#import "SecondViewController.h"
#import "UIImageView+AFNetworking.h"


@interface SecondViewController () <UITabBarDelegate,UIScrollViewDelegate>

{
    UIImageView *tumbnailImage;
    NSInteger imageIndex;
    
    
}

@end

@implementation SecondViewController
@synthesize myDataFromFirst,myarrayData,BigImage;

@synthesize activityIndicatorObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageIndex = 0;
    
    _scrollViewTumbNails.tag = 287;
    
    // Initialize ActivityIndicator object
    
   
    
    activityIndicatorObject = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Set Center Position for ActivityIndicator
    
    activityIndicatorObject.center = self.view.center;
    activityIndicatorObject.color = [UIColor redColor];
    
    // Add ActivityIndicator to your view
    
    [self.view addSubview:activityIndicatorObject];
    
    // Feching Data From server
    
    [activityIndicatorObject startAnimating];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    [tumbnailImage addGestureRecognizer:tapGesture1];
    // Do any additional setup after loading the view.
    myarrayData = myDataFromFirst;
    NSLog(@"data we get === %@",myarrayData);
    
    
    [self setTabBarItemImages];
    
    
    NSString *ImageURL = [myarrayData objectAtIndex:[[myarrayData lastObject]intValue]];
    //    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    //    BigImage.image = [UIImage imageWithData:imageData];
    
    [BigImage setImageWithURL:[NSURL URLWithString:ImageURL]];
    
    [self addingImagesToScrollView];
    
    
}
-(void) addingImagesToScrollView{
    float positionX =30;
    
    float buttonPossion = 115;
   
    
    for (int i=0;i<[myarrayData count];i++){
        
        //create random number for x position.
        tumbnailImage = [[UIImageView alloc] init];
        
        
        [tumbnailImage setFrame:CGRectMake(positionX, 0.0, 110.0, 110.0)];
        [tumbnailImage setTag:i ];
        [tumbnailImage setImage:[UIImage imageNamed:@"photo_option_icon"]];
       

        
      // creating button
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [aButton setFrame:CGRectMake(buttonPossion , 0, 20, 20)];
        
        [aButton setBackgroundImage:[UIImage imageNamed:@"green_dot"]
                            forState:UIControlStateNormal];
        
         positionX=positionX+140.0;
        buttonPossion = buttonPossion + 140;
   
        
        
        
        
        //adding tap gester
        
        
        tumbnailImage.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
        
        tapGesture1.numberOfTapsRequired = 1;
        
        [tapGesture1 setDelegate:self];
        
        [tumbnailImage addGestureRecognizer:tapGesture1];
        
        NSString *ImageURL = [myarrayData objectAtIndex:i];
        
        [tumbnailImage setImageWithURL:[NSURL URLWithString:ImageURL]];
        
        
        [self.scrollViewTumbNails addSubview:tumbnailImage];
         [_scrollViewTumbNails addSubview:aButton];
        
        
        CGRect contentRect = CGRectZero;
        for (UIView *view in self.scrollViewTumbNails.subviews) {
            contentRect = CGRectUnion(contentRect, view.frame);
        }
        self.scrollViewTumbNails.contentSize = contentRect.size;
        
        [activityIndicatorObject stopAnimating];
        
    }
    
    
}



- (void) tapGesture: (UITapGestureRecognizer*)sender
{
    
    UIView *viewImage = sender.view;
    NSLog(@"senderhghgh%ld", (long)viewImage.tag);
    
    imageIndex = viewImage.tag;
    
    int i =(int)viewImage.tag;
    //handle Tap...
    //    NSLog(@"sender :%@",sender.tag);
    NSString *ImageURL = [myarrayData objectAtIndex:i];
    
    [BigImage setImageWithURL:[NSURL URLWithString:ImageURL]];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




-(void)setTabBarItemImages

{
    
    
    UIImage *unselectedImage = [UIImage imageNamed:@"rotate_left_icon"];
    UIImage *selectedImage = [UIImage imageNamed:@"rotate_left_icon"];
    unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[self.myTabBar.items objectAtIndex:0] setImage:unselectedImage];
    [[self.myTabBar.items objectAtIndex:0] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    unselectedImage = [UIImage imageNamed:@"rotate_right_icon"];
    selectedImage = [UIImage imageNamed:@"rotate_right_icon"];
    unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[self.myTabBar.items objectAtIndex:1] setImage:unselectedImage];
    [[self.myTabBar.items objectAtIndex:1] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    unselectedImage = [UIImage imageNamed:@"crop_icon"];
    
    selectedImage = [UIImage imageNamed:@"crop_icon"];
    
    unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[self.myTabBar.items objectAtIndex:2] setImage:unselectedImage];
    
    [[self.myTabBar.items objectAtIndex:2] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    // Do Stuff!
    
    if(item.tag == 0) {
        
        
        
        //If you want to turn right, the value must be greater than 0 if you want to rotate to the left indicates the value with the sign "-". For example -20.
        
        static int numRot = 0;
        
        static int numRot1 = 0;
        
        
        BigImage.transform = CGAffineTransformMakeRotation( -(M_PI_2 * numRot));
        ++numRot;
        
        
        NSLog(@"shdsjhdjhdhksj====%ld",(long)imageIndex);
        UIImageView *img=(UIImageView *)[_scrollViewTumbNails viewWithTag:imageIndex];
        
        
        img.transform = CGAffineTransformMakeRotation( -(M_PI_2 * numRot1));
        ++numRot1;
        
        BigImage.contentMode = UIViewContentModeScaleToFill;
        
        
    }else if (item.tag == 1){
        
        static int numRot1 = 0;
        static int numRot12 = 0;
        
        BigImage.transform = CGAffineTransformMakeRotation(M_PI_2 * numRot1);
        ++numRot1;
        UIImageView *img=(UIImageView *)[_scrollViewTumbNails viewWithTag:imageIndex];
        
        img.transform = CGAffineTransformMakeRotation( -(M_PI_2 * numRot12));
        ++numRot12;
        
        BigImage.contentMode = UIViewContentModeScaleToFill;
        
        
    }else if (item.tag == 2){
        NSLog(@"Image Croup..");
        // Get size of current image
 
        
    }
    
    
}





@end
