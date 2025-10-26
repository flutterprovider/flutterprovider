import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PropertyListCard extends StatelessWidget {
  final String? dp;
  final bool? noAnyBroker;
  final bool? verified;
  final String? title;
  final int? totalArea;
  final String? itemType;
  final String? area;
  final String? city;
  final String? phone;
  final VoidCallback? onPress;

  const PropertyListCard({
    super.key,
    this.title,
    this.dp,
    this.verified,
    this.phone,
    this.area,
    this.onPress,
    this.noAnyBroker,
    this.totalArea,
    this.itemType,
    this.city,
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
                    if (noAnyBroker == true)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 70,
                          height: 18,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                            ),
                          ),
                          child: Text(
                            "No Broker",
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
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "${totalArea ?? 0} Sqft Area",

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
                    Text(
                      itemType ?? "No item",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: Color(0xFF49454F),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "${area ?? "No area"}, ${city ?? "No city"}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                              color: Color(0xFF1E1A23),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            log("WhatsApp button tapped");
                          },
                          child: Container(
                            // width: 110,
                            height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFF0B8F00),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10,
                              children: [
                                SvgPicture.asset(
                                  "packages/flutterprovider/assets/icons/aaspas_logo-whatsapp-in-property-list-card.svg",
                                  width: 18,
                                  height: 18,
                                ),
                                Text(
                                  "WhatsApp",
                                  style: GoogleFonts.roboto(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
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
