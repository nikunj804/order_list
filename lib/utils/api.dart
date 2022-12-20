import 'dart:io';
import 'package:http/http.dart' as http;

class APIs {
  static const String BASE_URL =
      'https://qaadmin.onzway.com/apis/get-orders-v3.json';

  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

  order() {
    return http.post(Uri.parse(BASE_URL), headers: {
      'Accept': 'application/json',
      'app_token':
          'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJmaXJlYmFzZS1hZG1pbnNkay04bHRpbkBvbnp3YXktZHJpdmVyLTNkZjU4LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwic3ViIjoiZmlyZWJhc2UtYWRtaW5zZGstOGx0aW5Ab256d2F5LWRyaXZlci0zZGY1OC5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImF1ZCI6Imh0dHBzOlwvXC9pZGVudGl0eXRvb2xraXQuZ29vZ2xlYXBpcy5jb21cL2dvb2dsZS5pZGVudGl0eS5pZGVudGl0eXRvb2xraXQudjEuSWRlbnRpdHlUb29sa2l0IiwiaWF0IjoxNjY2NDMxOTA5LCJleHAiOjE2NjY0MzU1MDksInVpZCI6ODgsImNsYWltcyI6eyJwcmVtaXVtX2FjY291bnQiOmZhbHNlfX0.RQS89Fpj40cxdpj0TPdFZ0MsP4ZxIYz3Zyhp1VffPjShu7dlQZaVI2OyKHP0sASbDa2CwtPp6bIW7fnK-HtS0_MRoTcXbSdPtuGHihgCXiJMEn3ajJCk90BiLx5dohkGpjDOWoT_Jr_j4PLPUYZnrofTn1KfNckcUnyyPyk9tKKd2yGd2vd9sh_sdiYQnrkhc4fnrUGYGEw-BREpfH9GD43R1KdPi0qvmUefTiPhV-THMy2wF4h8UX0uR5IxvaC5j-qBIjmhAIzboCeSohe_a4klwG-s3xdGq3SdzxDYXxomNRJZY4HhWQy9X4Ul8L7Q4VgAj8dRkeMsY9gMFtoE9g'
    }, body: {
      "restaurant_id": "1",
      "status": "1",
      'page': "1",
      'search': "296"
    });
  }
}
