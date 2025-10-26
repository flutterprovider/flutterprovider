import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryChipClose extends StatelessWidget {
  const CategoryChipClose({
    super.key,
    required this.imageUrl,
    required this.catName,
  });

  final String? imageUrl;
  final String catName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFECECEC), width: 1),
        color: Color(0xFFF6EEFF),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 53,
            height: 53,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(0),
              ),
              image: DecorationImage(
                image: AssetImage("packages/flutterprovider/assets/images/aaspas_shopPlaceholder.png"),
                fit: BoxFit.cover, // covers entire container
              ),
            ),
            clipBehavior: Clip.hardEdge,

            child: CachedNetworkImage(
              imageUrl: imageUrl ?? "",
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Image.asset(
                "packages/flutterprovider/assets/images/aaspas_shopPlaceholder.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            catName,
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
          SvgPicture.asset("packages/flutterprovider/assets/icons/aaspas_close_icon.svg"),
        ],
      ),
    );
  }
}
