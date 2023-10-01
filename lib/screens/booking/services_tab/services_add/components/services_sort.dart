import 'package:fl_booking_app/models/models.dart';

class ServicesByParameters {
  List<FLService> servicesWithNoParam = [];
  Map servicesMapWithParam = <int, List<FLService>>{};
}

class ServicesByLOB {
  Map serviceMapByLOB = <String, ServicesByParameters>{};

  ServicesByLOB(List<FLService> baseServiceList) {
    for (var element in baseServiceList) {
      // check if elements' LineOfBusiness
      // (and conaequently instance of ServiceDiff)
      // is already in the map "serviceMapByLOB"
      if (serviceMapByLOB.containsKey(element.lineOfBusiness) == true) {
        // YES -> check if elements' HasParameter is true
        if (element.hasParam == true) {
          // YES-> check if the ServiceDiff instances'
          // map "servicesMapWithParam"
          // already has elements' ServiceId
          if (serviceMapByLOB[element.lineOfBusiness]
                  .servicesMapWithParam
                  .containsKey(element.serviceId) ==
              true) {
            // YES-> add element to the LineHasParam List
            // with the same key as elements' serviceId
            serviceMapByLOB[element.lineOfBusiness]
                .servicesMapWithParam[element.serviceId]
                .add(element);
          } else {
            // NO-> create new entry in LineHasParam map
            // key = elements' ServiceId
            // value = element in List form
            serviceMapByLOB[element.lineOfBusiness]
                .servicesMapWithParam[element.serviceId] = [element];
          }
        } else {
          // NO-> add element to servicesWithNoParam List
          serviceMapByLOB[element.lineOfBusiness]
              .servicesWithNoParam
              .add(element);
        }
      } else {
        // NO-> create new entry in serviceMapByLOB map
        // key = elements' LineOfBusiness
        // value = new instance of ServiceDiff
        ServicesByParameters newSD = ServicesByParameters(); // empty instance
        if (element.hasParam == true) {
          // if elements' HasParameter is true
          // create new entry in LineHasParam empty map
          // key = elements' ServiceId
          // value = element in List form
          newSD.servicesMapWithParam[element.serviceId] = [element];
        } else {
          // else add element to servicesWithNoParam List
          newSD.servicesWithNoParam.add(element);
        }
        serviceMapByLOB[element.lineOfBusiness] = newSD;
      }
    }
  }
}
