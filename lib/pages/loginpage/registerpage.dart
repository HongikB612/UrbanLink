import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbanlink_project/pages/loginpage/loginpage.dart';
import 'package:urbanlink_project/pages/mainpage/mainpage.dart';
import 'package:urbanlink_project/services/auth.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'registerpage';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(); //입력되는 값을 제어
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  Widget _userNameWidget() {
    return TextFormField(
      controller: _userNameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '이름',
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          // == null or isEmpty
          return '이름을 입력해주세요.';
        }
        return null;
      },
    );
  }

  Widget _userEmailWidget() {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("회원가입"),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                _userNameWidget(),
                const SizedBox(
                  height: 20,
                ),
                _userEmailWidget(),
                const SizedBox(
                  height: 20,
                ),
                _passwordWidget(),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _authProvider();
                  },
                  child: const Text('회원가입'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => const LoginPage());
                  },
                  child: const Text('로그인 페이지로 돌아가기'),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();
  }

  @override
  void dispose() {
    // 해당 클래스가 사라질떄
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _authProvider() async {
    //키보드 숨기기
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());

      // Firebase 사용자 인증, 사용자 등록
      try {
        await _auth.registerWithEmailAndPassword(_userNameController.text,
            _emailController.text, _passwordController.text);

        Get.offAll(() => const MainPage());
      } on FirebaseAuthException catch (e) {
        logger.e(e.code);
        String message = '';

        if (e.code == 'email-already-in-use') {
          message = '이미 사용중인 이메일입니다.';
        } else if (e.code == 'invalid-email') {
          message = '이메일 형식이 올바르지 않습니다.';
        } else if (e.code == 'weak-password') {
          message = '비밀번호가 너무 약합니다.';
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