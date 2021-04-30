import 'dart:async';
import 'dart:convert';

import 'package:cutso/models/models.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      converter: ModelConverter(),
      errorConverter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$PostApiService(client);
  }
}

class ModelConverter implements Converter {
  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(
      Response<dynamic> response) {
    return decodeJson<BodyType, InnerType>(response);
  }

  @override
  Request convertRequest(Request request) {
    final req =
        applyHeader(request, contentTypeKey, jsonHeaders, override: false);
    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    var contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    var contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    try {
      var mapData = json.decode(body);
      var data = PostMenu.fromJson(mapData);
      return response.copyWith<BodyType>(body: data as BodyType);
    } catch (e) {
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(body: body);
    }
  }
}

final apiProvider = Provider.autoDispose<PostApiService>((ref) {
  final PostApiService _service = PostApiService.create();
  ref.onDispose(() => _service.client.dispose());
  return _service;
});

class PostMenuNotifier extends ChangeNotifier {
  PostMenu? _postMenu;
  PostMenu? get postMenu => _postMenu;
  List<String?> getItems(String patentCategoryId) =>
      _postMenu!.getItems(patentCategoryId);
  void setPostMenu(PostMenu postMenu) => _postMenu = postMenu;
  List<String?> getParentCategoryIds() => _postMenu!.getParentCategoryIds();
  List<String?> getCategoryIds() => _postMenu!.getCategoryIds();
}

final postMenuProvider = ChangeNotifierProvider((ref) => PostMenuNotifier());

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
                  context
                      .read(postMenuProvider)
                      .setPostMenu(snapshot.data!.body);
                  return Center(
                    child: Text(
                      context
                          .read(postMenuProvider)
                          .getItems("298")
                          .toString(),
                      // "LOL",
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
