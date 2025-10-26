import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceListCard extends StatelessWidget {
  final String? dp;
  final bool? verified;
  final String? title;
  final int? serviceCharge;
  final String? category;
  final String? area;
  final String? phone;
  final VoidCallback? onPress;

  const ServiceListCard({
    super.key,
    this.dp,
    this.verified,
    this.title,
    this.serviceCharge,
    this.category,
    this.area,
    this.phone,
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
                child: CachedNetworkImage(
                  imageUrl: dp!,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  placeholder: (context, url) =>
                      Image.asset('packages/flutterprovider/assets/images/aaspas_default_avatar.png'),
                  errorWidget: (context, url, error) =>
                      Image.asset('packages/flutterprovider/assets/images/aaspas_default_avatar.png'),
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
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 58),

                          child: Text(
                            "₹ ${serviceCharge ?? 0} /-",
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
                            "${category ?? "No category"}, ${area ?? "No area"}",
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
                            log("Call button tapped");
                          },
                          child: Container(
                            width: 80,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFFDFC6FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10,
                              children: [
                                SvgPicture.asset(
                                  "packages/flutterprovider/assets/icons/aaspas_phone-flip.svg",
                                  width: 15,
                                  height: 15,
                                ),
                                Text(
                                  "Call",
                                  style: GoogleFonts.roboto(
                                    textStyle: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
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
