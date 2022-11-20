import 'package:animation_app/src/core/enums/login_states_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Artboard? riveArtBoard;
  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerLookDownRight;
  late RiveAnimationController controllerLookDownLeft;
  late RiveAnimationController controllerFail;
  late RiveAnimationController controllerLookIdle;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final String testEmail = 'test12@gmail.com';
  final String testPassword = 'Asd@123';
  final FocusNode passwordNode = FocusNode();
  bool isLookingLeft = false;
  bool isLookingRight = false;

  void removeAllControllers() {
    riveArtBoard?.artboard.removeController(controllerIdle);
    riveArtBoard?.artboard.removeController(controllerHandsUp);
    riveArtBoard?.artboard.removeController(controllerHandsDown);
    riveArtBoard?.artboard.removeController(controllerSuccess);
    riveArtBoard?.artboard.removeController(controllerFail);
    riveArtBoard?.artboard.removeController(controllerLookDownLeft);
    riveArtBoard?.artboard.removeController(controllerLookDownRight);
    riveArtBoard?.artboard.removeController(controllerLookIdle);
    isLookingLeft = false;
    isLookingRight = false;
    debugPrint('Success Removal');
  }

  void addIdleController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerIdle);
    debugPrint('idle');
  }

  void addHandsUpController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerHandsUp);
    debugPrint('hands up');
  }

  void addHandsDownController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerHandsDown);
    debugPrint('HandsDown');
  }

  void addSuccessController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerSuccess);
    debugPrint('Success');
  }

  void addFailController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerFail);
    debugPrint('Fail');
  }

  void addLookDownLeftController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerLookDownLeft);
    isLookingLeft = true;
    debugPrint('LookDownLeft');
  }

  void addLookDownRightController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerLookDownRight);
    isLookingRight = true;
    debugPrint('LookDownRight');
  }

  void addLookIdleController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerLookIdle);
    debugPrint('look idle');
  }

  void checkForPasswordNodeToChangeAnimationState() {
    passwordNode.addListener(() {
      if (passwordNode.hasFocus) {
        addHandsUpController();
      } else if (!passwordNode.hasFocus) {
        addHandsDownController();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllerIdle = SimpleAnimation(LoginStatesEnum.idle.name);
    controllerHandsUp = SimpleAnimation(LoginStatesEnum.Hands_up.name);
    controllerHandsDown = SimpleAnimation(LoginStatesEnum.hands_down.name);
    controllerSuccess = SimpleAnimation(LoginStatesEnum.success.name);
    controllerFail = SimpleAnimation(LoginStatesEnum.fail.name);
    controllerLookDownRight =
        SimpleAnimation(LoginStatesEnum.Look_down_right.name);
    controllerLookDownLeft =
        SimpleAnimation(LoginStatesEnum.Look_down_left.name);
    controllerLookIdle = SimpleAnimation(LoginStatesEnum.look_idle.name);

    // load animated file
    rootBundle.load('assets/rives/animated_login_screen.riv').then((data) {
      // load animation file as overall 'المستطيل الكبير باضلعه'
      final file = RiveFile.import(data);
      // load animation with it's states 'جسم المستطبل بحالاته'
      final Artboard artboard = file.mainArtboard;
      artboard.addController(controllerIdle);
      setState(() {
        riveArtBoard = artboard;
      });
    });
    checkForPasswordNodeToChangeAnimationState();
  }

  void validateEmailAndPassword() {
    Future.delayed(const Duration(seconds: 1), () {
      if (loginFormKey.currentState!.validate()) {
        addSuccessController();
      } else {
        addFailController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Animated Login ^_^',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          10.0,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: riveArtBoard == null
                  ? const SizedBox.shrink()
                  : Rive(
                      artboard: riveArtBoard!,
                    ),
            ),
            Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            value.length < 16 &&
                            !isLookingLeft) {
                          addLookDownLeftController();
                        } else if (value.isNotEmpty &&
                            value.length > 16 &&
                            !isLookingRight) {
                          addLookDownRightController();
                        }
                      },
                      validator: (value) {
                        return value != testEmail ? 'Wrong Email -_-' : null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      obscureText: true,
                      focusNode: passwordNode,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      validator: (value) =>
                          value != testPassword ? 'Wrong password -_-' : null,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    TextButton(
                      onPressed: () {
                        passwordNode.unfocus();
                        validateEmailAndPassword();
                      },
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
