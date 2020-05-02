import 'package:coronavirus_tracker_app/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

class Api {
  final String apiKey;

  Api({@required this.apiKey});

  factory Api.sandbox() => Api(apiKey: ApiKeys.ncovSandboxKey);

  static final String host = 'apigw.nubentos.com';
  static final int port = 443;

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );
}
