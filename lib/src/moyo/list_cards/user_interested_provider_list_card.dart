import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../flutterprovider.dart';

class UserInterestedProviderListCard extends StatelessWidget {
  final String? providerName;
  final String? gender;
  final String? age;
  final String? distance;
  final String? reachTime;

  ///
  final String? category;
  final String? subCategory;

  ///
  final String? chargeRate;
  final bool? isVerified;
  final String? rating;
  final String? experience;

  ///
  final String? dp;
  final VoidCallback? onBook;

  const UserInterestedProviderListCard({
    super.key,
    this.providerName,
    this.gender,
    this.age,
    this.distance,
    this.reachTime,
    this.category,
    this.subCategory,
    this.chargeRate,
    this.isVerified,
    this.rating,
    this.experience,
    this.dp,
    this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBook,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          child: Column(
            children: [
              _nameGenderAgeDistanceReachTime(
                context,
                providerName: providerName,
                gender: gender,
                age: age,
                distance: distance,
                reachTime: reachTime,
              ),
              _categorySubCategory(
                context,
                category: category,
                subCategory: subCategory,
              ),
              _chargesRateIsVerifiedRatingExperience(
                context,
                chargeRate: chargeRate,
                isVerified: isVerified,
                rating: rating,
                experience: experience,
              ),
              _bookProviderDp(context, dp: dp, onBook: onBook),
            ],
          ),
        ),
      ),
    );
  }

  /// module method
  Widget _nameGenderAgeDistanceReachTime(
    BuildContext context, {
    String? providerName,
    String? gender,
    String? age,
    String? distance,
    String? reachTime,
  }) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 4,
              children: [
                Text(
                  providerName ?? "no name",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600,color: Color(0xFF1D1B20),),

                ),
                Text(
                  "(${gender ?? "no gender"} - ${age ?? "No age"}years)",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF808080),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 2,
            children: [
              Text(
                distance ?? "No distance",
                style:  Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.black.withAlpha(100),
                ),
              ),
              Text(
                "(${reachTime ?? "No reachTime"})",
                style:  Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.black.withAlpha(100),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _categorySubCategory(
    BuildContext context, {
    String? category,
    String? subCategory,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),

      child: Text(
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        "${category ?? "No category"} • ${subCategory ?? "No subCategory"}",
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: Colors.black.withAlpha(100)),
      ),
    );
  }

  _chargesRateIsVerifiedRatingExperience(
    BuildContext context, {
    String? chargeRate,
    bool? isVerified,
    String? rating,
    String? experience,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Text(
                "₹ ${chargeRate ?? "no chargeRate"}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1D1B20),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0.5),
                decoration: BoxDecoration(
                  color: Color(0xFFABF383),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Text(
                  "Verified",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF328303),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: MoyoColorBox.moyoOrangeFade,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Text(
                  "⭐ ${rating ?? "no rating"}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: MoyoColorBox.moyoOrangeFade,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Text(
                  "${experience ?? "no rating"} yrs exp",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bookProviderDp(
    BuildContext context, {
    String? dp,
    VoidCallback? onBook,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onBook,
            child: Container(
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: MoyoColorBox.moyoOrange,

                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                "Book this provider",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:  Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            height: 54,
            width: 54,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: dp ?? "https://picsum.photos/200/200",
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
        ],
      ),
    );
  }
}
