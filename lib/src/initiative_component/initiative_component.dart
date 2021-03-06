import 'package:angular2/core.dart';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/directive_component/directive_component.dart';
import 'package:kpi_dash/src/models/goal.dart';
import 'package:kpi_dash/src/models/initiative.dart';
import 'package:kpi_dash/src/models/strategy.dart';
import 'package:kpi_dash/src/models/year.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';

@Component(
    selector: 'my-init',
    styleUrls: const ['initiative_component.css'],
    templateUrl: 'initiative_component.html',
    directives: const [
      materialDirectives,
      COMMON_DIRECTIVES,
      CORE_DIRECTIVES,
      DirectiveComponent
    ])
class InitiativeComponent {
  @Input()
  Year year;

  @Input()
  Goal goal;

  @Input()
  Strategy strat;

  bool saveDialog = false;
  String message;

  final FirebaseService fbService;
  InitiativeComponent(this.fbService);

  void add(String name, String description) {
    if (name.isEmpty || description.isEmpty) return;
    fbService.addInit(year, goal, strat, name, description);
    saveDialog = !fbService.preventAdditional;
    message = "Initiative Added";
  }

  void delete(Initiative init) {
    fbService.deleteInit(year.key, goal.key, strat.key, init.key);
    strat.initiatives.remove(init);
    saveDialog = !fbService.preventAdditional;
    message = "Initiative Deleted";
  }

  void update(Initiative init) {
    fbService.changeInitName(year, goal, strat, init);
    fbService.changeInitDescription(year, goal, strat, init);
    saveDialog = !fbService.preventAdditional;
    message = "Edit Saved";
  }
}
