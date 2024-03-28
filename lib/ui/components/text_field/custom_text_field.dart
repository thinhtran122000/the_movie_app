import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool? visibleFiler;
  final bool? obscureText;
  final bool? isAuthentication;
  final bool? enabledSearch;
  final bool? isFocused;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Function(PointerEvent)? onTapOutside;
  final VoidCallback? onTapCancel;
  final void Function(String)? onChanged;
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 30.h, 12.w, 0),
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
                  controller: controller,
                  cursorColor: darkBlueColor,
                  obscureText: obscureText ?? false,
                  onChanged: onChanged,
                  onTapOutside: onTapOutside,
                  onTap: onTap,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: whiteColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    hintText: isFocused ?? false ? '' : hintText,
                    hintStyle: TextStyle(
                      color: greyColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: suffixIcon,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    prefixIcon: (isAuthentication ?? false)
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
          SizedBox(width: enabledSearch ?? false ? 15.w : 0),
          GestureDetector(
            onTap: onTapCancel,
            child: AnimatedSize(
              curve: Curves.easeInSine,
              duration: const Duration(milliseconds: 100),
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: enabledSearch ?? false ? 55 : 0,
                height: enabledSearch ?? false ? 20 : 0,
                child: Text(
                  'Cancel',
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
}
