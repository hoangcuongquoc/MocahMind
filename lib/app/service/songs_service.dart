import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mochamind/app/models/songs_models.dart'; // sửa nếu path khác

class SongsService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<SongsModel>> fetchSongs() async {
    try {
      final response = await _client
          .from('songs')
          .select()
          .order('created_at', ascending: false);

      return response.map<SongsModel>((e) => SongsModel.fromJson(e)).toList();
    } catch (e) {
      print('⚠️ Lỗi khi fetch songs: $e');
      return [];
    }
  }
  Future<List<SongsModel>> getSongsByCategory(String categoryId) async {
    final response = await _client
        .from('songs')
        .select()
        .eq('category_id', categoryId) // ← truy vấn theo foreign key
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((json) => SongsModel.fromJson(json))
        .toList();
  }
  Future<List<SongsModel>> searchSongsByName(String keyword) async {
    final data = await _client
        .from('songs')
        .select()
        .ilike('title', '%$keyword%'); // Tìm gần đúng

    return List<Map<String, dynamic>>.from(data)
        .map((e) => SongsModel.fromJson(e))
        .toList();
  }
}
