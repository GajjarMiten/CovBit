// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CovidAPI_india.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CovidApiInd extends CovidApiInd {
  _$CovidApiInd([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CovidApiInd;

  @override
  Future<Response<dynamic>> getCounntryData() {
    final $url = 'https://covid-19india-api.herokuapp.com/v2.0/country_data';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStateData() {
    final $url = 'https://covid-19india-api.herokuapp.com/v2.0/state_data';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLabData() {
    final $url =
        'https://covid-19india-api.herokuapp.com/v2.0/icmr_lab_details';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getHelplineNumber() {
    final $url =
        'https://covid-19india-api.herokuapp.com/v2.0/helpline_numbers';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
