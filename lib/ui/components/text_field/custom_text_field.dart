import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';

class CustomTextField extends StatefulWidget {
  final Color? shadowColor;
  final Color? backgroundColor;
  final String? hintText;
  final bool? obscureText;
  final bool? isAuthentication;
  final int? indexViewExplore;
  // final bool? enabledSearch;
  final bool? isFocused;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final VoidCallback? onTapCancel;
  final double? height;
  final EdgeInsets? contentPadding;
  final EdgeInsets margin;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Function(PointerEvent)? onTapOutside;
  final InputBorder? border;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? enabledBorder;

  const CustomTextField({
    super.key,
    this.obscureText,
    this.onChanged,
    this.isAuthentication,
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.onTap,
    this.onTapCancel,
    this.onTapOutside,
    this.isFocused,
    this.focusNode,
    this.height,
    this.contentPadding,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    required this.margin,
    this.backgroundColor,
    this.shadowColor,
    this.indexViewExplore,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: noColor,
                boxShadow: [
                  BoxShadow(
                    color: widget.shadowColor ?? noColor,
                    blurRadius: 7,
                  ),
                ],
              ),
              height: widget.height,
              child: TextFormField(
                focusNode: widget.focusNode,
                controller: widget.controller,
                cursorColor: darkBlueColor,
                obscuringCharacter: '●',
                cursorHeight: 18.h,
                obscureText: widget.obscureText ?? false,
                onChanged: widget.onChanged,
                onTapOutside: widget.onTapOutside,
                onTap: widget.onTap,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: blackColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.2.h,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: widget.backgroundColor ?? whiteColor,
                  contentPadding: widget.contentPadding,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: greyColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2.h,
                  ),
                  border: widget.border,
                  focusedBorder: widget.focusedBorder,
                  enabledBorder: widget.enabledBorder,
                  suffixIcon: widget.suffixIcon,
                  suffixIconConstraints: BoxConstraints(
                    minHeight: 24.h,
                    minWidth: 24.w,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: 40.w,
                    maxHeight: 24.w,
                  ),
                  prefixIcon: (widget.isAuthentication ?? false)
                      ? null
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: GestureDetector(
                            onTap: null,
                            child: SvgPicture.asset(
                              IconsPath.searchIcon.assetName,
                              fit: BoxFit.scaleDown,
                              width: 20.w,
                              height: 20.h,
                              colorFilter: ColorFilter.mode(
                                darkBlueColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          SizedBox(width: (widget.indexViewExplore ?? 0) == 1 ? 15.w : 0),
          GestureDetector(
            onTap: widget.onTapCancel,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 100),
              alignment: Alignment.centerRight,
              child: AnimatedScale(
                scale: (widget.indexViewExplore ?? 0) == 1 ? 1.0 : 0,
                curve: Curves.easeInSine,
                duration: const Duration(milliseconds: 100),
                alignment: Alignment.centerRight,
                child: Text(
                  (widget.indexViewExplore ?? 0) == 1 ? 'Cancel' : '',
                  textScaler: const TextScaler.linear(1),
                  style: TextStyle(
                    color: whiteColor,
                    inherit: false,
                    fontSize: 15.sp,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => SystemChannels.textInput.invokeMethod('TextInput.hide'),
    );
    super.initState();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      widget.focusNode?.dispose();
    }
    if (widget.controller == null) {
      widget.controller?.dispose();
    }
    super.dispose();
  }
}
