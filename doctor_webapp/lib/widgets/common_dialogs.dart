import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:doctor_webapp/utils/localfiles.dart';
import 'package:doctor_webapp/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Dialogs {
  final BuildContext context;
  Dialogs(this.context);

  Future<dynamic> showLoadingDialog() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        double lottieSize = MediaQuery.of(context).size.width * 0.2;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Lottie.asset(
              Localfiles.loading,
              width: lottieSize,
            ));
      },
    );
  }

  Future<void> showErrorDialog({String title = 'Error', required String message, String buttonText = 'Got it!'}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                title,
                style: TextStyles(context).getTitleStyle(
                    size: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.deepBlue),
              ),
              scrollable: true,
              backgroundColor: ColorPalette.blueFormColor,
              content: SingleChildScrollView(
                child: Text(
                  message,
                  style: TextStyles(context)
                      .getRegularStyle(color: ColorPalette.redColor),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      buttonText,
                      style: TextStyles(context).getTitleStyle(
                        size: 18,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.blackColor,
                      ),
                    ))
              ]);
        });
  }

  Future<void> showAnimatedDialog(
      {required String title, required String content}) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (content, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: AlertDialog(
                backgroundColor: ColorPalette.blueFormColor,
                title: Text(
                  title,
                  style: TextStyles(context).getTitleStyle(
                      size: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.deepBlue),
                ),
                content: Text(
                  content,
                  style: TextStyles(context)
                      .getRegularStyle(color: ColorPalette.deepBlue)
                      .copyWith(fontStyle: FontStyle.italic),
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none),
              ),
            ),
          );
        });
  }
}
