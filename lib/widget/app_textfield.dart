import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/color_utils.dart';

class AppTextField extends StatefulWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final Function()? onPressed;
  final TextEditingController? controller;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final String labelText;
  final String? hintText;
  final String? initialValue;
  final bool? autoFocus;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final FormFieldSetter<String>? onSaved;
  final Function(String)? onFieldSubmitted;
  final bool? readOnly;
  final int? maxLength;
  final bool? obscureText;
  final String obscuringCharacter;
  final TextCapitalization textCapitalization;
  final Widget Function(bool enabled, String value)? suffixIcon;
  final Widget Function()? prefixIcon;
  final Key? key;
  final Widget Function()? prefix;
  final bool enabled;
  final int maxLines;
  final int minLines;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final bool busy;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool filled;
  final Color filledColor;
  final double? fontSize;
  final double labelFontSize;
  final Function(bool hasFocus, bool isValid, String value)? textHintWidget;
  final EdgeInsets dividerPadding;
  final Function? labelIcon;
  final Color? textFieldFocusBorderColor;
  final Color? textFieldBorderColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color? labelColor;
  final double? suffixIconSize;
  final Color? color;
  final EdgeInsets? containerPadding;
  final BorderRadiusGeometry? borderRadius;
  final Iterable<String>? autofillHints;

  AppTextField(
      {this.height,
      this.width,
      this.child,
      this.onPressed,
      this.color = AppColor.white,
      this.controller,
      this.inputAction = TextInputAction.done,
      this.inputType,
      required this.labelText,
      this.hintText,
      this.initialValue,
      this.autoFocus = false,
      this.validator,
      this.onSaved,
      this.readOnly = false,
      this.maxLength,
      this.key,
      this.obscureText = false,
      this.obscuringCharacter = '•',
      this.textCapitalization = TextCapitalization.none,
      this.suffixIcon,
      this.prefixIcon,
      this.prefix,
      this.enabled = true,
      this.inputFormatters,
      this.busy = false,
      this.maxLines = 1,
      this.minLines = 1,
      this.onChanged,
      this.filled = false,
      this.fontSize,
      this.labelFontSize = 12,
      this.filledColor = AppColor.white,
      this.onFieldSubmitted,
      this.labelIcon,
      this.dividerPadding = const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      this.floatingLabelBehavior = FloatingLabelBehavior.never,
      this.textAlign = TextAlign.start,
      this.textFieldBorderColor,
      this.textFieldFocusBorderColor,
      this.hintTextColor,
      this.textColor,
      this.labelColor,
      this.textHintWidget,
      this.suffixIconSize,
      this.containerPadding,
      this.borderRadius,
      this.autofillHints})
      : super(key: key);

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  late bool _secureText;
  final FocusNode _focusNode = FocusNode();
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    _secureText = widget.obscureText!;
    _focusNode.addListener(_onFocusChange);
  }

  bool get secureText => _secureText;

  set secureText(bool value) {
    setState(() {
      _secureText = value;
    });
  }

  bool get isValid => _isValid;

  set isValid(bool value) {
    setState(() {
      _isValid = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: widget.containerPadding ??
                    (EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0) + EdgeInsets.only(bottom: 6)),
                decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                    border: Border.all(
                        width: 1,
                        color: !isValid
                            ? Theme.of(context).inputDecorationTheme.errorBorder!.borderSide.color
                            : _focusNode.hasFocus
                                ? (widget.textFieldFocusBorderColor ??
                                    Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide.color)
                                : (widget.textFieldBorderColor ??
                                    Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.labelText.isNotEmpty
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: widget.labelText,
                                  style: TextStyle(
                                    color: widget.labelColor ??
                                        Theme.of(context).inputDecorationTheme.labelStyle!.color,
                                    fontSize: widget.labelFontSize ?? 12.0,
                                  )),
                              WidgetSpan(child: widget.labelIcon?.call() ?? SizedBox.shrink())
                            ]),
                          )
                        : const SizedBox.shrink(),
                    SizedBox(height: 6),
                    TextFormField(
                      magnifierConfiguration: TextMagnifierConfiguration.disabled,
                      autofillHints: widget.autofillHints,
                      focusNode: _focusNode,
                      maxLength: widget.maxLength,
                      autocorrect: false,
                      textAlign: widget.textAlign,
                      textCapitalization: widget.textCapitalization,
                      style: TextStyle(
                        color: widget.textColor ?? Theme.of(context).primaryColorDark,
                        fontSize: widget.fontSize ?? 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      initialValue: widget.initialValue,
                      autofocus: widget.autoFocus!,
                      textInputAction: widget.inputAction,
                      keyboardType: widget.inputType,
                      inputFormatters: widget.inputFormatters,
                      readOnly: widget.readOnly ?? false,
                      maxLines: widget.maxLines,
                      minLines: widget.minLines,
                      obscureText: secureText,
                      cursorColor: widget.hintTextColor ?? Theme.of(context).textSelectionTheme.cursorColor,
                      obscuringCharacter: widget.obscuringCharacter,
                      decoration: InputDecoration(
                          prefix: widget.prefix?.call(),
                          prefixIcon: widget.prefixIcon?.call(),
                          prefixIconConstraints: BoxConstraints.tightForFinite(),
                          contentPadding: EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                          hintText: widget.hintText,
                          hintMaxLines: 1,
                          counterText: "",
                          alignLabelWithHint: true,
                          isDense: true,
                          filled: widget.filled,
                          fillColor: widget.filledColor,
                          hintStyle: TextStyle(
                            color: widget.hintTextColor ??
                                Theme.of(context).inputDecorationTheme.hintStyle!.color,
                            fontSize: widget.fontSize ?? 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon: widget.suffixIcon?.call(isValid, widget.controller!.text),
                          suffixIconConstraints: BoxConstraints.tight(
                              Size(widget.suffixIconSize ?? 20.0, widget.suffixIconSize ?? 20.0)),
                          enabled: widget.enabled,
                          floatingLabelBehavior: widget.floatingLabelBehavior),
                      controller: widget.controller,
                      validator: widget.validator,
                      onSaved: widget.onSaved,
                      onTap: () => widget.onPressed?.call(),
                      onFieldSubmitted: widget.onFieldSubmitted,
                      onChanged: (value) {
                        setState(() {});
                        widget.onChanged?.call(value);
                      },
                    ),
                  ],
                ),
              ),
              widget.textHintWidget?.call(_focusNode.hasFocus, isValid, widget.controller!.text) ??
                  const SizedBox.shrink(),
            ],
          )),
    );
  }

  void _onFocusChange() {
    setState(() {
      isValid = true;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }
}
