import 'package:applovin_max/applovin_max.dart';

class AppLovinInterstitialManager {
  static const String _interstitialAdUnitId = "26d512ea6876f2ec";
  bool _isAdLoaded = false;

  void initializeAppLovin() {
    AppLovinMAX.initialize(
      "lv0C9ThoCyfGpyWxTbIaL9CW2ZnBnE7ShD_Ae4y8XEq41bsvIgfIMnmqfKC8PTTaz_BbB_betbZ654QrCA9PKI",
    );
  }

  void loadInterstitialAd() {
    AppLovinMAX.loadInterstitial(_interstitialAdUnitId);
    InterstitialListener listener = InterstitialListener(
      onAdLoadedCallback: (test) {
        print("AppLovin Interstitial Ad loaded.");
        _isAdLoaded = true;
      },
      onAdLoadFailedCallback: (strin, error) {
        print("AppLovin Interstitial Ad failed to load: $strin");
        _isAdLoaded = false;
      },
      onAdDisplayedCallback: (test) {
        print("AppLovin Interstitial Ad displayed.");
      },
      onAdDisplayFailedCallback: (test, error) {
        print("AppLovin Interstitial Ad displayed.");
      },
      onAdHiddenCallback: (test) {
        print("AppLovin Interstitial Ad hidden.");
        loadInterstitialAd(); // Reload the ad after it is closed
      },
      onAdClickedCallback: (test) {
        print("AppLovin Interstitial Ad clicked.");
      },
    );
    // Register each callback individually
    AppLovinMAX.setInterstitialListener(listener);
  }

  void showInterstitialAd() {
    if (_isAdLoaded) {
      AppLovinMAX.showInterstitial(_interstitialAdUnitId);
      _isAdLoaded = false; // Reset after showing the ad
    } else {
      print("AppLovin Ad is not ready.");
    }
  }

  bool isAdReady() {
    return _isAdLoaded;
  }
}

class AppLovinBannerManager {
  static const String _bannerAdUnitId = "727ca3a0e2d391e8";

  void initializeBannerAd() {
    AppLovinMAX.initialize(
        "lv0C9ThoCyfGpyWxTbIaL9CW2ZnBnE7ShD_Ae4y8XEq41bsvIgfIMnmqfKC8PTTaz_BbB_betbZ654QrCA9PKI");
  }

  void loadBannerAd() {
    AppLovinMAX.createBanner(
        _bannerAdUnitId,
        AdViewPosition.bottomCenter, // Choose top or bottom  
        );
AdViewAdListener listener = new AdViewAdListener(
      onAdLoadedCallback: (test) {
        print("AppLovin Banner Ad loaded.");
      },
      onAdLoadFailedCallback: (strin, error) {
        print("AppLovin Banner Ad failed to load: $strin");
      },
      onAdClickedCallback: (test) {
        print("AppLovin Banner Ad clicked.");
      },
      onAdExpandedCallback: (test) {
        print("AppLovin Banner Ad expanded.");
      },
      onAdCollapsedCallback: (test) {
        print("AppLovin Banner Ad collapsed.");
      },
    );
    // Register each callback individually
    AppLovinMAX.setBannerListener(listener);
  }

  void hideBannerAd() {
    AppLovinMAX.hideBanner(_bannerAdUnitId);
  }

  void showBannerAd() {
    AppLovinMAX.showBanner(_bannerAdUnitId);
  }

  void removeBannerAd() {
    AppLovinMAX.destroyBanner(_bannerAdUnitId);
  }
}
