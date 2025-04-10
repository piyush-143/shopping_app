import 'package:flutter/material.dart';

import '../utils/colors.dart';

class UiHelper {
  static Widget customText({
    required String? text,
    required double size,
    FontWeight? weight,
    Color? color,
    TextDecoration? textDecoration,
    TextAlign? textAlign,
    double? letterSpacing,
  }) {
    return Text(
      text!,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight ?? FontWeight.w500,
        color: color ?? Colors.black,
        decoration: textDecoration,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign,
    );
  }

  static Widget pricingColumn({
    required String name,
    String? brand,
    required double price,
    required double discount,
  }) {
    double discountedPrice = (price - ((price * discount) / 100)) * 10;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(
          text: name,
          size: 11,
          weight: FontWeight.w700,
          letterSpacing: 0,
        ),
        customText(text: brand, size: 9, weight: FontWeight.w500),
        SizedBox(height: 5),
        Row(
          spacing: 5,
          children: [
            customText(
              text: "₹${(price * 10).toStringAsFixed(2)}",
              size: 8,
              textDecoration: TextDecoration.lineThrough,
              color: Colors.black45,
            ),
            customText(
              text: "₹${discountedPrice.toStringAsFixed(2)}",
              size: 12,
            ),
          ],
        ),
        customText(
          text: "$discount% OFF",
          size: 8,
          color: AppColors.buttonBgColor,
        ),
      ],
    );
  }
}
