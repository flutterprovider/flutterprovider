import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopListCard extends StatelessWidget {
  final String? dp;
  final bool? anyJob;
  final bool? verified;
  final String? title;
  final String? address;
  final String? distance;
  final double? lat;
  final double? long;
  final VoidCallback? onPress;

  const ShopListCard({
    super.key,
    this.anyJob,
    this.title,
    this.dp,
    this.distance,
    this.address,
    this.lat,
    this.long,
    this.verified = false,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        color: Colors.purple.withAlpha(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 80,
                width: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: dp!,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                      placeholder: (context, url) => Image.asset(
                        'packages/flutterprovider/assets/images/aaspas_shopPlaceholder.png',
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'packages/flutterprovider/assets/images/aaspas_shopPlaceholder.png',
                      ),
                    ),
                    if (anyJob == true)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 50,
                          height: 18,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                            ),
                          ),
                          child: Text(
                            "Job",
                            style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (verified == true)
                          SvgPicture.asset(
                            "packages/flutterprovider/assets/icons/aaspas_verified_icon.svg",
                            width: 20,
                            height: 20,
                          ),
                        if (verified == true) SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            title ?? "No title",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                              color: Color(0xFF1D1B20),
                            ),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 58),

                          child: Text(
                            distance ?? "NA KM",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: Color(0xFF732FCB)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            address ?? "No address",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                              color: Color(0xFF49454F),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            log("Direction icon tapped");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 47,
                            child: SvgPicture.asset(
                              "packages/flutterprovider/assets/icons/aaspas_direction_icon.svg",
                              width: 36,
                              height: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
