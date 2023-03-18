import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/widgets/post_list_component.dart';
import 'package:urbanlink_project/pages/postpage/postingpage.dart';
import 'package:urbanlink_project/repositories/post_database_service.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _postListComponent = PostListComponent();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body:
          _postListComponent.postStreamBuilder(PostDatabaseService.getPosts()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (FirebaseAuth.instance.currentUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('로그인이 필요합니다.'),
              ),
            );
            return;
          }
          Get.to(const PostingPage());
        },
        child: const Icon(Icons.post_add),
      ),
      body: ListView.builder(itemBuilder: (context, index){
        return GestureDetector(
          child: Container(
            color: Colors.white54,
            height: 300,
            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                ),
              ),
              color: Colors.white,
              elevation: 10,
              child: Column(
                children: <Widget>[
                  Container(
                    //프로필 사진, 이름, 날짜
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      border: Border.all(
                        width: 0.01,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        topLeft: Radius.zero,
                        topRight: Radius.zero,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 5.0,
                          offset: Offset(0, 2),
                        )
                      ]
                    ),
                  ),
                  Row(
                    children: [
                      //Expanded(child: child)
                      Image.asset('assets/images/GoogleMapTa.jpeg', width: 200, height: 200,fit:BoxFit.contain),
                      //Image.asset('assets/images/bee.png', width: 200, height: 200,fit:BoxFit.contain)
                    ],
                  ),
                  Text("여기는 대박 맛집이고 핫플레이스고 나는 여기서 뭘 했고 어쩌고저쩌고 흔한 SNS 내용", style: TextStyle(fontSize: 7),),
                  Container(
                    //좋아요
                    //저장하기(즐겨찾기에 추가하기)
                  )
                ],

              ),
            ),
          ),
          onTap: (){
            Navigator.of(context).pushNamed('/posted' , arguments: posts[index]);
          },
        );
      }, itemCount: posts.length,),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _addNavigation(context);
      }, child: Icon(Icons.add),),
    );
  }
}
