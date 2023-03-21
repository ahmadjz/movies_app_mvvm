import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/functions.dart';
import 'package:movies_app_mvvm/app/resources/assets_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';

class ActorItemWidget extends StatelessWidget {
  const ActorItemWidget({
    Key? key,
    required this.actor,
  }) : super(key: key);
  final ActorObject actor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Column(
        children: [
          Container(
            width: AppSize.s64,
            height: AppSize.s64,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s32),
              child: FadeInImage(
                // TODO: This code works for handling no available image
                // but it still throws an exception in the IDE
                // that problem is cause by Flutter team and not solved yet
                // https://github.com/flutter/flutter/issues/69125
                // https://github.com/flutter/flutter/issues/107416
                width: AppSize.s64,
                height: AppSize.s64,
                fit: BoxFit.cover,
                image: Image.network(
                  width: AppSize.s64,
                  height: AppSize.s64,
                  getActorImageUrl(
                    actor.id,
                  ),
                  fit: BoxFit.cover,
                ).image,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    ImageAssets.personPlaceholder,
                    fit: BoxFit.cover,
                  );
                },
                placeholder: const AssetImage(
                  ImageAssets.personPlaceholder,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSize.s8),
          SizedBox(
            width: AppSize.s64,
            child: Text(
              actor.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
