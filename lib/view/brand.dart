import 'package:fakecall/main.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Provider.of<DataProvider>(context, listen: false).setData(data);
        Navigator.pushReplacementNamed(context, '/');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 125,
            width: 125,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.brand),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 55,
              child: Column(
                children: [
                  const Text(
                    'Generated by Mobtwinny',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Abel',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.17,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          ImageConstants.brand,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 22,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffE87472),
                              Color(0xffF16391),
                            ],
                            begin: Alignment(1.00, 0.00),
                            end: Alignment(-1, 0),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          'AI Builder',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Abel',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.14,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
