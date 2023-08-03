import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:k31_storyapp_flutter/routes/app_route.dart';
import 'package:k31_storyapp_flutter/routes/route_helper.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:provider/provider.dart';

import '../../atom/image_with_network.dart';
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
                  Future.microtask(() async =>
                      place = await geo.placemarkFromCoordinates(lati, long));
                  final address =
                      '${place?.first.subLocality}, ${place?.first.locality}, ${place?.first.postalCode}, ${place?.first.country}';
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
                                  title: place?.first.street,
                                  snippet: address));
                          setState(
                            () {
                              mapController = controller;
                              markers.add(marker);
                            },
                          );
                        },
                        zoomControlsEnabled: true,
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
                }
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
              },
            );
          }
        },
      ),
    );
  }

  Center _showLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ShowErrorText extends StatelessWidget {
  final StoryProvider storyProvider;
  const ShowErrorText({super.key, required this.storyProvider});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Error: ${storyProvider.message}",
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
