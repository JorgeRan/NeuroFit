import 'package:flutter/material.dart';
import 'package:neurofit_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:neurofit_app/screens/onboarding/signUp_page.dart';
import 'package:neurofit_app/widgets.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List<Widget> onboardingCards = [
    OnboardingCard(
      iconCard: onboardingCardIcons[0],
      header: onboardingCardHeaders[0],
      body: onboardingCardBodies[0],
    ),
    OnboardingCard(
      iconCard: onboardingCardIcons[1],
      header: onboardingCardHeaders[1],
      body: onboardingCardBodies[1],
    ),
    OnboardingCard(
      iconCard: onboardingCardIcons[2],
      header: onboardingCardHeaders[2],
      body: onboardingCardBodies[2],
    ),
  ];

  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kBlue,
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Hero(
                        tag: 'welcomeLogo',
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: SvgPicture.asset(
                            'images/logo.svg',
                            semanticsLabel: 'NeuroFit Logo',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 24, 32, 10),
                        child: Text(
                          'Track your health. Understand your body. Get personalized tips, powered by AI and science.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CarouselSlider(
                        items: onboardingCards,
                        carouselController: _controller,
                        options: CarouselOptions(
                            height: 370.0,
                            viewportFraction: 0.75,
                            autoPlay: true,
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: onboardingCards.asMap().entries.map((entry) {
                      //     return GestureDetector(
                      //       onTap: () => _controller.animateToPage(entry.key),
                      //       child: Container(
                      //         width: 12.0,
                      //         height: 12.0,
                      //         margin: EdgeInsets.symmetric(
                      //             vertical: 8.0, horizontal: 4.0),
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: (Theme.of(context).brightness ==
                      //                         Brightness.dark
                      //                     ? Colors.white
                      //                     : Colors.black)
                      //                 .withAlpha(
                      //                     (_current == entry.key ? 0.9 : 0.4) *
                      //                         255 ~/
                      //                         1)),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        
                        width: 250,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kLightGrey,
                              elevation: elevationButtons),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          ),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32), // Padding from bottom
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
