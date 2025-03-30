import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../const/api_const.dart';

class GifService {
  Future<List<String>> searchGifs(String query) async {
    // uri - автоматически формирует правильный url из частей
    final uri = Uri.https(ApiConstants.baseUrl, '/v1/gifs/search', {
      'api_key': ApiConstants.apiKey,
      'q': query,
      'limit': '${ApiConstants.limit}',
      'rating': 'g'
    });

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response
            .body); // превращение в объект dart из формата данных интернета
        final List gifs = jsonData['data'];
        if (kDebugMode) {
          debugPrint('Successfully loaded ${gifs.length} GIF.');
        }
        return gifs
            .map((gif) => gif['images']['original']['url'] as String)
            .toList();
      } else {
        if (kDebugMode) {
          debugPrint('Error ${response.statusCode}');
        }
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
