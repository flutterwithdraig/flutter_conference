import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:global_conference/blocs/auth/auth_bloc.dart';
import 'package:global_conference/const.dart';
import 'package:global_conference/models/app_user.dart';
import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/repositories/conference.dart';

part 'livecast_state.dart';

class LivecastCubit extends Cubit<LivecastState> {
  late RtcEngine _engine;
  final ConferenceRepository _conferenceRepository;
  final AuthBloc _authBloc;
  final ConfEvent _confEvent;

  LivecastCubit({
    required ConferenceRepository conferenceRepository,
    required AuthBloc authBloc,
    required ConfEvent confEvent,
  })  : _conferenceRepository = conferenceRepository,
        _authBloc = authBloc,
        _confEvent = confEvent,
        super(LivecastInitial()) {
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

    final AppUser user = _authBloc.state.user;
    final token =
        await _conferenceRepository.getLiveToken(user.uid, _confEvent.id);

    _engine.joinChannel(token, _confEvent.id, null, 0);
  }

  @override
  Future<void> close() {
    _engine.leaveChannel();
    _engine.destroy();
    return super.close();
  }
}
