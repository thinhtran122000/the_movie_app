import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final bool? visibleFiler;
  final bool? obscureText;
  final bool? isAuthentication;
  final bool? enabledSearch;
  final bool? isFocused;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final VoidCallback? onTapCancel;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Function(PointerEvent)? onTapOutside;

  const CustomTextField({
    super.key,
    this.visibleFiler,
    this.obscureText,
    this.onChanged,
    this.isAuthentication,
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.onTap,
    this.enabledSearch,
    this.onTapCancel,
    this.onTapOutside,
    this.isFocused,
    this.focusNode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(13.w, 30.h, 13.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              height: 33.h,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1),
                ),
                child: TextFormField(
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  cursorColor: darkBlueColor,
                  obscureText: widget.obscureText ?? false,
                  onChanged: widget.onChanged,
                  onTapOutside: widget.onTapOutside,
                  onTap: widget.onTap,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: whiteColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    hintText: (widget.focusNode?.hasFocus ?? false) ? '' : widget.hintText,
                    hintStyle: TextStyle(
                      color: greyColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: widget.suffixIcon,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    prefixIcon: (widget.isAuthentication ?? false)
                        ? null
                        : IconButton(
                            onPressed: null,
                            icon: SvgPicture.asset(
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
          SizedBox(width: widget.enabledSearch ?? false ? 15.w : 0),
          GestureDetector(
            onTap: widget.onTapCancel,
            child: AnimatedSize(
              curve: Curves.easeInSine,
              duration: const Duration(milliseconds: 100),
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: widget.enabledSearch ?? false ? 55 : 0,
                height: widget.enabledSearch ?? false ? 20 : 0,
                child: Text(
                  'Cancel',
                  textScaler: const TextScaler.linear(1),
                  style: TextStyle(
                    color: whiteColor,
                    inherit: false,
                    fontSize: 15.sp,
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
    widget.focusNode?.dispose();
    super.dispose();
  }
}
