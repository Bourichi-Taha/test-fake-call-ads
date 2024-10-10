import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  // Load the interstitial ad
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test ad unit ID
      request: AdRequest(), // No need for testDevices here
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('Interstitial Ad loaded.');
          _interstitialAd = ad;
          _isAdLoaded = true; // Set the flag when the ad is loaded
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Interstitial Ad failed to load: $error');
          _isAdLoaded = false; // Reset the flag if loading fails
        },
      ),
    );
  }

  // Show the interstitial ad if it's ready
  void showInterstitialAd() {
    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd!.dispose();
      _interstitialAd = null;
      _isAdLoaded = false; // Reset the flag after the ad is shown
      loadInterstitialAd(); // Preload a new ad after showing
    } else {
      print('Interstitial ad is not ready yet.');
    }
  }
}
