import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/pages/loginpage/animationpage.dart';
import 'package:urbanlink_project/pages/loginpage/registerpage.dart';
import 'package:urbanlink_project/pages/mainpage/mainpage.dart';
import 'package:urbanlink_project/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool isDone = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  Widget _userIdWidget() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '이메일',
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          // == null or isEmpty
          return '이메일을 입력해주세요.';
        }
        return null;
      },
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '비밀번호',
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          // == null or isEmpty
          return '비밀번호를 입력해주세요.';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          isDone = true;
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: !isDone
                  ? const LandingAnimationPage()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(8, 150, 8, 0),
                      child: Column(
                        children: [
                          const Text(
                            "URBAN LINK",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 100.0),
                          _userIdWidget(),
                          const SizedBox(height: 20.0),
                          _passwordWidget(),
                          const SizedBox(height: 50.0),
                          Container(
                            height: 70,
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ElevatedButton(
                                onPressed: () => _login(),
                                child: const Text("로그인")),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            height: 70,
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ElevatedButton(
                                onPressed: () => {
                                      Get.to(() => const RegisterPage()),
                                    },
                                child: const Text("회원가입")),
                          ),
                          const SizedBox(height: 20.0),
                          GestureDetector(
                            child: const Text(
                              '로그인 하지 않고 이용하기',
                              style: TextStyle(
                                color: Color.fromARGB(250, 63, 186, 219),
                              ),
                            ),
                            onTap: () {
                              Get.offAll(() => const MainPage());
                            },
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isDone = true;
      });
    });
  }

  @override
  void dispose() {
    // 해당 클래스가 사라질떄
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _login() async {
    //키보드 숨기기
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());

      // Firebase 사용자 인증, 사용자 등록
      try {
        await _auth.signInWithEmailAndPassword(
            _emailController.text, _passwordController.text);

        Get.offAll(() => const MainPage());
      } on FirebaseAuthException catch (e) {
        logger.e(e.code);
        String message = '';

        if (e.code == 'user-not-found') {
          message = '사용자가 존재하지 않습니다.';
        } else if (e.code == 'wrong-password') {
          message = '비밀번호를 확인하세요';
        } else if (e.code == 'invalid-email') {
          message = '이메일을 확인하세요.';
        } else {
          message = '알 수 없는 오류가 발생했습니다.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.deepOrange,
          ),
        );
      } catch (e) {
        logger.e(e);
      }
    }
  }
}
