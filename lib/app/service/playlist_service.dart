import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/playlist_models.dart';
import '../models/songs_models.dart';

class PlaylistService {
  final _client = Supabase.instance.client;
  SupabaseClient get client => _client; // 👈 THÊM DÒNG NÀY

  /// 🔹 Lấy tất cả playlists
  Future<List<Playlist>> getAllPlaylists() async {
    final user = _client.auth.currentUser;
    if (user == null) return [];

    final data = await _client
        .from('playlists')
        .select('*')
        .eq('user_id', user.id) // ✅ Chỉ lấy playlist người dùng
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(data)
        .map((e) => Playlist.fromJson(e))
        .toList();
  }


  /// 🔹 Lấy playlists kèm bài hát đầu tiên (nếu có)
  Future<List<Map<String, dynamic>>> getPlaylistsWithFirstSong() async {
    final playlists = await getAllPlaylists();

    List<Map<String, dynamic>> result = [];

    for (final playlist in playlists) {
      SongsModel? firstSong;

      if (playlist.songIds.isNotEmpty) {
        final songId = playlist.songIds.first;

        final data = await _client
            .from('songs')
            .select()
            .eq('id', songId)
            .maybeSingle();

        if (data != null) {
          firstSong = SongsModel.fromJson(data);
        }
      }

      result.add({
        'playlist': playlist,
        'song': firstSong,
      });
    }

    return result;
  }

  /// 🔹 Lấy toàn bộ bài hát trong playlist
  Future<List<SongsModel>> getSongsInPlaylist(List<String> songIds) async {
    if (songIds.isEmpty) return [];

    final data = await _client
        .from('songs')
        .select()
        .inFilter('id', songIds);

    return List<Map<String, dynamic>>.from(data)
        .map((e) => SongsModel.fromJson(e))
        .toList();
  }
  Future<void> createPlaylist(String name, String description, String imageUrl) async {
    final user = _client.auth.currentUser;
    print('👤 User ID: ${user?.id}'); // 👈 check

    if (user == null) throw Exception('Chưa đăng nhập');

    await _client.from('playlists').insert({
      'name': name,
      'description': description,
      'picture': imageUrl,
      'is_pined': false,
      'user_id': user.id,
    });
  }





  /// 🔹 Thêm bài hát vào playlist (append vào mảng song_ids)
  Future<void> addSongToPlaylist(int playlistId, String songId) async {
    await _client.rpc('add_song_to_playlist', params: {
      'playlist_id_input': playlistId,
      'song_id_input': songId,
    });
  }


  /// 🔹 Xoá bài hát khỏi playlist
  Future<void> removeSongFromPlaylist(int playlistId, String songId) async {
    await _client.rpc('remove_song_from_playlist', params: {
      'playlist_id_input': playlistId,
      'song_id_input': songId,
    });
  }

  /// 🔹 Lấy bài hát theo ID
  Future<SongsModel?> getSongById(String songId) async {
    final data = await _client
        .from('songs')
        .select()
        .eq('id', songId)
        .maybeSingle();

    return data != null ? SongsModel.fromJson(data) : null;
  }
  Future<void> updatePlaylist({
    required int id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isPined,
  }) async {
    final updates = <String, dynamic>{};

    if (name != null) updates['name'] = name;
    if (description != null) updates['description'] = description;
    if (imageUrl != null) updates['picture'] = imageUrl;
    if (isPined != null) updates['is_pined'] = isPined;

    if (updates.isNotEmpty) {
      await _client.from('playlists').update(updates).eq('id', id);
    }
  }
  Future<void> deletePlaylist(int id) async {
    await _client.from('playlists').delete().eq('id', id);
  }


}
