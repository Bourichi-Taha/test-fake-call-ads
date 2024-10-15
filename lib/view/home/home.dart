import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:bordered_text/bordered_text.dart';
import 'package:fakecall/ad_manager/admob_ads/interstitial_ads.dart';
import 'package:fakecall/ad_manager/applovin_ads/applovin_ads.dart';
import 'package:fakecall/ad_manager/facebook_ads/facebook_ads.dart';
import 'package:fakecall/ad_manager/unity_ads/unity_ads.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/view/call/call.dart';
import 'package:fakecall/view/home/widget/home_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InAppReview inAppReview = InAppReview.instance;
  int _clickCount = 0;
  int _adSequenceIndex = 0;

  final AppLovinInterstitialManager _adManagerAppLovin =
      AppLovinInterstitialManager();
  final UnityAdsManager _unityAdsManager = UnityAdsManager();
  final FacebookAds _facebookAdsManager = FacebookAds();
  final AdMobAds _adMobManager = AdMobAds();

  @override
  void initState() {
    super.initState();
    _adManagerAppLovin.initializeAppLovin(); // Initialize AppLovin
    _unityAdsManager.initialize(); // Initialize Unity Ads
    _facebookAdsManager.initialize(); // Initialize Facebook Ads
    _adMobManager.loadInterstitialAd(); // Load AdMob interstitial ad
  }

  // Function to randomly pick and show one ad after 4 clicks
  // void _showRandomAd() {
  //   int randomAd = Random().nextInt(4); // Random number between 0 and 3
  //   switch (randomAd) {
  //     case 0:
  //       print("Showing AdMob Ad");
  //       _adMobManager.showInterstitialAd(); // Show AdMob Ad
  //       break;
  //     case 1:
  //       //print("Showing AppLovin Ad");
  //       //_adManagerAppLovin.showInterstitialAd(); // Show AppLovin Ad
  //       break;
  //     case 2:
  //       print("Showing Facebook Ad");
  //       _facebookAdsManager.handleClickfb(); // Show Facebook Ad
  //       break;
  //     case 3:
  //       print("Showing Unity Ad");
  //       _unityAdsManager.showInterstitialAd(); // Show Unity Ad
  //       break;
  //     default:
  //       print("No Ad to show.");
  //   }
  // }

  // Function to show ads in the specified sequence: AdMob -> Facebook -> Unity -> AppLovin
  void _showSequentialAd() {
    switch (_adSequenceIndex) {
      case 0:
        // Show AdMob Ad
        if (_adMobManager.isAdReady()) {
          _adMobManager.showInterstitialAd();
          _adSequenceIndex = 1; // Move to Facebook for next ad
        }
        break;
      case 1:
        // Show Facebook Ad
        if (_facebookAdsManager.isAdReady()) {
          _facebookAdsManager.showInterstitialAd();
          _adSequenceIndex = 2; // Move to Unity for next ad
        }
        break;
      case 2:
        // Show Unity Ad
        if (_unityAdsManager.isAdReady()) {
          _unityAdsManager.showInterstitialAd();
          _adSequenceIndex = 3; // Move to AppLovin for next ad
        }
        break;
      case 3:
        // Show AppLovin Ad
        // if (_appLovinManager.isAdReady()) {
        //   _appLovinManager.showInterstitialAd();
        // }
        _adSequenceIndex = 0; // Reset to AdMob for next round
        break;
      default:
        _adSequenceIndex = 0; // Default back to AdMob
    }
  }

  // Handle click logic and show ad after 4 clicks
  void _handleClick() {
    setState(() {
      _clickCount++;
      if (_clickCount >= 4) {
        _showSequentialAd(); // Show random ad after 4 clicks
        _clickCount = 0; // Reset the click counter
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //show dialog when user press back button
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.8),
                title: Text(
                  'Exit',
                  style: GoogleFonts.skranji(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                content: Text(
                  'Are you sure you want to exit?',
                  style: GoogleFonts.skranji(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No',
                        style: GoogleFonts.skranji(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: Text(
                      'Yes',
                      style: GoogleFonts.skranji(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      inAppReview.requestReview(); // Fixed requestReview method
                    },
                    child: Text(
                      'Rate Us',
                      style: GoogleFonts.skranji(
                        color: Colors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              );
            });
        return Future.value(false);
      },
      child: Consumer<DataProvider>(
        builder: (context, value, child) => Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    value.data.splashUrl.toString(),
                  ),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 35.0, sigmaY: 35.0),
              child: Container(
                color: Colors.black.withOpacity(0.8),
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      SizedBox(
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 111,
                                width: 111,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300]!,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        value.data.appIcon.toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/profile');
                              },
                              child: Opacity(
                                opacity: 0.80,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.person_outline_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      BorderedText(
                        strokeColor: Colors.white.withOpacity(0.15),
                        child: Text(
                          value.data.appName.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.skranji(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                            itemCount: value.data.content!.length,
                            itemBuilder: (context, index) {
                              return homeItem(
                                context,
                                value.data.content![index].name.toString(),
                                value.data.content![index].number.toString(),
                                value.data.content![index].icon.toString(),
                                () {
                                  _handleClick(); // Handle clicks to show ads
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return CallScreen(
                                        content: value.data.content![index],
                                      );
                                    },
                                  ));
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
