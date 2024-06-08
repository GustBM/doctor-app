import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medic_repository/medic_repository.dart';

part 'medic_event.dart';
part 'medic_state.dart';

class MedicBloc extends Bloc<MedicEvent, MedicState> {
  MedicBloc({
    required MedicRepository medicRepository,
  })  : _medicRepository = medicRepository,
        super(const MedicState.unknown()) {
    if (isClosed) return;
    on<MedicStatusChanged>(_onMedicStatusChanged);
  }

  final MedicRepository _medicRepository;
  late StreamSubscription<MedicStatus> _medicStatusSubscription;

  @override
  Future<void> close() {
    _medicStatusSubscription.cancel();
    _medicRepository.dispose();
    return super.close();
  }

  Future<void> _onMedicStatusChanged(
    MedicStatusChanged event,
    Emitter<MedicState> emit,
  ) async {
    switch (event.status) {
      case MedicStatus.failure:
        return emit(const MedicState.failure());
      case MedicStatus.success:
        final medic = await _tryGetMedic();
        return emit(
          medic != null
              ? MedicState.success(medic)
              : const MedicState.failure(),
        );
      case MedicStatus.unknown:
        return emit(const MedicState.unknown());
    }
  }

  Future<Medic?> _tryGetMedic() async {
    try {
      final medic = _medicRepository.getSetMedic;
      return medic;
    } catch (_) {
      return null;
    }
  }
}
