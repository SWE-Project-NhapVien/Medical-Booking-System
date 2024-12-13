import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardItem extends StatelessWidget {
  String title;
  String description;

  CardItem({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyles(context)
                    .getTitleStyle(size: 20, color: Colors.black)),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Text(description,
                    style: TextStyles(context)
                        .getBoldStyle(fontSize: 24, color: Colors.black)),
                const SizedBox(width: 20.0),
                Text(
                  'From October 2024',
                  style: TextStyles(context).getDescriptionStyle(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
