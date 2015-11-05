//
//  CustomViewCell.h
//  FengXingPlayer
//
//  Created by 古玉彬 on 15/11/5.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoGrade;
@property (weak, nonatomic) IBOutlet UILabel *videoTimer;

@end
