// coverage:ignore-file
import 'package:flutter/material.dart';

import '../../../../core/component/sium_text.dart';
import '../../../../core/constants/text_styles.dart';

class NotificationDetailVotingItem extends StatelessWidget {
  final List<int> list;
  final int? selectedItem;
  final Function(int e) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [const Padding(
        padding: EdgeInsets.only(top: 24.0),
        child: SiumText(
          "Dai un voto alla notifica",
          style: sium16Bold,
        ),
      ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: list
                .map((e) => Expanded(child: Container(
              height: 35.0,
                  color: e == selectedItem ? Colors.blue : null,
                  child: InkWell(
                    onTap: () => onItemTap(e),
                    child: Align(
                    alignment: Alignment.center,
                    child: SiumText(e.toString()),
                  ),
                  ),
                )))
                .toList(),
          ),
        ),
      ],
    );
  }

  const NotificationDetailVotingItem({
    required this.list,
    this.selectedItem,
    required this.onItemTap,
  });
}