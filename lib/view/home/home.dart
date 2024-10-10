// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:ui';
import 'package:bordered_text/bordered_text.dart';
import 'package:fakecall/ads_manager/interstitial_ads/admob_ads/interstitial_ads.dart';
import 'package:fakecall/ads_manager/interstitial_ads/applovin_ads/applovin_ads.dart';
import 'package:fakecall/ads_manager/interstitial_ads/facebook_ads/facebook_ads.dart';
import 'package:fakecall/ads_manager/interstitial_ads/unity_ads/unity_ads.dart';
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

  final AppLovinInterstitialManager _adManagerapplovin =
      AppLovinInterstitialManager();
  Future<void> requestReview() => inAppReview.requestReview();

  final AdMobAds _adManageradmob = AdMobAds();

  @override
  void initState() {
    super.initState();
    _adManageradmob.loadInterstitialAd();
    _adManagerapplovin.initializeAppLovin();
  }

  void _showAd() {
    _adManageradmob.showInterstitialAd();
    _adManageradmob.loadInterstitialAd(); // Load a new ad for the next time
    // Show the ad when a button is pressed
  }

// This function increments the counter and shows the ad every 4th click
  void _handleClick() {
    setState(() {
      _clickCount++;
      if (_clickCount >= 4) {
        _showAd(); // Show ad after 4 clicks
        _clickCount = 0; // Reset the click count after showing the ad
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
                backgroundColor: Colors.black.withOpacity(0.800000011920929),
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
                      requestReview();
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
                color: Colors.black.withOpacity(0.800000011920929),
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 45,
                      ),
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
                                      color: Colors.white
                                          .withOpacity(0.15000000596046448),
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
                        strokeColor:
                            Colors.white.withOpacity(0.15000000596046448),
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
                      const SizedBox(
                        height: 20,
                      ),
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
                                _handleClick();
                                FacebookAds().handleClickfb();
                                //UnityAdsManager.handleClick();
                                _adManagerapplovin.showInterstitialAd();
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return CallScreen(
                                      content: value.data.content![index],
                                    );
                                  },
                                ));
                              });
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
