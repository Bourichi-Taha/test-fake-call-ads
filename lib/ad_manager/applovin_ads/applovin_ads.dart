import 'package:applovin_max/applovin_max.dart';

class AppLovinInterstitialManager {
  static const String _interstitialAdUnitId = "YOUR_AD_UNIT_ID";
  bool _isAdLoaded = false;

  void initializeAppLovin() {
    AppLovinMax.initialize(
      sdkKey: "",
      onSdkInitialized: (config) {
        print("AppLovin SDK initialized.");
        loadInterstitialAd();
      },
    );
  }

  void loadInterstitialAd() {
    AppLovinMax.loadInterstitial(_interstitialAdUnitId);

    AppLovinMax.setInterstitialListener((AppLovinAdListener event) {
      switch (event) {
        case AppLovinAdListener.interstitialLoaded:
          print("AppLovin Interstitial Ad loaded.");
          _isAdLoaded = true;
          break;
        case AppLovinAdListener.interstitialLoadFailed:
          print("AppLovin Interstitial Ad failed to load.");
          _isAdLoaded = false;
          break;
        case AppLovinAdListener.interstitialDisplayed:
          print("AppLovin Interstitial Ad displayed.");
          break;
        case AppLovinAdListener.interstitialAdHidden:
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
