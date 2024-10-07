import 'package:google_mobile_ads/google_mobile_ads.dart';

InterstitialAd? _interstitialAd;

void loadInterstitialAd() {
  InterstitialAd.load(
    adUnitId: 'ca-app-pub-3940256099942544/1033173712',  // Test interstitial ad unit ID
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        print('Interstitial Ad loaded.');
        _interstitialAd = ad;
      },
      onAdFailedToLoad: (LoadAdError error) {
        print('Interstitial Ad failed to load: $error');
      },
    ),
  );
}

void showInterstitialAd() {
  if (_interstitialAd != null) {
    _interstitialAd!.show();
    _interstitialAd!.dispose();
    _interstitialAd = null;
  }
}
