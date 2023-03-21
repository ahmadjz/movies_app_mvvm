// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/app/resources/strings_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';

class MovieData extends StatelessWidget {
  const MovieData({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final MovieObject movie;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.summary,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: AppSize.s10),
        Text(
          movie.summary,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.white,
              ),
        ),
        const SizedBox(height: AppSize.s16),
        RichText(
          text: TextSpan(
            text: AppStrings.directors,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorManager.grey,
                ),
            children: [
              TextSpan(
                text: movie.director,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorManager.grey,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s8),
        RichText(
          text: TextSpan(
            text: AppStrings.writers,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorManager.grey,
                ),
            children: [
              TextSpan(
                text: movie.writers.join(' - '),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorManager.grey,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
