

class RealtimeServiceProtocol {

  Map<String, double> getGPSData(String stringData){
    Map<String, double> gpsData = {
      "x" : 0,
      "y" : 0,
    };
    try{
      // 'GPS'를 기준으로 문자열을 분할하고 x, y 좌표를 가져옴
      List<String> dataList = stringData.split(' ');

      // x와 y 좌표를 double로 변환하여 저장
      double x = double.parse(dataList[1]);
      double y = double.parse(dataList[2]);

      // 결과를 맵에 저장
      gpsData = {
        "x" : x,
        "y" : y,
      };
    } catch (e){
      // 예외가 발생하면 기본값인 0, 0으로 설정
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
      result = "GPS ${listData[0]} ${listData[1]} ";
    } catch (e){
      result = "GPS 0 0 " ;
    }
    return result;
  }

}