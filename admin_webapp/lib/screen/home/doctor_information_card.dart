import 'package:admin_webapp/utils/color_palette.dart';
import 'package:admin_webapp/utils/localfiles.dart';
import 'package:admin_webapp/utils/text_styles.dart';
import 'package:admin_webapp/widgets/tap_effect.dart';
import 'package:flutter/material.dart';

class DoctorInformationCard extends StatelessWidget {
  const DoctorInformationCard({
    super.key,
    required this.name,
    required this.specialization,
    required this.phoneNumber,
    required this.avaUrl,
    required this.onTap,
  });

  final String name;
  final List<String> specialization;
  final String phoneNumber;
  final String avaUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.15,
      child: TapEffect(
        onClick: () => onTap(),
        child: Card(
          color: ColorPalette.mediumBlue,
          margin: EdgeInsets.fromLTRB(
            size.width * 0.02,
            size.height * 0.015,
            size.width * 0.02,
            0
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.02),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.025,
                      backgroundImage: avaUrl.isNotEmpty
                          ? NetworkImage(avaUrl)
                          : const AssetImage(Localfiles.defaultProfilePicture),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyles(context).getTitleStyle(
                              size: 20,
                              fontWeight: FontWeight.w500,
                              color: ColorPalette.deepBlue),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Row(
                          children: [
                            _schedule(
                                iconData: Icons.check,
                                info: specialization.join(', '),
                                context: context),
                            _schedule(
                                iconData: Icons.phone_callback_rounded,
                                info: phoneNumber,
                                context: context),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _schedule(
      {required IconData iconData,
      required String info,
      required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: ColorPalette.whiteColor,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Center(
        child: Row(
          children: [
            Icon(iconData, color: ColorPalette.deepBlue, size: 12.0),
            const SizedBox(width: 6.0),
            Text(info,
                style: TextStyles(context)
                    .getRegularStyle(size: 14, color: ColorPalette.deepBlue)),
          ],
        ),
      ),
    );
  }
}
