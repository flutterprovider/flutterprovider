import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetHeading extends StatelessWidget {
  final String? heading;
  final String? textButtonName;

  const WidgetHeading({super.key, this.heading, this.textButtonName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              heading ?? 'No Heading',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Color(0xFF1D1B20),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (textButtonName != null)
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  // color: Color(0xFFFAF0FE),
                ),
                child: Text(
                  textButtonName ?? "",
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Color(0xFF732FCB),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF732FCB),
                      fontWeight: FontWeight.w600,
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
