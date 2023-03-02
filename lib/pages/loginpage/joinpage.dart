
import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: const Center(
        child: Text('회원가입 페이지'),
      ),
    );
  }
}
