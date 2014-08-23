/*
     File: UIImage+ImageEffects.h
 Abstract: This is a category of UIImage that adds methods to apply blur and tint effects to an image. This is the code you’ll want to look out to find out how to use vImage to efficiently calculate a blur.
  Version: 1.0
*/

@import UIKit;

@interface UIImage (ImageEffects)

// Apple-defined
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

// 1App / Joel added
typedef enum {
    ImageEffectWhiteFrost,
    ImageEffectBlackObsidian,
    ImageEffectGrayWizard,
    ImageEffectNone
} ImageEffect;

- (UIImage *)applyEffectNamed: (ImageEffect)effectType;


@end
