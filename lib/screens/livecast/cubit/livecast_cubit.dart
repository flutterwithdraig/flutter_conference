import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:global_conference/const.dart';

part 'livecast_state.dart';

class LivecastCubit extends Cubit<LivecastState> {
  late RtcEngine _engine;

  LivecastCubit() : super(LivecastInitial()) {
    _init();
  }

  _init() async {
    _engine = await RtcEngine.create(agoriaAppId);
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Audience);
    _engine.setEventHandler(RtcEngineEventHandler(
      userJoined: (uid, elapsed) {
        emit(LivecastLoaded(uid));
      },
    ));

    _engine.enableVideo();
    _engine.joinChannel(agoriaToken, 'event1', null, 0);
  }

  @override
  Future<void> close() {
    _engine.leaveChannel();
    _engine.destroy();
    return super.close();
  }
}
