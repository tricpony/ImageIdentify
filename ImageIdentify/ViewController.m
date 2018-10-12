#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image5;
@property (weak, nonatomic) IBOutlet UIView *image6;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_image2.highlighted = YES;
	_image4.image = [_image4.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	_image5.image = [[UIImage imageNamed:@"cat5"] imageWithHorizontallyFlippedOrientation];
	_image6.layer.contents = (__bridge id)[[UIImage imageNamed:@"cat6"] CGImage];
	NSLog(@"Loaded");
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
