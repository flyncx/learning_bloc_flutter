import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/view/posts_page.dart';

class InfiniteListApp extends StatelessWidget {
  const InfiniteListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinite List Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PostsPage(),
    );
  }
}
