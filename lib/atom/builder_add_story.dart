import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:k31_storyapp_flutter/atom/submit_form_add_story.dart';

import 'package:geocoding/geocoding.dart' as geo;
import '../provider/story_provider.dart';
import '../util/add_story_helper.dart';
import 'deskripsi_input_add_story.dart';
import 'my_pick_gallery.dart';
import 'my_take_photo.dart';

class BuilderAddStory extends StatefulWidget {
  final StoryProvider storyProvider;
  const BuilderAddStory({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController descriptionController,
    required this.storyProvider,
  })  : _formKey = formKey,
        _descriptionController = descriptionController;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _descriptionController;

  @override
  State<BuilderAddStory> createState() => _BuilderAddStoryState();
}

class _BuilderAddStoryState extends State<BuilderAddStory> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  LatLng? latLng;
  List<Placemark>? place;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            zoom: 10,
            target: LatLng(-4.195934383050533, 122.78875410511459),
          ),
          markers: markers,
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          onLongPress: (latLng) {
            setState(() async {
              place = await geo.placemarkFromCoordinates(
                  latLng.latitude, latLng.longitude);
              final address =
                  '${place?.first.subLocality}, ${place?.first.locality}, ${place?.first.postalCode}, ${place?.first.country}';
              final marker = Marker(
                markerId: const MarkerId('Your Choose Place'),
                position: latLng,
                infoWindow: InfoWindow(
                  title: place?.first.name,
                  snippet: address,
                ),
              );
              mapController.animateCamera(
                CameraUpdate.newLatLngZoom(
                  latLng,
                  500,
                ),
              );
              setState(() {
                markers.add(marker);
                this.latLng = latLng;
              });
            });
          },
          zoomControlsEnabled: true,
        ),
        Positioned(
          top: 5,
          right: 16,
          left: 16,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: widget._formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _showImgOrPlaceholder(),
                    const SizedBox(height: 20),
                    DeskripsiInputAddStory(
                      descriptionController: widget._descriptionController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTakePhoto(
                      storyProvider: widget.storyProvider,
                    ),
                    const SizedBox(height: 20),
                    MyPickGallery(
                      storyProvider: widget.storyProvider,
                    ),
                    const SizedBox(height: 20),
                    SubmitFormAddStory(
                      descriptionController: widget._descriptionController,
                      storyProvider: widget.storyProvider,
                      latLng: latLng,
                      formKey: widget._formKey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _showImgOrPlaceholder() {
    if (widget.storyProvider.imagePath == null) {
      return const Center(child: Icon(Icons.image));
    } else {
      return AddStoryHelper.showimg(widget.storyProvider);
    }
  }
}
