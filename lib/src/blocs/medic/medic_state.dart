part of 'medic_bloc.dart';

class MedicState extends Equatable {
  const MedicState._({
    this.status = MedicStatus.unknown,
    this.medic = Medic.empty,
  });

  const MedicState.unknown() : this._();

  const MedicState.success(Medic medic)
      : this._(status: MedicStatus.success, medic: medic);

  const MedicState.failure() : this._(status: MedicStatus.failure);

  final MedicStatus status;
  final Medic medic;

  @override
  List<Object> get props => [];
}
