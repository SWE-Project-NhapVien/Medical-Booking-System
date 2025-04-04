import 'package:flutter/material.dart';

import '../utils/color_palette.dart';
import '../utils/text_styles.dart';

// ignore: must_be_immutable
class CommonTextField extends StatefulWidget {
  final IconData? prefixIconData, suffixIconData, selectedIconData;
  final Color? fillColor;
  final Color? initialIconColor;
  final Color? cursorColor;
  final TextInputType? keyboardType;
  final String? errorText;
  final String? suffixText;
  final TextStyle hintTextStyle;
  final TextEditingController? textEditingController;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry textFieldPadding;
  final Color focusColor;
  final String hintText;
  final double radius;
  bool isObscureText;
  final ValueChanged<String>? onChanged;

  CommonTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20),
    this.fillColor = const Color(0xFFECF1FF),
    this.hintTextStyle = const TextStyle(color: Color(0xFF809CFF)),
    this.focusColor = const Color(0xFF2260FF),
    this.textFieldPadding = const EdgeInsets.only(bottom: 10),
    this.initialIconColor,
    this.keyboardType,
    this.selectedIconData,
    this.errorText,
    this.suffixText,
    this.suffixIconData,
    this.prefixIconData,
    this.cursorColor,
    this.radius = 32,
    this.isObscureText = false,
    this.onChanged,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late final FocusNode _focusNode;
  late Color _iconColor;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _iconColor = widget.initialIconColor ?? ColorPalette.greyColor;
    if (widget.isObscureText) _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _iconColor = _focusNode.hasFocus ? widget.focusColor : ColorPalette.greyColor;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.textFieldPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField( 
            textAlign: TextAlign.left,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.isObscureText,
            cursorColor: widget.cursorColor,
            obscuringCharacter: '*',
            autocorrect: false,
            controller: widget.textEditingController,
            style: TextStyles(context).getRegularStyle(),
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              suffixText: widget.suffixText?? '',
              suffixStyle: TextStyles(context).getRegularStyle(
                color: ColorPalette.lightBlueTextColor
              ),
              prefixIcon: widget.prefixIconData != null
                  ? Icon(widget.prefixIconData, color: _iconColor)
                  : null,
              suffixIcon: widget.suffixIconData != null
                  ? IconButton(
                      isSelected: !widget.isObscureText,
                      icon: Icon(widget.suffixIconData, color: _iconColor),
                      selectedIcon:
                          Icon(widget.selectedIconData, color: _iconColor),
                      onPressed: () => setState(() {
                        widget.isObscureText = !widget.isObscureText;
                      }),
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
                borderSide: BorderSide(
                  color: widget.fillColor ?? Colors.transparent, // Enabled border color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
                borderSide: BorderSide(
                  color: widget.focusColor,
                ),
              ),
              fillColor: widget.fillColor,
              filled: true,
            ),
            onChanged: widget.onChanged,
          ),
          if (widget.errorText != null && widget.errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 8),
                child: Text(
                widget.errorText ?? "",
                style: TextStyles(context).getSmallStyle().copyWith(
                    color: ColorPalette.redColor,
                    fontStyle: FontStyle.italic,
                  ),
              ),
            ),
        ],
      ),
    );
  }
}
