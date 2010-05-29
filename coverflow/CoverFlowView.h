#import <UIKit/UIKit.h>
#import "UICoverFlowLayer.h"

@protocol CoverFlowHost <NSObject>
- (void) doubleTapCallback;
- (int) coverCount;
@end

@interface UIView (LayerSet)
- (void) setLayer: (id) aLayer;
@end

@interface CoverFlowView : UIView {
	id					<CoverFlowHost> host;
	id					info;
	UICoverFlowLayer	*cfLayer;
	UILabel				*label;
	UIImageView			*phimg;
}
- (CoverFlowView *) initWithFrame: (CGRect) aFrame andCount: (int) aCount inLandscape: (BOOL) landscapeMode;
- (void) tick;
- (void) flipSelectedCover;

@property (nonatomic, retain)		UILabel *label;
@property (nonatomic, retain)		UIImageView *phimg;
@property (nonatomic, retain)		id <CoverFlowHost> host;
@property (nonatomic, retain)		UICoverFlowLayer *cfLayer;
@end

