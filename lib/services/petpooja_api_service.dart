import 'package:cutso/models/models.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'petpooja_api_service.chopper.dart';

const String apiKey = "f14qd3se9a6juzbmoit85c0nrvhykgwp";
const String apiSecretKey = "0ecb9930ec89b68dbc923d3ecedc43f37901cf61";
const String apiAccessToken = "04fc7877ce7e5f771328b2a1434cb040ad1b2c0f";
const String restaurantCode = "k13cv5ho";

const Map<String, String> menuBody = {
  "content-type": "Application/json",
  "app_key": apiKey,
  "app_secret": apiSecretKey,
  "access_token": apiAccessToken,
  "restID": restaurantCode,
  "data_type": "json",
};

@ChopperApi(baseUrl: '/mapped_restaurant_menus')
abstract class PostApiService extends ChopperService {
  @Post()
  Future<Response> menuPost(
    @Body() Map<String, String> body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://qle1yy2ydc.execute-api.ap-southeast-1.amazonaws.com/V1',
      services: [
        _$PostApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$PostApiService(client);
  }
}

final apiProvider = Provider.autoDispose<PostApiService>((ref) {
  final PostApiService service = PostApiService.create();
  ref.onDispose(() => service.client.dispose());
  return service;
});

class MyApiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Consumer(builder: (context, watch, child) {
          PostApiService apiService = watch(apiProvider);
          return FutureBuilder<Response>(
              future: apiService.menuPost(menuBody),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.3,
                      ),
                    );
                  }
                  var cat = snapshot.data!.body["categories"][0];
                  var myCat = CategoryModel.fromJson(cat);

                  return Center(
                    child: Text(
                      myCat.toJson().toString(),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                    ),
                  );
                }
                return Center(child: Text('LOADING'));
              });
        }),
      ),
    );
  }
}
