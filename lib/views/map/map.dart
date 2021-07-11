//imports
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'location.dart';
import 'package:geolocator/geolocator.dart';

//map class to display map
class Map extends StatefulWidget {
  Map({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  //hardcoded centre of the map
  final centre = LatLng(43.9457842, -78.895896);
  var _geolocator = Geolocator();
  //empty locations array for 
  List<Location> _locations = [];
  double _lat;
  double _long;
  List<LatLng> _path = [];
  
  MapController _mapctl = MapController();
  double _zoom;

  //for the geolocator to put in a point on the map
   void updateLocationOneTime() {
    _geolocator
        .getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ) // Get the Lat and Long
        .then((Position userLocation) {
      setState(() {
        print(userLocation);
        _lat = userLocation.latitude;
        _long = userLocation.longitude;
      });
      // Get the placemark name and address
      _geolocator
          .placemarkFromCoordinates(_lat, _long)
          .then((List<Placemark> places) {
        print('Reverse geocoding results');
        for (Placemark place in places) {
          Location currentPlace = Location();
          print(place.name);
          currentPlace.name = place.name;
          currentPlace.address =
              place.subThoroughfare + " " + place.thoroughfare;
          currentPlace.latlng = LatLng(_lat, _long);
          setState(() {
            _locations.add(currentPlace);
          });
        }
      });
    });
  }

  // zoom the map out
  void zoomOut(MapController _controller) {
  _zoom = _controller.zoom;
  if (_zoom > 11.0) {
    _zoom = _zoom - 1;
    _controller.move(_controller.center, _zoom);
    setState(() {
      
    });
  }
}

//zoom the map in
void zoomIn(MapController _controller) {
  _zoom = _controller.zoom;
  if (_zoom < 16.0) {
    _zoom = _zoom + 1;
    _controller.move(_controller.center, _zoom);
    setState(() {
      
    });
  }
}

  @override
  Widget build(BuildContext context) {

    //check the location status
    _geolocator
        .checkGeolocationPermissionStatus()
        .then((GeolocationStatus status) {
      print('Geolocation status: $status');
    });

   return Scaffold(
      appBar: AppBar(title: Text("Map"),
      actions: <Widget>[
        
        //displays the zoom out button
        IconButton(icon: Icon(Icons.zoom_out), onPressed: () {zoomOut(_mapctl);},),
        //displays the zoom in button
        IconButton(icon: Icon(Icons.zoom_in), onPressed: () {zoomIn(_mapctl);},),
      ],),
      body: FlutterMap(
        mapController: _mapctl,
      options: MapOptions(
        minZoom: 11.0,
        maxZoom: 16.0,
        center: centre,
      ),
      layers: [
        //mapbox map
        TileLayerOptions(
          urlTemplate:
          'https://api.mapbox.com/styles/v1/paul4411/ckife0zyn4il21akuuw0eb46m/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicGF1bDQ0MTEiLCJhIjoiY2tpZmRzNnNvMDRtbjJ3cXB6Ym0wZHNxdSJ9.yYcm9lA6cQJII8ukPAp7wA',
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoicGF1bDQ0MTEiLCJhIjoiY2tpZmRzNnNvMDRtbjJ3cXB6Ym0wZHNxdSJ9.yYcm9lA6cQJII8ukPAp7wA',
            'id': 'mapbox.mapbox-streets-v8'
          }
        ),
        //diaplays all of the markers that have been set
        MarkerLayerOptions(markers: _locations
                  .map((location) => Marker(
                        width: 45.0,
                        height: 45.0,
                        point: location.latlng,
                        builder: (context) => Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on),
                            color: Colors.blue,
                            iconSize: 45.0,
                            onPressed: () {
                              print('Marker clicked');
                            },
                          ),
                        ),
                      ))
                  .toList()),
        PolylineLayerOptions(
          polylines: [
            Polyline(
              points: _path,
              strokeWidth: 2.0,
              color: Colors.blue,
            ),
          ],
        ),
        
      ],
      
    ),
    //button to input marker
    floatingActionButton: FloatingActionButton(
        onPressed: () => updateLocationOneTime(),
        child: Icon(Icons.add),
      ),
    );
  }
}