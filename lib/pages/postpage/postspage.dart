import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SubDetail();
}

class _SubDetail extends State<PostsPage>{

  List<String> todoList = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    todoList.add('글1');
    todoList.add('글2');
    todoList.add('글3');
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
            child: Text(todoList[index], style: TextStyle(fontSize: 30),) ,
            onTap: (){
              Navigator.of(context).pushNamed('/posted' , arguments: todoList[index]);
            },
          ),
        );
      }, itemCount: todoList.length,),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _addNavigation(context);
      }, child: Icon(Icons.add),),
    );
  }
  void _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/posting');
    setState(() {
      todoList.add(result as String);
    });
  }

}