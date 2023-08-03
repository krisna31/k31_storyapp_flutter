import 'package:geocoding/geocoding.dart';

class StringHelper {
  static bool isValidEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  static String getAddressFromPlace(List<Placemark>? place) =>
      '${place?.first.subLocality}, ${place?.first.locality}, ${place?.first.postalCode}, ${place?.first.country}';
}
