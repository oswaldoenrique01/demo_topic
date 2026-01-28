import 'package:commons/commons.dart';
import '../entities/agent_entity.dart';

abstract class HomeRepository {
  Future<Result<List<AgentEntity>>> getAgents();
}
