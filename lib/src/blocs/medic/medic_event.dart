part of 'medic_bloc.dart';

abstract class MedicEvent extends Equatable {
  const MedicEvent();

  @override
  List<Object> get props => [];
}

class MedicStatusChanged extends MedicEvent {
  const MedicStatusChanged(this.status);

  final MedicStatus status;

  @override
  List<Object> get props => [status];
}
