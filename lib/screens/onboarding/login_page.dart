import 'package:flutter/material.dart';
import 'package:neurofit_app/constants.dart';
import 'package:neurofit_app/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/screens/onboarding_screen.dart';
import 'signUp_page.dart';

final signInEmail = StateProvider<String?>((ref) => '');
final signInPassword = StateProvider<String?>((ref) => '');

signInFunction() {
  // Placeholder for sign-in function
  print('Sign in function called');
}

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_new,
                              color: kBlue, size: 24),
                        ),
                        Hero(
                          tag: 'welcomeTitle',
                          child: Text(
                            'NeuroFit',
                            style: kAppName,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
                          child: Text(
                            'Welcome Back 👋',
                            style: TextStyle(
                              color: kBlack,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Text(
                          'Access your personalized health insights.',
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AccountTextField(
                          header: 'Email Address',
                          hintText: 'Email',
                          isPassword: false,
                          onChanged: (value) {
                            ref.read(signInEmail.notifier).state = value;
                          },
                          provider: signInEmail,
                          questionIndex: 0,
                        ),
                        AccountTextField(
                          header: "Password",
                          hintText: 'Password',
                          isPassword: true,
                          onChanged: (value) {
                            ref.read(signInPassword.notifier).state = value;
                          },
                          provider: signInPassword,
                          questionIndex: 1,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 48,
                          margin: EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              final email = ref.read(signInEmail);
                              final password = ref.read(signInPassword);
                              print('Email: $email, Password: $password');

                              final unanswered = <int>{};

                              
                              if (ref.watch(signInEmail) == '') {
                                unanswered.add(0);
                              } 
                              if (ref.watch(signInPassword) == '') {
                                unanswered.add(1);
                              }

                              ref
                                  .read(unansweredAccountQuestions.notifier)
                                  .state = {...unanswered};
                              print(
                                  "Unanswered: ${ref.read(unansweredAccountQuestions)}");

                              if (unanswered.isEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OnboardingScreen()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Log In',
                              style: TextStyle(color: kWhite, fontSize: 16),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoogleAppleButton(
                                appLogin: 'google',
                                signInFunction: signInFunction),
                            SizedBox(width: 20),
                            GoogleAppleButton(
                                appLogin: "apple",
                                signInFunction: signInFunction),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'By continuing, you agree to ',
                              style: TextStyle(color: kBlack, fontSize: 15),
                              children: [
                                TextSpan(
                                  text: 'Terms of Service ',
                                  style: TextStyle(color: kBlue, fontSize: 15),
                                ),
                                TextSpan(
                                  text: 'and ',
                                  style: TextStyle(color: kBlack, fontSize: 15),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style: TextStyle(color: kBlue, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
