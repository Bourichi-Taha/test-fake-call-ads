// import 'package:applovin_max/applovin_max.dart';

// class AppLovinInterstitialManager {
//   static const String _interstitialAdUnitId = "YOUR_AD_UNIT_ID";

//   void initializeAppLovin() {
//     AppLovinMax.initialize(
//       sdkKey: "",
//       onSdkInitialized: (config) {
//         print("AppLovin SDK initialized.");
//         loadInterstitialAd();
//       },
//     );
//   }

//   void loadInterstitialAd() {
//     AppLovinMax.loadInterstitial(_interstitialAdUnitId);

//     AppLovinMax.setInterstitialListener((AppLovinAdListener event) {
//       switch (event) {
//         case AppLovinAdListener.interstitialLoaded:
//           print("Interstitial Ad loaded.");
//           break;
//         case AppLovinAdListener.interstitialLoadFailed:
//           print("Failed to load Interstitial Ad.");
//           break;
//         case AppLovinAdListener.interstitialDisplayed:
//           print("Interstitial Ad displayed.");
//           break;
//         case AppLovinAdListener.interstitialAdHidden:
//           print("Interstitial Ad hidden.");
//           loadInterstitialAd(); // Reload the ad after it is closed
//           break;
//         case AppLovinAdListener.interstitialClicked:
//           print("Interstitial Ad clicked.");
//           break;
//         default:
//           break;
//       }
//     });
//   }

//   void showInterstitialAd() {
//     AppLovinMax.showInterstitial(_interstitialAdUnitId);
//   }
// }
