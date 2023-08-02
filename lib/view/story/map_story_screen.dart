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
  final center = const LatLng(-4.195934383050533, 122.78875410511459);
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () async => context.read<StoryProvider>().getAllStoryOnlyLocation(),
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
                zoom: 3,
                target: center,
              ),
              markers: markers,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
                for (var story in storyProvider.storiesOnlyLoc) {
                  final pos = LatLng(
                    story.lat!,
                    story.lon!,
                  );
                  final marker = Marker(
                    markerId: MarkerId(story.id.toString()),
                    position: pos,
                    onTap: () {
                      controller.animateCamera(
                        CameraUpdate.newLatLngZoom(
                          pos,
                          11,
                        ),
                      );
                    },
                  );
                  setState(() {
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
}
