import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class LocationService {
  Future<bool> requestLocationPermission(BuildContext context) async {
    bool hasPermission = await _determinePermission();
    if (!hasPermission) {
      // 위치 권한이 없을 때 사용자에게 적절한 안내를 할 수 있습니다.
      // 예: 다이얼로그 표시
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('위치 권한 필요'),
          content: Text('이 앱은 위치 권한이 필요합니다. 권한을 허용해 주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
    return hasPermission;
  }

  Future<bool> _determinePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.value(false);
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.value(false);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.value(false);
    }
    return Future.value(true);
  }
}
