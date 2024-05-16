import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () {},
      leading: Text('${post.id}', style: textTheme.bodySmall),
      title: Text(post.title, style: textTheme.titleSmall),
      isThreeLine: true,
      subtitle: Text(
        post.body,
        style: textTheme.bodyLarge,
      ),
    );
  }
}
