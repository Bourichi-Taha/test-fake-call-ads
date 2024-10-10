import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class UnityAdsManager {
  static final UnityAdsManager _instance = UnityAdsManager._internal();
  int _clickCounter = 0;
  final int _clickThreshold = 4; // Number of clicks before showing the ad

  factory UnityAdsManager() {
    return _instance;
  }

  UnityAdsManager._internal();

  // Initialize Unity Ads
  void initialize() {
    UnityAds.init(
      gameId: "14851", // Replace with your Unity Game ID
      testMode: true, // Set to false in production
      onComplete: () => print('Unity Ads initialization complete'),
      onFailed: (error, message) =>
          print('Unity Ads initialization failed: $message'),
    );
  }

  // Load the interstitial ad
  Future<void> loadInterstitialAd() async {
    if (await UnityAds.isInitialized()) {
      UnityAds.load(
        placementId: "video", // Replace with your Unity Ad Unit ID
        onComplete: (placementId) =>
            print("Interstitial Ad Loaded: $placementId"),
        onFailed: (placementId, error, message) =>
            print("Interstitial Ad Failed to Load: $message"),
      );
    } else {
      print("Unity Ads not initialized");
    }
  }

  // Show interstitial ad with a listener for ad state
  void showInterstitialAd() {
    UnityAds.showVideoAd(
      placementId: "video", // Replace with your Unity Ad Unit ID
      onComplete: (placementId) => print("Video ad completed: $placementId"),
      onFailed: (placementId, error, message) =>
          print("Video ad failed to show: $message"),
      onSkipped: (placementId) => print("Video ad skipped: $placementId"),
      onStart: (placementId) => print("Video ad started: $placementId"),
      onClick: (placementId) => print("Video ad clicked: $placementId"),
    );
  }

  // Handle click logic and show ad after a certain number of clicks
  void handleClick() {
    _clickCounter++;
    if (_clickCounter >= _clickThreshold) {
      loadInterstitialAd(); // Load the ad first
      Future.delayed(Duration(seconds: 2), () {
        showInterstitialAd(); // Show the ad after a short delay (for loading time)
      });
      _clickCounter = 0; // Reset the counter after showing the ad
    }
  }

  // Optional: Reset the click counter manually
  void resetCounter() {
    _clickCounter = 0;
  }
}
