import 'package:film_app/data/repository/user_repository.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/entities/user.dart';
import 'package:film_app/domain/usecase/upload_profile_picture/upload_profile_picture_params.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class UploadProfilePicture
    implements UseCase<Result<User>, UploadProfilePictureParam> {
  final UserRepository _userRepository;

  UploadProfilePicture({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<User>> call(UploadProfilePictureParam param) =>
      _userRepository.uploadProfilePictur(
          user: param.user, imageFile: param.imageFile);
}
