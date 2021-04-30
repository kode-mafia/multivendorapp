import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier{
  double latitude;
  double longitude;
  bool permissionAllowed = false;
  var selectedAddress;

  Future<void> getCurrentPosition() async{

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if(position!=null){
      this.latitude=position.latitude;
      this.longitude=position.longitude;
      this.permissionAllowed = false;
      notifyListeners();
    }else{
      print('Permission not allowed');
    }
  }

  void onCameraMove(CameraPosition cameraPosition)async{
    this.latitude=cameraPosition.target.latitude;
    this.longitude=cameraPosition.target.longitude;
    notifyListeners();
  }


  Future<void>getMoveCamera() async {
    final coordinates = Coordinates(this.latitude, this.longitude);
    final addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    this.selectedAddress = addresses.first;
    print("${selectedAddress.featureName} : ${selectedAddress.addresssLine}");
  }

}