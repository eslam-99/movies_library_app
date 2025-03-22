import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_library_app/core/api/api_constants.dart';
import 'loading.dart';

class CNetworkImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? borderWidth;
  final BoxFit? fit;
  final Color? borderColor;
  final Color? loadingColor;

  const CNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.loadingColor,
    this.borderRadius,
    this.fit,
    this.borderWidth,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        border:
            borderWidth == null ? null : Border.all(width: borderWidth ?? 0, color: borderColor ?? Colors.transparent),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: SizedBox(
          width: width,
          height: height,
          child: CachedNetworkImage(
            imageUrl: url != null ? (url!.startsWith('http') ? url! : '${ApiConstants.imagesBaseUrl}/${url!}') : '',
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, _, loadingProgress) {
              return const Center(child: Padding(padding: EdgeInsets.all(5), child: AppLoading()));
            },
            errorWidget: (context, url, error) => const Icon(Icons.close, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
