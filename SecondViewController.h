//
//  SecondViewController.h
//  ListView
//
//  Created by Techno on 10/19/15.
//  Copyright © 2015 Techno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>

{
    
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewTumbNails;
@property (weak, nonatomic)NSArray *myarrayData;

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITabBar *myTabBar;

@property (weak, nonatomic)NSMutableArray *myDataFromFirst;
@property (weak, nonatomic) IBOutlet UIImageView *BigImage;

@property (nonatomic,retain) UIActivityIndicatorView *activityIndicatorObject;
@end
