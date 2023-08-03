import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageWithNetwork extends StatelessWidget {
  final String url, cacheKey;
  const ImageWithNetwork({
    super.key,
    required this.url,
    required this.cacheKey,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: 200,
      progressIndicatorBuilder: (context, url, progress) => SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(
            value: progress.progress,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
      ),
      cacheManager: CacheManager(
        Config(
          cacheKey,
          stalePeriod: const Duration(minutes: 30),
        ),
      ),
    );
  }
}
