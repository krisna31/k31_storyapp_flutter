import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../enum/res_state.dart';
import '../../provider/story_provider.dart';

class MapsStoryScreen extends StatefulWidget {
  const MapsStoryScreen({super.key});

  @override
  State<MapsStoryScreen> createState() => _MapsStoryScreenState();
}

class _MapsStoryScreenState extends State<MapsStoryScreen> {
  final center = const LatLng(-6.8957473, 107.6337669);
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () async => context.read<StoryProvider>().getAllStory(
            location: 1,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<StoryProvider>(
        builder: (context, storyProvider, child) {
          if (storyProvider.state == ResState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (storyProvider.state == ResState.error) {
            return Center(
              child: Text(
                storyProvider.message,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }
          if (storyProvider.state == ResState.noData) {
            return const Center(
              child: Text('No Data'),
            );
          }
          return Center(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                zoom: 16,
                target: center,
              ),
              markers: markers,
              onMapCreated: (controller) {
                for (var story in storyProvider.stories) {
                  final marker = Marker(
                    markerId: MarkerId(story.id.toString()),
                    position: LatLng(
                      story.lat!,
                      story.lon!,
                    ),
                    onTap: () {
                      controller.animateCamera(
                        CameraUpdate.newLatLngZoom(
                          LatLng(
                            story.lat!,
                            story.lon!,
                          ),
                          18,
                        ),
                      );
                    },
                  );
                  final bound = boundsFromLatLngList(
                    storyProvider.stories
                        .map(
                          (e) => LatLng(
                            e.lat!,
                            e.lon!,
                          ),
                        )
                        .toList(),
                  );
                  mapController.animateCamera(
                    CameraUpdate.newLatLngBounds(bound, 50),
                  );
                  setState(() {
                    mapController = controller;
                    markers.add(marker);
                  });
                }
              },
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
            ),
          );
        },
      ),
    );
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }
}
