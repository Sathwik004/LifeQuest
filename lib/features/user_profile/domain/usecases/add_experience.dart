import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/user_profile/domain/repo/user_repo.dart';

class AddExperienceUseCase implements UseCase<void, AddExperienceParams> {
  final UserRepository userRepository;

  AddExperienceUseCase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(AddExperienceParams params) async {
    return await userRepository.addExperience(params.userId, params.experience);
  }
}

class AddExperienceParams {
  final String userId;
  final int experience;

  AddExperienceParams({required this.userId, required this.experience});
}
