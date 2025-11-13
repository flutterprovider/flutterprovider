import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../flutterprovider.dart';

class UserServiceDetails extends StatelessWidget {
  final String? category;
  final String? subCategory;
  final String? date;
  final String? pin;
  final String? providerPhone;

  final String? dp;
  final String? name;
  final String? rating;
  final String status;

  final String? durationType;
  final String? duration;
  final String? price;
  final String? address;
  final List<String>? particular;

  final String? description;

  final VoidCallback? onPress;

  const UserServiceDetails({
    super.key,
    this.category,
    this.subCategory,
    this.date,
    this.pin,
    this.providerPhone,
    this.dp,
    this.name,
    this.rating,
    this.status = "No status",
    this.durationType,
    this.duration,
    this.price,
    this.address,
    this.particular,
    this.description,

    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          spacing: 10,
          children: [
            _catSubCatDate(context, category, subCategory, date),
            if (!(status == "completed" || status == "cancelled"))
              _sosPinTimeLeftCallMessage(context, pin, providerPhone),
            _dpNameStatus(context, _currentStatusChip(context, status)),
            _durationTypeDurationAndPrice(
              context,
              durationType,
              duration,
              price,
            ),
            _userAddress(context, address),
            _particular(context, particular!),
            _description(context, description),
            if (status == "pending" || status == "confirmed")
              _cancelTheService(context),
            if (status == "ongoing") _taskComplete(context),
            if (status == "completed") _rateService(context),
          ],
        ),
      ),
    );
  }

  Widget _currentStatusChip(BuildContext context, String? status3) {
    switch (status3) {
      case 'pending':
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: MoyoColorBox.moyoOrangeFade,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Text(
            "Pending",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              color: MoyoColorBox.moyoOrange,
            ),
          ),
        );
      case 'confirmed':
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFDEEAFA),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Text(
            "Confirmed",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              color: Color(0xFF1A4E88),
            ),
          ),
        );
      case 'ongoing':
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFE8FEEA),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Text(
            "Ongoing",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              color: Color(0xFF4ADB4A),
            ),
          ),
        );
      case 'completed':
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFDEEAFA),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Text(
            "Completed",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              color: Color(0xFF1A4E88),
            ),
          ),
        );
      case 'cancelled':
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFFEE8E8),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Text(
            "Cancelled",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              color: Color(0xFFDB4A4C),
            ),
          ),
        );

      default:
        return SizedBox(width: 0, height: 0);
    }
  }

  Widget _catSubCatDate(
    BuildContext context,
    String? category,
    String? subCategory,
    String? date,
  ) {
    return Container(
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE6E6E6), width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              "$category > $subCategory",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                textStyle: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                color: Color(0xFF1D1B20),
              ),
            ),
          ),
          Text(
            date ?? "No date",
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.black.withAlpha(100),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sosPinTimeLeftCallMessage(
    BuildContext context,
    String? pin,
    String? providerPhone,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFFFF0000),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Text(
              "SOS",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                textStyle: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          if (status == "confirmed")
            Text(
              "PIN - ${pin ?? "No Pin"}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                textStyle: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                color: Color(0xFF000000),
              ),
            ),
          if (status == "ongoing")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                Text(
                  "${_timeLeft(context, serviceStartTime: "", duration: "4") ?? "No Pin"} left",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    color: Color(0xFF0084FF),
                  ),
                ),
                SvgPicture.asset("packages/flutterprovider/assets/icons/moyo_timer_of_service.svg"),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              SvgPicture.asset("packages/flutterprovider/assets/icons/moyo_call_action.svg"),
              SvgPicture.asset("packages/flutterprovider/assets/icons/moyo_message_action.svg"),
            ],
          ),
        ],
      ),
    );
  }

  String? _timeLeft(
    BuildContext context, {
    String? serviceStartTime,
    String? duration,
  }) {
    return "03 : 29";
  }

  Widget _dpNameStatus(context, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (status != "pending")
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              height: 45,
              width: 45,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: dp!,
                    fit: BoxFit.cover,
                    // width: 80,
                    // height: 80,
                    placeholder: (context, url) =>
                        Image.asset('packages/flutterprovider/assets/images/aaspas_shopPlaceholder.png'),
                    errorWidget: (context, url, error) =>
                        Image.asset('packages/flutterprovider/assets/images/aaspas_shopPlaceholder.png'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 0,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (status != "pending")
                      Expanded(
                        child: Text(
                          name ?? "No Name",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                            color: Color(0xFF1D1B20),
                          ),
                        ),
                      ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 6,
                        children: [child],
                      ),
                    ),
                  ],
                ),
                if (status != "pending")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Flexible(
                        child: Text(
                          "⭐ $rating",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                            color: MoyoColorBox.moyoOrange,
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
    );
  }

  Widget _durationTypeDurationAndPrice(
    BuildContext context,
    String? durationType,
    String? duration,
    String? price,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: MoyoColorBox.moyoOrangeFade,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Text(
                durationType ?? "No Duration",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  color: MoyoColorBox.moyoOrange,
                ),
              ),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 6,
              children: [
                SvgPicture.asset(
                  "packages/flutterprovider/assets/icons/moyo_material-symbols_timer-outline.svg",
                ),
                Text(
                  duration ?? "No Duration",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Color(0xFF000000)),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Text(
              "₹ ${price ?? "No Price"} /-",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userAddress(BuildContext context, String? address) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Text(
        address ?? "No Address",
        textAlign: TextAlign.start,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Color(0xFF7A7A7A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _particular(BuildContext context, List<String> particular) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: [
          ...particular.map(
            (e) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: MoyoColorBox.moyoOrangeFade,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Text(
                e,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _description(BuildContext context, String? description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Text(
        description ?? "No description",
        textAlign: TextAlign.start,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Color(0xFF000000),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _cancelTheService(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Color(0xFFFFE3E3),
            border: Border.all(color: Color(0xFFC4242E), width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              SvgPicture.asset("packages/flutterprovider/assets/icons/moyo_close-filled.svg"),
              Text(
                "Cancel the service",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Color(0xFFFF0000),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taskComplete(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Color(0xFFC4242E),
            border: Border.all(color: Color(0xFFC4242E), width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              SvgPicture.asset("packages/flutterprovider/assets/icons/moyo_task-complete.svg"),
              Text(
                "Task Complete",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rateService(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: MoyoColorBox.moyoOrange,
            border: Border.all(color: MoyoColorBox.moyoOrange, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              SvgPicture.asset("packages/flutterprovider/assets/icons/moyo_white_star.svg"),
              Text(
                "Rate Service",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
