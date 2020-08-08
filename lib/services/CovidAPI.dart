import 'package:chopper/chopper.dart';

part 'CovidAPI.chopper.dart';

@ChopperApi(baseUrl: 'https://covid19-api.org/api/')
abstract class CovidAPI extends ChopperService {
  @Get(path: 'status')
  Future<Response> getStatus();

  @Get(path: 'status?date={date}')
  Future<Response> getStatusByDate(@Path('date') String date);

  @Get(path: 'status/{country}')
  Future<Response> getStatusByCountry(@Path('country') String country);

  @Get(path: 'status/{country}?date={date}')
  Future<Response> getStatusByCountryDate(
      @Path('country') String country, @Path('date') String date);

  @Get(path: 'diff')
  Future<Response> getDiff();

  @Get(path: 'diff/{country}')
  Future<Response> getDiffByCountry(@Path('country') String country);

  @Get(path: 'timeline')
  Future<Response> getTimeline();

  @Get(path: 'timeline/{country}')
  Future<Response> getTimelineByCountry(@Path('country') String country);

  @Get(path: 'countries')
  Future<Response> getCountries();

  @Get(path: 'country/{country}')
  Future<Response> getCountry(@Path('country') String country);

  @Get(path: 'prediction/{country}')
  Future<Response> getPredictionOfCountry(@Path('country') String country);

  static CovidAPI create() {
    final client = ChopperClient(
      services: [
        _$CovidAPI(),
      ],
      converter: JsonConverter(),
    );

    return _$CovidAPI(client);
  }
}
