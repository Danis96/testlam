import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lamp/theme/color_helper.dart';

enum TextFieldType { passwordType, textAreaType, dropdownFieldType }

class Lamp_TextFormField extends StatefulWidget {
  const Lamp_TextFormField({
    Key? key,
    this.label = '',
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.icon,
    this.errorTextEmpty,
    this.identical = true,
    this.onChange,
    this.fKey,
    this.readOnly = false,
    this.type,
    this.errorTextConfirm,
    this.dropdownPressFunction,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.validation,
    this.errorMessage,
    this.inputColor = Colors.black,
    this.textAlign = TextAlign.center,
    this.prefixIcon,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool identical;
  final Widget? icon;
  final String? errorTextEmpty;
  final String? errorTextConfirm;
  final Function? onChange;
  final Function? dropdownPressFunction;
  final Function? onTap;
  final Key? fKey;
  final bool readOnly;
  final TextFieldType? type;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validation;
  final TextCapitalization textCapitalization;
  final String? errorMessage;
  final Color inputColor;
  final TextAlign textAlign;
  final Widget? prefixIcon;

  @override
  _Lamp_TextFormFieldState createState() => _Lamp_TextFormFieldState();
}

class _Lamp_TextFormFieldState extends State<Lamp_TextFormField> {
  bool filled = true;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildFieldLabel(widget.label),
        _buildTextFormField(
          inputColor: widget.inputColor,
          onChanged: () {
            if (widget.onChange != null) {
              widget.onChange!();
            }
            setState(() {
              widget.controller!.text.isEmpty ? filled = true : filled = false;
            });
          },
          visibilityFunction: () => setState(() {
            _obscure = !_obscure;
          }),
          obscure: _obscure,
          obscureRegular: widget.obscureText,
          filled: filled,
          validation: widget.validation,
          controller: widget.controller,
          hintText: widget.hintText!,
          type: widget.type,
          icon: widget.icon,
          readOnly: widget.readOnly,
          key: widget.fKey,
          identical: widget.identical,
          errorTextConfirm: widget.errorTextConfirm,
          errorTextEmpty: widget.errorTextEmpty,
          dropdownPressFunction: widget.dropdownPressFunction,
          onTap: widget.onTap,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          textCapitalization: widget.textCapitalization,
          errorMessage: widget.errorMessage,
          textAlign: widget.textAlign,
          prefixIcon: widget.prefixIcon,
        ),
      ],
    );
  }
}

Widget _buildFieldLabel(String label) {
  return Container(
    margin: const EdgeInsets.only(bottom: 1.0),
    child: Text(label, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 16, fontStyle: FontStyle.normal)),
  );
}

Widget _buildTextFormField({
  TextEditingController? controller,
  bool readOnly = false,
  bool filled = false,
  TextFieldType? type,
  bool obscure = false,
  bool obscureRegular = false,
  Widget? icon,
  String hintText = '',
  Function? onChanged,
  Function? visibilityFunction,
  Function? dropdownPressFunction,
  Function? onTap,
  String? Function(String?)? validation,
  Key? key,
  String? errorTextConfirm,
  String? errorTextEmpty,
  bool identical = true,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
  TextCapitalization? textCapitalization,
  String? errorMessage,
  Color inputColor = Colors.black,
  TextAlign textAlign = TextAlign.center,
  Widget? prefixIcon,
}) {
  bool isPasswordType() => type == TextFieldType.passwordType;
  bool isDropDownType() => type == TextFieldType.dropdownFieldType;
  return SizedBox(
    child: TextFormField(
      key: key,
      style: TextStyle(color: ColorHelper.lampGray.color, fontSize: 16.0, fontWeight: FontWeight.w400),
      maxLines: type == TextFieldType.textAreaType ? 10 : 1,
      textCapitalization: textCapitalization!,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      onTap: () => onTap != null ? onTap() : print(''),
      onChanged: (String input) => onChanged!(),
      readOnly: readOnly,
      obscuringCharacter: '*',
      obscureText: isPasswordType() ? obscure : obscureRegular,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: ColorHelper.lampGray.color,
        helperText: '',
        suffixIcon: icon,
        hintText: hintText,
        focusColor: ColorHelper.lampLightGray.color,
      ),
    ),
  );
}
