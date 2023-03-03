import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbanlink_project/pages/loginpage/login.dart';
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

  // 로그인 폼 상단에 이미지가 표시된다. 이미지가 없어도 동작은 하나, X표시 처리.
  final String _imageFile = 'assets/images/profileImage.jpeg';

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
          child: Column(
            children: [
              Image(width: 400.0, height: 250.0, image: AssetImage(_imageFile)),
              const SizedBox(height: 20.0),
              _userIdWidget(),
              const SizedBox(height: 20.0),
              _passwordWidget(),
              Container(
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                    onPressed: () => _authProvider(),
                    child: const Text("회원가입")),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  ),
                  onPressed: () => Get.off(const LoginPage()),
                  child: const Text('뒤로 가기')),
            ],
          ),
        ),
      ),
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
        await _auth.registerWithEmailAndPassword(
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
