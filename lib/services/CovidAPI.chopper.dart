// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CovidAPI.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CovidAPI extends CovidAPI {
  _$CovidAPI([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CovidAPI;

  @override
  Future<Response<dynamic>> getStatus() {
    final $url = 'https://covid19-api.org/api/status';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStatusByDate(String date) {
    final $url = 'https://covid19-api.org/api/status?date=$date';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStatusByCountry(String country) {
    final $url = 'https://covid19-api.org/api/status/$country';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStatusByCountryDate(
      String country, String date) {
    final $url = 'https://covid19-api.org/api/status/$country?date=$date';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDiff() {
    final $url = 'https://covid19-api.org/api/diff';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDiffByCountry(String country) {
    final $url = 'https://covid19-api.org/api/diff/$country';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getTimeline() {
    final $url = 'https://covid19-api.org/api/timeline';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getTimelineByCountry(String country) {
    final $url = 'https://covid19-api.org/api/timeline/$country';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCountries() {
    final $url = 'https://covid19-api.org/api/countries';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCountry(String country) {
    final $url = 'https://covid19-api.org/api/country/$country';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPredictionOfCountry(String country) {
    final $url = 'https://covid19-api.org/api/prediction/$country';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
