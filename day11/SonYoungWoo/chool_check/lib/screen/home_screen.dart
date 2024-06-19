import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {

  //회사 지도 위치
  static final LatLng companyLatLng = LatLng(35.1182665, 129.0418535,);

  //회사 지도 위치에 마킹 표시
  static final Marker marker = Marker(markerId: MarkerId("company"),
   position: companyLatLng
  );

  //회사 지도 위치 기준으로 원으로 범위지정
  static final Circle circle = Circle(
      circleId: CircleId("choolcheckCircle"),
      center: companyLatLng,
      fillColor: Colors.blue.withOpacity(0.5),
      radius: 100,
      strokeColor: Colors.blue,
      strokeWidth: 1,
  );
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       //3등분해서 위에는 앱바
       appBar: renderAppBar(),
       //중간은 지도 + 출근버튼
       body: FutureBuilder<String>(
         builder: (context,snapshot) {
           //checkpermission 값이 없거나 대기중이면
           if(!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting)
           {
               //원형의 진행 프로그래스바 보여줌.
               return Center( child: CircularProgressIndicator(),);
           }

           //받은 값이 권한 받았으면
           if(snapshot.data == "위치권한이 허가 되었습니다.")
           {
             return Column(
               children: [
                 Expanded(
                   flex: 5,
                   child: GoogleMap( //구글맵 사용
                     initialCameraPosition: CameraPosition(
                       target: companyLatLng, //화면 위치는 회사위치
                       zoom: 18, //배율 18배
                     ),
                     markers: Set.from([marker]),//마커
                     circles: Set.from([circle]),
                     myLocationEnabled: true,
                   ),
                 ),
                 Expanded(child:
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(
                       Icons.timelapse_outlined,
                       color: Colors.blue,
                       size: 50,
                     ),
                     SizedBox(height: 20,),
                     ElevatedButton(
                       onPressed: () async {
                        //현재위치
                         final curPostion = await Geolocator.getCurrentPosition();

                         double x = companyLatLng.latitude;
                         double y = companyLatLng.longitude;
                        //현재 위치를 제대로 가져오지 못해서 회사 위치 근처값으로 설정
                         final distance = Geolocator.distanceBetween(
                             x - 0.0000001,
                             y - 0.0000001,
                             companyLatLng.latitude,
                             companyLatLng.longitude);
                        //차이가 100m 이내이면
                         bool check = distance < 100;
                         showDialog(
                             context: context,
                             builder: (_){
                               //다아얼로그
                               return AlertDialog(
                                 title: Text("출근하기"),
                                 content: Text(
                                   check ? "출근을 하시겠습니까?": "출근할 수 없음"
                                 ),
                                 actions: [
                                   TextButton(
                                       onPressed: (){
                                         Navigator.of(context).pop(false);
                                       },
                                       child: Text("취소"),
                                   ),
                                   if(check)
                                     TextButton(
                                         onPressed: () {
                                           Navigator.of(context).pop(true);
                                         },
                                         child: Text("출근하기"),
                                     ),
                                 ],
                               );
                             });

                       },
                       child: Text("출근하기"),)
                   ],
                 )
                 )
               ],
             );
           }
          //권한이 없을경우
           return Center(
             child: Text(snapshot.data.toString()),
           );

         },
         future: checkPermission(),
       )
     );
  }

  AppBar renderAppBar(){
    return AppBar(
       centerTitle: true,
      title: const Text("오늘도 출첵",
        style: TextStyle(
          color: Colors.blue,
        fontWeight: FontWeight.w700,
      ),
     ),
      backgroundColor: Colors.white,
    );
  }

  Future<String> checkPermission() async {
    //위치서비스 활성화 여부
    final isLocationEnable = await Geolocator.isLocationServiceEnabled();

    if(!isLocationEnable) {
      return "위치서비스를 활성화 해주세요";
    }
    //권한 체크
    LocationPermission checkPermission = await Geolocator.checkPermission();

    if(checkPermission == LocationPermission.denied)
    {
      checkPermission = await Geolocator.requestPermission();
      if(checkPermission == LocationPermission.denied)
      {
        return "위치권한를 활성화 해주세요";
      }
    }
    //닫으면
    if(checkPermission == LocationPermission.deniedForever)
    {
        return "앱의 위치 권한을 설정에서 허가해주세요.";
    }

    return "위치권한이 허가 되었습니다.";
  }


}