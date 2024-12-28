import 'package:admin_webapp/utils/color_palette.dart';
import 'package:admin_webapp/utils/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardItem extends StatelessWidget {
  String title;
  String description;

  CardItem({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        color: ColorPalette.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyles(context)
                      .getTitleStyle(size: 18, color: Colors.black)),
              const SizedBox(height: 10.0),
              Text(description,
                  style: TextStyles(context)
                      .getBoldStyle(fontSize: 22, color: Colors.black)),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'From October 2024',
                  style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
