import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class CnImage extends StatelessWidget {
  final String imageUrl;
  final String errorAsset;
  final String placeholder;
  final double borderRadius;
  final double height;
  final double width;

  const CnImage({
    super.key,
    this.imageUrl = 'https://picsum.photos/200',
    this.errorAsset = 'assets/icons/app_icon.png',
    this.borderRadius = 10,
    this.height = 80,
    this.width = 80,
    this.placeholder = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: imageUrl.split(',').first,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          if (placeholder == '') {
            return Image.asset(errorAsset, fit: BoxFit.cover);
          }
          return Lottie.asset(placeholder);
        },
        errorWidget: (context, url, error) {
          if (error.toString().contains('404')) {
            return Image.asset(errorAsset, fit: BoxFit.cover);
          } else {
            return Image.asset(errorAsset, fit: BoxFit.cover);
          }
        },
      ),
    );
  }
}
