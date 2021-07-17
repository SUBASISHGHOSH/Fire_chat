import 'package:fire_chat/screens/login_screen.dart';
import 'package:fire_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fire_chat/components/authentication_Buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController logoController;
  late AnimationController colorController;
  late Animation logoAnimation;
  late Animation colorAnimation;
  String title = '';
  List<String> animatedTitle = ('Flash Chat').split('');
  @override
  void initState() {
    super.initState();
    logoController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    logoController.forward();
    logoAnimation = CurvedAnimation(
      parent: logoController,
      curve: Curves.decelerate,
    );
    logoController.addListener(() {
      setState(() {});
    });

    colorController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    colorAnimation = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(colorController);
    colorController.forward();
    colorController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    colorController.dispose();
    logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: logoAnimation.value * 60,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Fire Chat',
                      textStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: Duration(milliseconds: 200),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            AuthButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              colour: Colors.lightBlueAccent,
              textData: 'Log In',
            ),
            AuthButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              colour: Colors.indigo,
              textData: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
