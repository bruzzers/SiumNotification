// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sium_notification/core/component/sium_text.dart';
import 'package:sium_notification/core/constants/text_styles.dart';

class SendNotificationDropdown extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final String? selectedItem;
  final Function(String? value) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SiumText("Sede", style: sium16Regular,),
          DropdownButton<String>(
            isExpanded: true,
            value: selectedItem,
            items: items,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  const SendNotificationDropdown({
    required this.items,
    this.selectedItem,
    required this.onChanged,
  });
}
