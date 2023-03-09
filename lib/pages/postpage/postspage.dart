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
        return Card(
          child: InkWell(
            child: Text(posts[index], style: TextStyle(fontSize: 30),) ,
            onTap: (){
              Navigator.of(context).pushNamed('/posted' , arguments: posts[index]);
            },
          ),
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