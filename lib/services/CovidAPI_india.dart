

import 'package:chopper/chopper.dart';

part 'CovidAPI_india.chopper.dart';

@ChopperApi(baseUrl: 'https://covid-19india-api.herokuapp.com/v2.0/')
abstract class CovidApiInd extends ChopperService{


    @Get(path: 'country_data')
    Future<Response> getCounntryData();

    @Get(path: 'state_data')
    Future<Response> getStateData();

    @Get(path: 'icmr_lab_details')
    Future<Response> getLabData();

    @Get(path: 'helpline_numbers')
    Future<Response> getHelplineNumber();

    static CovidApiInd create(){
      final client = ChopperClient(
      services: [
        _$CovidApiInd(),
      ],
      converter: JsonConverter(),
    );

    return _$CovidApiInd(client);
    }

}