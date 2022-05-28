part of 'livecast_cubit.dart';

abstract class LivecastState extends Equatable {
  const LivecastState();

  @override
  List<Object> get props => [];
}

class LivecastInitial extends LivecastState {}

class LivecastLoaded extends LivecastState {
  final int uid;
  const LivecastLoaded(this.uid);
  @override
  List<Object> get props => [uid];
}
