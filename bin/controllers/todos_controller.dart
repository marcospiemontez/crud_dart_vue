import '../dto/todos_dto.dart';
import 'controller.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/todos_model.dart';
import '../services/generic_service.dart';

class TodosController extends Controller {
  final GenericService<TodosModel> _todosService;

  TodosController(this._todosService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/todo', (Request req) async {
      var body = await req.readAsString();
      var dto = TodosDTO.fromRequest(jsonDecode(body));

      var todosModel = TodosModel()
        ..id = dto.id
        ..title = dto.title
        ..description = dto.description
        ..userId = dto.userId;

      var result = await _todosService.save(todosModel);
      return result ? Response(201) : Response(500);
    });

    router.get('/todos/findAll', (Request req) async {
      List<TodosModel> todos = await _todosService.findAll();
      List<Map> todosMap = todos.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(todosMap));
    });

    router.get('/todos/findById', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var todos = await _todosService.findById(int.parse(id));

      if (todos == null) return Response(400);

      return Response.ok(jsonEncode(todos.toJson()));
    });

    router.put('/todos', (Request req) async {
      var body = await req.readAsString();
      var dto = TodosDTO.fromRequest(jsonDecode(body));

      var todosModel = TodosModel()
        ..id = dto.id
        ..title = dto.title
        ..description = dto.description
        ..userId = dto.userId;

      var result = await _todosService.save(todosModel);
      return result ? Response(200) : Response(500);
    });

    router.delete('/todos', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _todosService.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(router: router, middlewares: middlewares);
  }
}
