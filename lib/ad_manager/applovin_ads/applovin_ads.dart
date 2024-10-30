import 'package:applovin_max/applovin_max.dart';

class AppLovinInterstitialManager {
  static const String _interstitialAdUnitId = "26d512ea6876f2ec";
  bool _isAdLoaded = false;

  void initializeAppLovin() {
    AppLovinMax.initialize(
      sdkKey: "lv0C9ThoCyfGpyWxTbIaL9CW2ZnBnE7ShD_Ae4y8XEq41bsvIgfIMnmqfKC8PTTaz_BbB_betbZ654QrCA9PKI",
      onSdkInitialized: (config) {
        print("AppLovin SDK initialized.");
        loadInterstitialAd();
      },
    );
  }

  void loadInterstitialAd() {
    AppLovinMax.loadInterstitial(_interstitialAdUnitId);

    AppLovinMax.setInterstitialListener((event, adData) {
      switch (event) {
        case MaxAdEvent.loaded:
          print("AppLovin Interstitial Ad loaded.");
          _isAdLoaded = true;
          break;
        case MaxAdEvent.loadFailed:
          print("AppLovin Interstitial Ad failed to load.");
          _isAdLoaded = false;
          break;
        case MaxAdEvent.adDisplayed:
          print("AppLovin Interstitial Ad displayed.");
          break;
        case MaxAdEvent.adHidden:
          print("AppLovin Interstitial Ad hidden.");
          loadInterstitialAd(); // Reload the ad after it is closed
          break;
        default:
          break;
      }
    });
  }

  void showInterstitialAd() {
    if (_isAdLoaded) {
      AppLovinMax.showInterstitial(_interstitialAdUnitId);
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
    AppLovinMax.initialize(
      sdkKey: "lv0C9ThoCyfGpyWxTbIaL9CW2ZnBnE7ShD_Ae4y8XEq41bsvIgfIMnmqfKC8PTTaz_BbB_betbZ654QrCA9PKI",
      onSdkInitialized: (config) {
        print("AppLovin SDK for banners initialized.");
        loadBannerAd();
      },
    );
  }

  void loadBannerAd() {
    AppLovinMax.createBanner(
      _bannerAdUnitId,
      AdViewPosition.bottomCenter, // You can choose top or bottom
      size: BannerAdSize.banner,
    );

    AppLovinMax.setBannerListener((event, adData) {
      switch (event) {
        case MaxAdEvent.loaded:
          print("AppLovin Banner Ad loaded.");
          break;
        case MaxAdEvent.loadFailed:
          print("AppLovin Banner Ad failed to load.");
          break;
        case MaxAdEvent.clicked:
          print("AppLovin Banner Ad clicked.");
          break;
        case MaxAdEvent.adCollapsed:
          print("AppLovin Banner Ad collapsed.");
          break;
        case MaxAdEvent.adExpanded:
          print("AppLovin Banner Ad expanded.");
          break;
        default:
          break;
      }
    });
  }

  void hideBannerAd() {
    AppLovinMax.hideBanner(_bannerAdUnitId);
  }

  void showBannerAd() {
    AppLovinMax.showBanner(_bannerAdUnitId);
  }

  void removeBannerAd() {
    AppLovinMax.destroyBanner(_bannerAdUnitId);
  }
}
