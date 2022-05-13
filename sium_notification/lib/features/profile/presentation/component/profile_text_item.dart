// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';

class ProfileTextItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SiumText(
                      title,
                      style: sium18Bold,
                    ),
                    if(isEditing)
                      TextFormField()
                    else
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: SiumText(
                        value,
                        style: sium16Regular,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: onTap, icon: const Icon(Icons.edit))
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
      ],
    );
  }

  const ProfileTextItem({
    required this.title,
    required this.value,
    required this.onTap,
    required this.isEditing,
  });
}
