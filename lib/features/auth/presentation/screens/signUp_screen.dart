import 'package:flutter/material.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/auth/presentation/screens/login_screen.dart';
import 'package:neurofit_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/shared/providers.dart';

final signUpEmail = StateProvider<String>((ref) => '');
final signUpPassword = StateProvider<String>((ref) => '');
final firstName = StateProvider<String>((ref) => '');
final lastName = StateProvider<String>((ref) => '');

final unansweredAccountQuestions = StateProvider<Set<int>>((ref) => {});

signUpFunction() {
  print('Sign up function called');
}

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void resetProviders(WidgetRef ref) {
      for (final entry in resettableProviders) {
        ref.read(entry.key.notifier).state = entry.value;
      }
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Hero(
                            tag: 'welcomeTitle',
                            child: Text('NeuroFit', style: kAppName),
                          ),
                          GestureDetector(
                            onTap: () {
                              ref.invalidate(
                                  unansweredAccountQuestions); // reset unanswered
                              ref.invalidate(signInEmail); // reset input
                              ref.invalidate(signInPassword); // reset input
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text('Log In',
                                style: TextStyle(
                                    color: kBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
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
                              'Create Account',
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Text(
                            'Unlock your personalized health insights.',
                            style: TextStyle(
                              color: kBlack,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AccountTextField(
                          header: 'First Name',
                          hintText: 'John',
                          isPassword: false,
                          onChanged: (value) {
                            ref.read(firstName.notifier).state = value;
                          },
                          provider: firstName,
                          questionIndex: 2,
                        ),
                        AccountTextField(
                          header: 'Last Name',
                          hintText: 'Adams',
                          isPassword: false,
                          onChanged: (value) {
                            ref.read(lastName.notifier).state = value;
                          },
                          provider: lastName,
                          questionIndex: 3,
                        ),
                        AccountTextField(
                          header: 'Email Address',
                          hintText: 'you@example.com',
                          isPassword: false,
                          onChanged: (value) {
                            ref.read(signUpEmail.notifier).state = value;
                          },
                          provider: signUpEmail,
                          questionIndex: 0,
                        ),
                        AccountTextField(
                          header: "Password",
                          hintText: '6+ characters',
                          isPassword: true,
                          onChanged: (value) {
                            ref.read(signUpPassword.notifier).state = value;
                          },
                          provider: signUpPassword,
                          questionIndex: 1,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 48,
                          margin: EdgeInsets.only(top: 18),
                          child: ElevatedButton(
                            onPressed: () {
                              // print(
                              //   'Name: $, Surname: $surname, Email: $email, Password: $password',
                              // );
                              ref.read(counterProvider.notifier).state = 0;
                              resetProviders(ref);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => OnboardingScreen(),
                              //     ));

                              final unanswered = <int>{};

                              for (int i = 0; i < signUpProviders.length; i++) {
                                final val = ref.watch(signUpProviders[i]);
                                if (val == '') {
                                  unanswered.add(i);
                                }
                              }

                              print(unanswered);
                              ref
                                  .read(unansweredAccountQuestions.notifier)
                                  .state = unanswered;

                              if (unanswered.isEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OnboardingScreen(),
                                    ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Create Account',
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
                                signInFunction: signUpFunction),
                            SizedBox(width: 20),
                            GoogleAppleButton(
                                appLogin: "apple",
                                signInFunction: signUpFunction),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Column(
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
                                    style:
                                        TextStyle(color: kBlue, fontSize: 15),
                                  ),
                                  TextSpan(
                                    text: 'and ',
                                    style:
                                        TextStyle(color: kBlack, fontSize: 15),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy.',
                                    style:
                                        TextStyle(color: kBlue, fontSize: 15),
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
      ),
    );
  }
}
