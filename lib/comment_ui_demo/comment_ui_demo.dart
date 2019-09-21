import 'package:flutter/material.dart';

class CommentData {
  String username;
  String text;
  List<CommentData> listSubCmt = [];

  CommentData({this.username = '', this.text = '', this.listSubCmt});
}

class CommentUIDemo extends StatefulWidget {

  @override
  State createState() => CommentUIState();
}

class CommentUIState extends State<CommentUIDemo> {

  List<CommentData> listCommentData;

  @override
  void initState() {
    super.initState();

    listCommentData = List.generate(10, (index) {
      return CommentData(username: index.toString(),
          text: '123123123123123123123123',
          listSubCmt: List.generate(index, (index2) {
            return CommentData(username: "2 $index2", text: ' 2222222222');
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment UI Demo'),
      ),
      body: Column(
        children: List.generate(listCommentData.length, (index) {
          return _buildCommentData(listCommentData[index]);
        }),
      ),
    );
  }

  Widget _buildCommentData(CommentData commentData) {
    return Container(
      child: RichText(text: TextSpan(
        children: [
          TextSpan(
            text: commentData.username
          ),
          TextSpan(
            text: commentData.text
          ),
        ]
      ))
    );
  }
}