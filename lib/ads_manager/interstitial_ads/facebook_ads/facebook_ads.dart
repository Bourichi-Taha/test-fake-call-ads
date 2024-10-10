import 'package:facebook_audience_network/facebook_audience_network.dart';

class FacebookAds {
  static final FacebookAds _instance = FacebookAds._internal();
  int _clickCounter = 0;
  final int _clickThreshold = 4; // Show ad after 4 clicks

  factory FacebookAds() {
    return _instance;
  }

  FacebookAds._internal();

  void initialize() {
    FacebookAudienceNetwork.init();
  }

  void loadInterstitialFacebook() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503", // Test Placement ID
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {
          FacebookInterstitialAd.showInterstitialAd();
        } else if (result == InterstitialAdResult.ERROR) {
          print("Error loading facebook interstitial ad: $value");
        }
      },
    );
  }

  void handleClickfb() {
    _clickCounter++;
    if (_clickCounter >= _clickThreshold) {
      loadInterstitialFacebook();
      _clickCounter = 0; // Reset the counter after showing the ad
    }
  }

  // Optional: Reset click counter manually
  void resetCounter() {
    _clickCounter = 0;
  }
}
