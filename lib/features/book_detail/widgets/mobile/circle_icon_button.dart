import 'package:flutter/material.dart';
import 'package:gcommerce/core/constants/app_colors.dart';


class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key, 
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.border,
        ),
        color: Color(0XFFDBECFF),
      ),
      child: IconButton(
        splashColor: AppColors.primary.withOpacity(0.1),
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          size: 20,
          color: AppColors.textPrimary,
        ),
        onPressed: onPressed,
      ),
    );
  }
}