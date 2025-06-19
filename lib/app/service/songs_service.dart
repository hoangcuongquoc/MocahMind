import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/songs_models.dart'; // sửa đường dẫn nếu khác

class SongsService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<SongsModel>> fetchSongs() async {
    final response = await _client
        .from('songs') // bảng 'songs'
        .select();

    if (response != null && response is List) {
      return response.map((json) => SongsModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load songs");
    }
  }
}
