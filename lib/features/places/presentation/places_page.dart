import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/core/widgets/error_page.dart';
import 'package:itdols/core/widgets/header_widget.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/places/presentation/place_widget.dart';
import 'package:itdols/features/places/places_controller.dart';

// ignore: must_be_immutable
class PlacesPage extends ConsumerWidget {
  PlacesPage({super.key});

  List<PlaceModel>? places;
  WidgetState? widgetState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    places = ref.watch(placesStateHolder);
    if (places == null) {
      ref.read(placesController).getPlaces();
    }
    widgetState = ref.watch(widgetStateHolder);
    return Column(
      children: [
        HeaderWidget(
          label: 'Список локаций',
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_place');
              },
              child: const Text('Добавить'),
            )
          ],
        ),
        if (widgetState == WidgetState.loaded && places != null)
          Expanded(
            child: places!.isEmpty
                ? const Center(child: Text('Список пуст', style: TextStyle(fontSize: 24)))
                : ListView.separated(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemCount: places!.length,
                    itemBuilder: (BuildContext context, int index) => PlaceWidget(place: places![index]),
                    separatorBuilder: (BuildContext context, int index) => const Divider(
                      color: Colors.grey,
                      height: 1,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
          )
        else if (widgetState == WidgetState.error)
          ErrorPage(onPressed: () => ref.read(placesController).getPlaces())
        else
          const Expanded(child: Center(child: CircularProgressIndicator()))
      ],
    );
  }
}
