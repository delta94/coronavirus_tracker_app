import 'package:coronavirus_tracker_app/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum Endpoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class Api {
  final String apiKey;

  Api({@required this.apiKey});

  factory Api.sandbox() => Api(apiKey: ApiKeys.ncovSandboxKey);

  static final String host = 'apigw.nubentos.com';
  static final String basePath = 't/nubentos.com/ncovapi/1.0.0';
  static final int port = 443;

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri endpointUri(Endpoint endPoint) => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: '$basePath/${_paths[endPoint]}',
      );

  static Map<Endpoint, String> _paths = {
    Endpoint.casesSuspected: 'cases/suspected',
    Endpoint.casesConfirmed: 'cases/confirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
    Endpoint.cases: 'cases',
  };
}
