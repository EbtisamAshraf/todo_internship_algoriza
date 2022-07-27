import 'package:flutter/material.dart';
import 'package:todo_internship_algoriza/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.title,
      this.hintText,
      this.suffixIcon,
      this.controller,
      this.validator})
      : super(key: key);
  final String title;
  final String? hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: controller,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            fillColor: AppColors.hintColor.withOpacity(0.2),
            filled: true,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.hintColor.withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor.withOpacity(0.5),
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          validator: validator,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
