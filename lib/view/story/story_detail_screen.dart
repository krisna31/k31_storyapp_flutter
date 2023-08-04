import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:k31_storyapp_flutter/models/story/story.dart';
import 'package:k31_storyapp_flutter/routes/app_route.dart';
import 'package:k31_storyapp_flutter/routes/route_helper.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:k31_storyapp_flutter/util/string_helper.dart';
import 'package:provider/provider.dart';

import '../../atom/image_with_network.dart';
import '../../atom/show_error_text.dart';
import '../../enum/res_state.dart';
import '../../provider/story_provider.dart';

class StoryDetailScreen extends StatefulWidget {
  final String? storyId;
  const StoryDetailScreen({
    super.key,
    required this.storyId,
  });

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = <Marker>{};
  List<Placemark>? place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RouteHelper.toTitle(AppRoute.detailStory)),
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer<StoryProvider>(
        builder: (context, storyProvider, _) {
          if (storyProvider.state == ResState.loading) {
            return _showLoading();
          } else if (storyProvider.state == ResState.error) {
            return ShowErrorText(
              storyProvider: storyProvider,
            );
          } else {
            return Builder(
              builder: (context) {
                final st = storyProvider.detailStory;
                final lati = st.lat;
                final long = st.lon;
                if (lati != null && long != null) {
                  return _showWithGoogleMap(lati, long, st, storyProvider);
                }
                return _showJustStory(storyProvider);
              },
            );
          }
        },
      ),
    );
  }

  Column _showJustStory(StoryProvider storyProvider) {
    return Column(
      children: [
        ImageWithNetwork(
          url: storyProvider.detailStory.photoUrl,
          cacheKey: storyProvider.detailStory.id,
        ),
        ListTile(
          title: Text(
            "Created by ${storyProvider.detailStory.name}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Description: ${storyProvider.detailStory.description}",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Created At: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.parse(storyProvider.detailStory.createdAt.toString()).toUtc())}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  FutureBuilder<List<Placemark>> _showWithGoogleMap(
      double lati, double long, Story st, StoryProvider storyProvider) {
    return FutureBuilder(
      future: geo.placemarkFromCoordinates(lati, long),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        place = snapshot.data;
        final address = StringHelper.getAddressFromPlace(place);
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                zoom: 8,
                target: LatLng(lati, long),
              ),
              markers: markers,
              onMapCreated: (controller) {
                final pos = LatLng(
                  lati,
                  long,
                );
                final marker = Marker(
                    markerId: MarkerId(st.id),
                    position: pos,
                    onTap: () {
                      controller.animateCamera(
                        CameraUpdate.newLatLngZoom(
                          pos,
                          500,
                        ),
                      );
                    },
                    infoWindow: InfoWindow(
                        title: place?.first.street, snippet: address));
                setState(
                  () {
                    mapController = controller;
                    markers.add(marker);
                  },
                );
              },
              zoomControlsEnabled: true,
              buildingsEnabled: true,
              trafficEnabled: true,
            ),
            Container(
              height: 200,
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ImageWithNetwork(
                        url: storyProvider.detailStory.photoUrl,
                        cacheKey: storyProvider.detailStory.id,
                      ),
                      ListTile(
                        title: Text(
                          "Created by ${storyProvider.detailStory.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Description: ${storyProvider.detailStory.description}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Created At: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.parse(storyProvider.detailStory.createdAt.toString()).toUtc())}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Center _showLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
