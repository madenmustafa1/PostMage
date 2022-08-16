// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/util/color_util.dart';
import '/util/router.dart';
import '/view/onboarding/onboarding_steps_photos.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFF7B51D3),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Constants constants = getIt<Constants>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            color: ColorUtil.MAIN_COLOR,
            /*
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
            */
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, CRouter.TUTORIAL),
                    child: const Text(
                      'Atla',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 600.0,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      OnboardingStepPhotos(
                        titleText: constants.step1Title,
                        contentText: constants.step1Content,
                        imagePath: 'assets/images/step_1.png',
                      ),
                      OnboardingStepPhotos(
                        titleText: constants.step2Title,
                        contentText: constants.step2Content,
                        imagePath: 'assets/images/step_2.png',
                      ),
                      OnboardingStepPhotos(
                        titleText: constants.step3Title,
                        contentText: constants.step3Content,
                        imagePath: 'assets/images/step_3.png',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                if (_currentPage != _numPages - 1)
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'İleri',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  const Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => navigateSignUp(),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: SimpleText(
                      text: "Kayıt ol",
                      optionalTextSize: 25,
                      textColor: ColorUtil.MAIN_COLOR,
                    ),
                  ),
                ),
              ),
            )
          : const Text(''),
    );
  }

  void navigateSignUp() => Navigator.pushNamed(context, CRouter.SIGN_UP);
}




/*
Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: SimpleButton(
                buttonStyle: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.red.withOpacity(0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(2),
                    ),
                    side: BorderSide(color: Colors.transparent),
                  ),
                ),
                buttonBackgroundColor: Colors.transparent,
                textColor: ColorUtil.MAIN_COLOR,
                buttonText: "Kayıt ol",
                onPressed: () {},
              ),
            )
*/