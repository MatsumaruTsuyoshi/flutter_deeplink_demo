import 'dart:async'; //mixin使わない場合必要
import 'package:flutter/material.dart';
import 'package:flutter_deeplink_demo/mixin_deeplink.dart';
import 'package:uni_links/uni_links.dart'; //mixin使わない場合必要

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with DeepLinkNotificationMixin {
  // StreamSubscription? _sub; //mixin使わない場合必要
  String? catchLink;
  String? parameter;

  @override
  void initState() {
    super.initState();
    // initUniLinks(); //mixin使わない場合必要
  }

  @override
  void onDeepLinkNotify(Uri? uri) {
    print(uri);
    final link = uri.toString();
    catchLink = link;
    parameter = getQueryParameter(link);
    setState(() {});
  }

  //mixin使わない場合必要
  // Future<void> initUniLinks() async {
  //   _sub = linkStream.listen((String? link) {
  //     //DeepLinkが動いたらここが走る。
  //     catchLink = link;
  //     parameter = getQueryParameter(link);
  //     setState(() {});
  //   }, onError: (err) {
  //     print(err);
  //   });
  // }

  String? getQueryParameter(String? link) {
    if (link == null) return null;
    final uri = Uri.parse(link);
    String? name = uri.queryParameters['name'];
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'リンク：$catchLink',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'パラメーター：$parameter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
