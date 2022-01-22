import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
  
class _HomeScreenState extends State<HomeScreen> {
  final url = "https://jsonplaceholder.typicode.com/posts";

  var _postJson = [];
  Future fetchPosts()async{
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _postJson = jsonData;
      });
      
    // ignore: empty_catches
    } catch (e) {}

  }
  @override
  void initState() {
    super.initState();
    fetchPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Http Get'),
        centerTitle: true,
      ),
      body:ListView.builder(
              itemBuilder: (context, i){
                final post = _postJson[i];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Id: ${post["id"]}'),
                      Text('Title: ${post["title"]}'),
                      Text('Body: ${post["body"]}'),
                    ],
                  ),
                );
              },
              itemCount: _postJson.length,
              )
    );
  }
}