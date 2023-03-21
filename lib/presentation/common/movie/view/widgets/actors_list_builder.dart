import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';
import 'package:movies_app_mvvm/domain/model/all_movies_model.dart';
import 'package:movies_app_mvvm/presentation/common/movie/view/widgets/actor_item_widget.dart';

class ActorsListBuilder extends StatelessWidget {
  const ActorsListBuilder({super.key, required this.actors});
  final List<ActorObject> actors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          return ActorItemWidget(
            actor: actors[index],
          );
        },
      ),
    );
  }
}
