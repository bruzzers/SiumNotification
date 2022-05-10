// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_loading.dart';

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
          body,
          if(loading == true)
            Align(alignment: Alignment.center,child: SiumLoading()),
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