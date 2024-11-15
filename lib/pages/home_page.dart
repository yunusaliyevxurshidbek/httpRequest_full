import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:http_request//service/http_service.dart';

import '../model/post_model.dart';
import '../service/http_service.dart';
import '../service/log_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String jsonString = "no data";

  apiLoadPostList() async{
    var url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
  }

  apiLoadPostList2() async{
    var response = await HttpService.GET(HttpService.API_POST_LIST, HttpService.paramsEmpty());
    LogService.e(response!);

    setState(() {
      jsonString = response;
    });
  }

  apiLoadPostList3() async{
    Post post = Post(title: "NextGen", body: "Academy", userId: 1);

    var response = await HttpService.POST(HttpService.API_POST_CREATE, HttpService.paramsCreatePost(post));
    LogService.i(response!);
  }

  apiLoadPostList4() async{
    Post post = Post(id: 1,title: "NextGen", body: "Academy", userId: 1);

    var response = await HttpService.PUT(HttpService.API_POST_UPDATE+post.id.toString(), HttpService.paramsUpdatePost(post));
    LogService.i(response!);
  }

  apiLoadPostList5() async{
    Post post = Post(id: 1,title: "NextGen", body: "Academy", userId: 1);

    var response = await HttpService.DEL(HttpService.API_POST_DELETE+post.id.toString(), HttpService.paramsEmpty());
    LogService.i(response!);
  }

  @override
  void initState() {
    super.initState();
    apiLoadPostList2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(jsonString),
      ),
    );
  }
}