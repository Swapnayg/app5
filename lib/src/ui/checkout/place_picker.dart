// ignore_for_file: prefer_adjacent_string_concatenation, unnecessary_brace_in_string_interps, avoid_print, dead_code

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:place_picker/entities/entities.dart';
import 'package:place_picker/uuid.dart';
import 'package:place_picker/widgets/widgets.dart';



/// Place picker widget made with map widget from
/// [google_maps_flutter](https://github.com/flutter/plugins/tree/master/packages/google_maps_flutter)
/// and other API calls to [Google Places API](https://developers.google.com/places/web-service/intro)
///
/// API key provided should have `Maps SDK for Android`, `Maps SDK for iOS`
/// and `Places API`  enabled for it
class PlacePicker extends StatefulWidget {
  /// API key generated from Google Cloud Console. You can get an API key
  /// [here](https://cloud.google.com/maps-platform/)
  final String apiKey;

  /// Location to be displayed when screen is showed. If this is set or not null, the
  /// map does not pan to the user's current location.
  final LatLng displayLocation;

  const PlacePicker(this.apiKey, {super.key, required this.displayLocation});

  @override
  State<StatefulWidget> createState() => PlacePickerState();
}

/// Place picker state
class PlacePickerState extends State<PlacePicker> {
  final Completer<GoogleMapController> mapController = Completer();

  /// Indicator for the selected location
  final Set<Marker> markers = {};

  /// Result returned after user completes selection
  late LocationResult locationResult;

  /// Overlay to display autocomplete suggestions
  OverlayEntry? overlayEntry;

  List nearbyPlaces = List.empty(growable: true);

  /// Session token required for autocomplete API call
  String sessionToken = Uuid().generateV4();

  GlobalKey appBarKey = GlobalKey();

  bool hasSearchTerm = false;

  String previousSearchTerm = '';

  // constructor
  PlacePickerState();

  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    moveToCurrentUserLocation();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    markers.add(Marker(
      position: widget.displayLocation,
      markerId: MarkerId("selected-location"),
    ));
  }

  @override
  void dispose() {
    overlayEntry!.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        title: SearchInput(searchPlace),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: widget.displayLocation, zoom: 15),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: onMapCreated,
              onTap: (latLng) {
                clearOverlay();
                moveToLocation(latLng);
              },
              markers: markers,
            ),
          ),
          if (!hasSearchTerm)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SelectPlaceAction(getLocationName(), () => Navigator.of(context).pop(locationResult), "Tap to select this location",),
                  Divider(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Text("Nearby Places", style: TextStyle(fontSize: 16)),
                  ),
                  Expanded(
                    child: ListView(
                      children: nearbyPlaces.map((it) => NearbyPlaceItem(it, () => moveToLocation(it.latLng))).toList(),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// Hides the autocomplete overlay
  void clearOverlay() {
    overlayEntry!.remove();
    overlayEntry = null; // Assigning null to a nullable OverlayEntry
    }

  /// Begins the search process by displaying a "wait" overlay then
  /// proceeds to fetch the autocomplete list. The bottom "dialog"
  /// is hidden so as to give more room and better experience for the
  /// autocomplete list overlay.
  void searchPlace(String place) {
    // on keyboard dismissal, the search was being triggered again
    // this is to cap that.
    if (place == previousSearchTerm) {
      return;
    }

    previousSearchTerm = place;

    clearOverlay();

    setState(() {
      hasSearchTerm = place.length > 0;
    });

    if (place.length < 1) {
      return;
    }

    final RenderObject? renderBox = context.findRenderObject();
    final size = renderBox!.size;

    final RenderObject? appBarBox = appBarKey.currentContext!.findRenderObject();

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: appBarBox!.size.height,
        width: size.width,
        child: Material(
          elevation: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              children: <Widget>[
                SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 3)),
                SizedBox(width: 24),
                Expanded(child: Text("Finding place...", style: TextStyle(fontSize: 16)))
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);

    autoCompleteSearch(place);
  }

  /// Fetches the place autocomplete list with the query [place].
  void autoCompleteSearch(String place) async {
    try {
      place = place.replaceAll(" ", "+");

      var endpoint = "https://maps.googleapis.com/maps/api/place/autocomplete/json?" "key=${widget.apiKey}&" +
          "input={$place}&sessiontoken=${sessionToken}";
      endpoint += "&location=${locationResult.latLng!.latitude}," "${locationResult.latLng!.longitude}";
    
      final response = await http.get(endpoint as Uri);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['predictions'] == null) {
        throw Error();
      }

      List<dynamic> predictions = responseJson['predictions'];

      List<RichSuggestion> suggestions = [];

      if (predictions.isEmpty) {
        AutoCompleteItem aci = AutoCompleteItem();
        aci.text = "No result found";
        aci.offset = 0;
        aci.length = 0;

        suggestions.add(RichSuggestion(aci, () {}));
      } else {
        for (dynamic t in predictions) {
          final aci = AutoCompleteItem()
            ..id = t['place_id']
            ..text = t['description']
            ..offset = t['matched_substrings'][0]['offset']
            ..length = t['matched_substrings'][0]['length'];

          suggestions.add(RichSuggestion(aci, () {
            FocusScope.of(context).requestFocus(FocusNode());
            if (aci.id != null) {
              decodeAndSelectPlace(aci.id!);
            }
          }));
        }
      }

      displayAutoCompleteSuggestions(suggestions);
    } catch (e) {
      print(e);
    }
  }

  /// To navigate to the selected place from the autocomplete list to the map,
  /// the lat,lng is required. This method fetches the lat,lng of the place and
  /// proceeds to moving the map to that location.
  void decodeAndSelectPlace(String placeId) async {
    clearOverlay();

    try {
      final response = await http
          .get("https://maps.googleapis.com/maps/api/place/details/json?key=${widget.apiKey}" "&placeid=$placeId" as Uri);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['result'] == null) {
        throw Error();
      }

      final location = responseJson['result']['geometry']['location'];
      moveToLocation(LatLng(location['lat'], location['lng']));
    } catch (e) {
      print(e);
    }
  }

  /// Display autocomplete suggestions with the overlay.
  void displayAutoCompleteSuggestions(List<RichSuggestion> suggestions) {
    final RenderObject? renderBox = context.findRenderObject();
    Size size = renderBox!.size;

    final RenderObject? appBarBox = appBarKey.currentContext?.findRenderObject();

    clearOverlay();

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        top: appBarBox!.size.height,
        child: Material(elevation: 1, child: Column(children: suggestions)),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  /// Utility function to get clean readable name of a location. First checks
  /// for a human-readable name from the nearby list. This helps in the cases
  /// that the user selects from the nearby list (and expects to see that as a
  /// result, instead of road name). If no name is found from the nearby list,
  /// then the road name returned is used instead.
  String getLocationName() {
    for (NearbyPlace np in nearbyPlaces) {
      if (np.latLng == locationResult.latLng && np.name != locationResult.locality) {
        locationResult.name = np.name;
        return "${np.name}, ${locationResult.locality}";
      }
    }

    return "${locationResult.name}, ${locationResult.locality}";
  }

  /// Moves the marker to the indicated lat,lng
  void setMarker(LatLng latLng) {
    // markers.clear();
    setState(() {
      markers.clear();
      markers.add(Marker(markerId: MarkerId("selected-location"), position: latLng));
    });
  }

  /// Fetches and updates the nearby places to the provided lat,lng
  void getNearbyPlaces(LatLng latLng) async {
    try {
      final response = await http.get(("https://maps.googleapis.com/maps/api/place/nearbysearch/json?" "key=${widget.apiKey}&" +
          "location=${latLng.latitude},${latLng.longitude}&radius=150") as Uri);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['results'] == null) {
        throw Error();
      }

      nearbyPlaces.clear();

      for (Map<String, dynamic> item in responseJson['results']) {
        final nearbyPlace = NearbyPlace()
          ..name = item['name']
          ..icon = item['icon']
          ..latLng = LatLng(item['geometry']['location']['lat'], item['geometry']['location']['lng']);

        nearbyPlaces.add(nearbyPlace);
      }

      // to update the nearby places
      setState(() {
        // this is to require the result to show
        hasSearchTerm = false;
      });
    } catch (e) {
      //
    }
  }

  /// This method gets the human readable name of the location. Mostly appears
  /// to be the road name and the locality.
  void reverseGeocodeLatLng(LatLng latLng) async {
    try {
      final response = await http.get(("https://maps.googleapis.com/maps/api/geocode/json?" "latlng=${latLng.latitude},${latLng.longitude}&" +
          "key=${widget.apiKey}") as Uri);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['results'] == null) {
        throw Error();
      }

      final result = responseJson['results'][0];

      setState(() {
        locationResult = LocationResult()
          ..name = result['address_components'][0]['short_name']
          ..locality = result['address_components'][1]['short_name']
          ..latLng = latLng
          ..formattedAddress = result['formatted_address']
          ..placeId = result['place_id']
          ..postalCode = result['address_components'][7]['short_name']
          ..country = AddressComponent.fromJson(result['address_components'][6])
          ..administrativeAreaLevel1 = AddressComponent.fromJson(result['address_components'][5])
          ..administrativeAreaLevel2 = AddressComponent.fromJson(result['address_components'][4])
          ..city = AddressComponent.fromJson(result['address_components'][3])
          ..subLocalityLevel1 = AddressComponent.fromJson(result['address_components'][2])
          ..subLocalityLevel2 = AddressComponent.fromJson(result['address_components'][1]);
      });
    } catch (e) {
      print(e);
    }
  }

  /// Moves the camera to the provided location and updates other UI features to
  /// match the location.
  void moveToLocation(LatLng latLng) {
    mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 15.0)),
      );
    });

    setMarker(latLng);

    reverseGeocodeLatLng(latLng);

    getNearbyPlaces(latLng);
  }

  void moveToCurrentUserLocation() {
    moveToLocation(widget.displayLocation);
    return;
  
    Location().getLocation().then((locationData) {
      LatLng target = LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
      moveToLocation(target);
    }).catchError((error) {
      print(error);
    });
  }
}

extension on RenderObject {
   get size => null;
}
