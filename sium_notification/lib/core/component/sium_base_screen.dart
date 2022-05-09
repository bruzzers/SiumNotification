// coverage:ignore-file
import 'package:flutter/material.dart';

class SiumBaseScreen extends StatelessWidget{
  final Widget body;
  final String title;
  final bool? loading;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: [
          if(loading == true)
            const Align(alignment: Alignment.center,child: CircularProgressIndicator()),
          body
        ],
      ),
    );
  }

  const SiumBaseScreen({
    required this.body,
    required this.title,
    required this.loading,
  });
}