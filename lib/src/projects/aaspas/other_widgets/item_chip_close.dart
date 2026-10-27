import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemChipClose extends StatelessWidget {
  const ItemChipClose({super.key, required this.itemName});

  final String? itemName;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 55,
        maxHeight: 55,
        minWidth: 148,
        maxWidth: 188,
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFECECEC), width: 1),
        color: Color(0xFFF6EEFF),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            // fit: FlexFit.tight,
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
          SvgPicture.asset("packages/flutterprovider/assets/icons/aaspas_close_icon.svg"),
        ],
      ),
    );
  }
}
