import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SubDetail();
}

class _SubDetail extends State<PostsPage>{

  List<String> posts = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    posts.add('글1');
    posts.add('글2');
    posts.add('글3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
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
  void _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/posting');
    setState(() {
      posts.add(result as String);
    });
  }

}