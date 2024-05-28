

class RealtimeServiceProtocol {

  Map<String, double> getGPSData(String stringData){
    Map<String, double> gpsData = {
      "x" : 0,
      "y" : 0,
    };
    try{
      List<String> dataList = stringData.split(' ');

      double x = double.parse(dataList[0]);
      double y = double.parse(dataList[1]);

      gpsData = {
        "x" : x,
        "y" : y,
      };
    } catch (e){
      gpsData = {
        "x" : 0,
        "y" : 0,
      };
    }
    return gpsData;
  }

  Map<String, dynamic> getPredictData(String stringData){
    Map<String, dynamic> predictData = {
      "method" : "",
      "body" : [],
    };

    try{
      List<String> dataList = stringData.split(' ');
      String method = dataList[0];
      String body = dataList.sublist(1).join(' ');
      predictData['method'] = method;
      predictData['body'] = body.split(',');
    } catch (e){
      Map<String, String> predictData = {
        "method" : "Error",
        "body" : e.toString(),
      };
    }
    return predictData;
  }

  String makeGPSSendData(listData){
    String result;
    try{
      result = "GPS ${listData[0]} ${listData[1]}";
    } catch (e){
      result = "GPS 0 0";
    }
    return result;
  }

}