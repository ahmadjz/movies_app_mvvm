// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/functions.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeThumbnailImage extends StatelessWidget {
  const YoutubeThumbnailImage({
    Key? key,
    required this.youtubeVideoId,
  }) : super(key: key);
  final String youtubeVideoId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final url = Uri.parse(
          youtubeUrl(
            youtubeVideoId,
          ),
        );
        await launchUrl(url);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * PercentageSizes.p20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.s16,
          ),
          image: DecorationImage(
            image: NetworkImage(
              youtubeThumbnailUrl(
                youtubeVideoId,
              ),
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
