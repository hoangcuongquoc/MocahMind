import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  late final AudioPlayer player;

  @override
  void onInit() {
    super.onInit();
    player = AudioPlayer(); // ✅ KHỞI TẠO Ở ĐÂY (KHÔNG phải ở trên class)
  }

  Future<void> play(String url) async {
    try {
      print('[AudioController] Playing URL: $url');
      await player.setUrl(url);
      await player.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }


  void pause() => player.pause();
  void resume() => player.play();
  void stop() => player.stop();

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

}
