import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../aaspas_color_box.dart';

class ShopDetails extends StatelessWidget {
  final String? openTime;
  final String? closeTime;
  final List<String>? weekDays;
  final String? shopName;
  final bool verified;
  final String? area;
  final String? address;
  final List<String>? shopType;
  final String? distance;
  final String? lat;
  final String? long;
  final String? description;
  final String? phone;

  /// delete there variable
  final bool isOpen = true;

  const ShopDetails({
    super.key,
    this.openTime,
    this.closeTime,
    this.weekDays,
    this.shopName,
    this.verified = false,
    this.area,
    this.address,
    this.shopType,
    this.distance,
    this.lat,
    this.long,
    this.description,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          _shopTiming(context),

          _shopNameAndVerificationMark(context),

          _shopAddress(context),

          _areaCityAndShopType(context),

          _shopDescription(context),

          _directionCopyShare(context, distance: distance),

          _callAndWhatsapp(context, phone: phone),
        ],
      ),
    );
  }

  /// Widget Fragments

  Widget _shopTiming(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.end,
            runSpacing: 6,
            spacing: 6,
            children: [
              Text(
                isOpen ? "open" : "close",
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0B8F00),
                  ),
                ),
              ),
              Text(
                "$openTime - $closeTime",
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E1A23),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.end,
            runSpacing: 4,
            spacing: 4,
            children: [
              _weekDayContainer(
                context,
                daySymbol: 'M',
                isThisDayOpen: weekDays?.contains("Monday"),
              ),
              _weekDayContainer(
                context,
                daySymbol: 'T',
                isThisDayOpen: weekDays?.contains("Tuesday"),
              ),
              _weekDayContainer(
                context,
                daySymbol: 'W',
                isThisDayOpen: weekDays?.contains("Wednesday"),
              ),
              _weekDayContainer(
                context,
                daySymbol: 'T',
                isThisDayOpen: weekDays?.contains("Thursday"),
              ),
              _weekDayContainer(
                context,
                daySymbol: 'F',
                isThisDayOpen: weekDays?.contains("Friday"),
              ),
              _weekDayContainer(
                context,
                daySymbol: 'S',
                isThisDayOpen: weekDays?.contains("Saturday"),
              ),
              _weekDayContainer(
                context,
                daySymbol: 'S',
                isThisDayOpen: weekDays?.contains("Sunday"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weekDayContainer(
    BuildContext context, {
    required String daySymbol,
    isThisDayOpen = false,
  }) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isThisDayOpen ? Color(0xFFDFC6FF) : Color(0xFFFEF7FF),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          daySymbol,
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isThisDayOpen ? Color(0xFF1E1A23) : Color(0xFFCDC3D6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _shopNameAndVerificationMark(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
          child: SvgPicture.asset("packages/flutterprovider/assets/icons/aaspas_verified_icon.svg"),
        ),
        Expanded(
          child: Text(
            shopName ?? "No name",
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF1E1A23),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _shopAddress(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        address ?? "No Address",
        textAlign: TextAlign.start,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AaspasColorBox.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _areaCityAndShopType(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            "New york, USA",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: Color(0xFF732FCB)),
            ),
          ),
        ),
        Flexible(
          child: Text(
            "Retail, Service",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: Color(0xFF732FCB)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _shopDescription(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        description ?? "No Description",
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AaspasColorBox.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _directionCopyShare(BuildContext context, {String? distance}) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: [
          Container(
            width: 172,
            height: 40,
            padding: EdgeInsets.symmetric(vertical: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AaspasColorBox.buttonBg,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,

              spacing: 6,
              children: [
                SvgPicture.asset("packages/flutterprovider/assets/icons/aaspas_location.svg"),
                Text(
                  "Direction $distance",
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AaspasColorBox.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: 180,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                IconButton.filled(
                  onPressed: () {},

                  icon: Icon(Icons.copy_rounded, color: Color(0xFF5A00B2)),
                  // splashColor: Color(0xFFFAF0FE),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      AaspasColorBox.buttonBg,
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AaspasColorBox.buttonBg,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6,
                    children: [
                      SvgPicture.asset("packages/flutterprovider/assets/icons/aaspas_share.svg"),
                      Text(
                        "Share",
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: AaspasColorBox.onSurface),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _callAndWhatsapp(BuildContext context, {String? phone}) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 20,
        runSpacing: 20,
        children: [
          InkWell(
            onTap: () {
              log("Call button tapped");
            },
            child: Container(
              width: 90,
              height: 40,
              padding: EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AaspasColorBox.buttonBg,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 6,
                children: [
                  SvgPicture.asset(
                    "packages/flutterprovider/assets/icons/aaspas_phone-flip.svg",
                    width: 15,
                    height: 15,
                  ),
                  Text(
                    "Call",
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              log("WhatsApp button tapped");
            },
            child: Container(
              width: 130,
              height: 40,
              padding: EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF0B8F00),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                spacing: 6,
                children: [
                  SvgPicture.asset(
                    "packages/flutterprovider/assets/icons/aaspas_logo-whatsapp-in-property-list-card.svg",
                    width: 18,
                    height: 18,
                  ),
                  Text(
                    "WhatsApp",
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
