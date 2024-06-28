import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef GetPlaceDetailsWithLatLng = void Function(Prediction prediction);

class PlacePredictionWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final String googleAPIKey;
  final InputDecoration inputDecoration;
  final int debounceTime;
  final List<String>? countries;
  final GetPlaceDetailsWithLatLng? getPlaceDetailWithLatLng;
  final LatLng initialPosition;

  PlacePredictionWidget({
    required this.textEditingController,
    required this.googleAPIKey,
    this.inputDecoration = const InputDecoration(),
    this.debounceTime = 600,
    this.countries,
    this.getPlaceDetailWithLatLng,
    required this.initialPosition,
  });

  @override
  _PlacePredictionWidgetState createState() => _PlacePredictionWidgetState();
}

class _PlacePredictionWidgetState extends State<PlacePredictionWidget> {
  final subject = PublishSubject<String>();
  OverlayEntry? _overlayEntry;
  List<Prediction> alPredictions = [];
  LatLng? currentPosition;
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _clearOverlayAndTextField();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey, width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                decoration: widget.inputDecoration,
                style: TextStyle(),
                controller: widget.textEditingController,
                onChanged: (string) {
                  subject.add(string);
                  _updateOverlay(string);
                },
              ),
            ),
            if (widget.textEditingController.text.isNotEmpty)
              IconButton(
                onPressed: _clearOverlayAndTextField,
                icon: Icon(Icons.close),
              ),
          ],
        ),
      ),
    );
  }

  void _updateOverlay(String text) async {
    if (text.isEmpty) {
      _clearOverlay();
      return;
    }

    String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = '$baseUrl?input=$text&key=${widget.googleAPIKey}';

    if (widget.countries != null && widget.countries!.isNotEmpty) {
      request += "&components=" + widget.countries!.map((c) => "country:$c").join('|');
    }

    try {
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'OK') {
          setState(() {
            alPredictions = (data['predictions'] as List)
                .map((p) => Prediction(
              description: p['description'],
              placeId: p['place_id'],
            ))
                .toList();
          });
          _showOverlay();
        } else if (data['status'] == 'ZERO_RESULTS') {
          setState(() {
            alPredictions = [
              Prediction(description: 'Intente con otra dirección cercana', placeId: '')
            ];
          });
          _showOverlay();
        } else {
          throw Exception("Failed to fetch suggestions: ${data['status']}");
        }
      } else {
        throw Exception("Failed to fetch suggestions");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: size.height + offset.dy,
        width: size.width,
        child: Material(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: alPredictions.length,
            separatorBuilder: (context, pos) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  var selectedPrediction = alPredictions[index];
                  _selectPlace(selectedPrediction);

                  if (selectedPrediction.description == 'Intente con otra dirección cercana') {
                    _clearOverlayAndTextField();
                    setState(() {
                      currentPosition = widget.initialPosition;
                    });
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: currentPosition!, zoom: 16.0),
                      ),
                    );
                  } else if (widget.getPlaceDetailWithLatLng != null) {
                    _clearOverlayAndTextField();
                    getPlaceDetailsFromPlaceId(selectedPrediction);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          alPredictions[index].description!,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void getPlaceDetailsFromPlaceId(Prediction prediction) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=${prediction.placeId}&key=${widget.googleAPIKey}";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'OK') {
          var result = data['result'];
          prediction.lat =
              result['geometry']['location']['lat'].toString();
          prediction.lng =
              result['geometry']['location']['lng'].toString();

          widget.getPlaceDetailWithLatLng!(prediction);
        } else {
          throw Exception(
              "Failed to fetch place details: ${data['status']}");
        }
      } else {
        throw Exception("Failed to fetch place details");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  void _clearOverlayAndTextField() {
    widget.textEditingController.clear();
    setState(() {
      alPredictions.clear();
    });
    _clearOverlay();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _clearOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  void initState() {
    super.initState();
    subject.stream
        .distinct()
        .debounceTime(Duration(milliseconds: widget.debounceTime))
        .listen((text) => _updateOverlay(text));
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  void _selectPlace(Prediction prediction) {
    widget.textEditingController.text = prediction.description!;
    setState(() {
      alPredictions.clear();
    });
    _clearOverlay();
  }
}
