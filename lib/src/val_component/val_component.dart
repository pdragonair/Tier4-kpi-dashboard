import 'package:angular2/core.dart';
import 'dart:core';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/models/models.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';
import 'dart:html';


@Component(
  selector: 'my-val',
  styleUrls: const ['val_component.css'],
  templateUrl: 'val_component.html',
  directives: const [materialDirectives, COMMON_DIRECTIVES, CORE_DIRECTIVES,
  MaterialExpansionPanel, MaterialExpansionPanelSet,
  DisplayNameRendererDirective,
  MaterialCheckboxComponent,
  MaterialDropdownSelectComponent,
  MaterialSelectComponent,
  MaterialSelectItemComponent,],
  providers: const [materialProviders],
)

class ValComponent {

  String protocol;
  bool disable=false;

  String month = null;
  @Input()
  Year year;
  Value selectedVal;

  final FirebaseService fbService;

  ValComponent(this.fbService);


  var months = const <String>[
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];


  void pickMonth(String m) {
    month = m;
    print (month);
  }


  num inputVal = null;
  void addValue(Year year, Goal goal, Strategy strat, Initiative init, Dir dir,) {
    num value = inputVal;

    if (value == null) return;

    fbService.addVal(year, goal, strat, init, dir, month, value);
  }

  void deleteValue(Year year, Goal goal, Strategy strat, Initiative init, Dir dir, Value val){
    fbService.deleteVal(year.key, goal.key, strat.key, init.key, dir.key, val.key);
    dir.values.remove(val);
  }

  void changeValue(Year year, Goal goal, Strategy strat, Initiative init, Dir dir, Value val){
    fbService.changeVal(year, goal, strat, init, dir, val);
  }

  void alert(String s)
  {
    window.alert(s);
  }


}