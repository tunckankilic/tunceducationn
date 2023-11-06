import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/chat/domain/entities/group.dart';
import 'package:tunceducationn/src/chat/domain/repos/chat_repo.dart';

class GetGroups extends StreamUsecaseWithoutParams<List<Group>> {
  const GetGroups(this._repo);

  final ChatRepo _repo;

  @override
  ResultStream<List<Group>> call() => _repo.getGroups();
}
