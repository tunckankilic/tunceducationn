import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/chat/domain/entities/message.dart';
import 'package:tunceducationn/src/chat/domain/repos/chat_repo.dart';

class GetMessages extends StreamUsecaseWithParams<List<Message>, String> {
  const GetMessages(this._repo);

  final ChatRepo _repo;

  @override
  ResultStream<List<Message>> call(String params) => _repo.getMessages(params);
}
