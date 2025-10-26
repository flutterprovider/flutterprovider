import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemChip extends StatelessWidget {
  const ItemChip({super.key, required this.itemName, this.width = 110});

  final String? itemName;
  final double width;

  // final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 55,
        maxHeight: 55,
        minWidth: width,
        maxWidth: width,
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFECECEC), width: 1),
        color: Color(0x88FAFAFA),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              itemName ?? 'Not Available',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center,

              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  height: 1.25,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
