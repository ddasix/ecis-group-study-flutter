# 코팩튜브

## 사전지식

### `http` 요청

- `TCP`,`UDP`를 사용함.
- 요청(request)과 응답(response)으로 구분 함.
- http 기반 API 종류
    - REST API
        - GET, POST, PUT, DELETE 메서드를 사용하여 통신하는 가장 대중적인 API
            - GET: 데이터를 가져옴.
            - POST: 데이터를 저장 함. body가 있음.
            - PUT: 데이터를 업데이트 함. body가 있음.
            - DELETE: 데이터를 삭제 함.
        - http를 이용하여 Resouce를 명시하고 해당 Resource에 대한 CRUD를 실행함.
        - 정해진 규격의 API를 사용함.
        - 균일한 인터페이스, 무상태, 계층화, 캐시원칙을 준수하는 HTTP API
        - REST API의 4가지 조건
            1. 균일한 인터페이스
                - 요청만으로도 어떤 리소스를 접근하려는지 알 수 있어야 함.
                - 수정,삭제 시 해당작업의 리소스 정보를 충분히 제공해야 함.
            2. 무상태(Stateless)
                - 이전 또는 이후의 요청과 완전 분리 되어야 함.
            3. 계층화된 시스템
                - 클라이언트와 서버간 다른 중개자의 요청을 연결 할 수 있음.
            4. 캐시
                - 응답속도를 개선할 목적으로 일부 리소스를 저장할 수 있음.
                - 공통으로 사용하는 이미지나 헤더가 있을 때 해당 요청을 캐싱함으로써 응답 속도를 빠르게 하거나 불필요한 요청을 줄일 수 있음.
    - GraphQL
        - Graph구조를 띄고 있으며 클라이언트에서 직접 필요한 데이터를 명시하여 필요한 데이터만 가져옴
    - gRPC(Google Remote Protocole Calls)
        -`http/2`를 사용하는 통신방식.
        - 프로토콜 버퍼를 사용하여 레이턴시를 최소화 함.
- `dio`플러그인
    ```dart
        import 'package:dio/dio/dart';

        void main() async {
            final getResp = Dio().get('http://test.codefactory.ai');
            final postResp = Dio().post('http://test.codefactory.ai');
            final putResp = Dio().put('http://test.codefactory.ai');
            final deleteResp = Dio().delete('http://test.codefactory.ai');
        }
    ```

### `json`
- `http`요청에서 body를 구성할 때 `xml`과 `json` 나뉨.
- 현대에는 대부분 `json`구조를 사용함.

## 실습
