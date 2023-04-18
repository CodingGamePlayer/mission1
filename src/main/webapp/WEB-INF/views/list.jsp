<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Zerobase-Mission1</title>

    <!-- Custom fonts for this template -->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>
<style>
    td {
        white-space: nowrap; /* 텍스트를 한 줄에 표시 */
        overflow: hidden; /* 넘치는 텍스트를 숨김 */
        text-overflow: ellipsis; /* 넘치는 텍스트를 ...으로 대체 */
    }
</style>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- DataTales Example -->
                <div class="card shadow mb-4 mt-4" style="font-size: small;">
                    <div class="card-header py-3">
                        <c:if test="${not empty param.latitude}">
                            <label for="myposition1">LAT</label>
                            <input type="text" class="border border-rounded mx-2" id="myposition1"
                                   value="${param.latitude}">
                            <label for="myposition2">LNT</label>
                            <input type="text" class="border border-rounded mx-2" id="myposition2"
                                   value="${param.longitude}">
                        </c:if>
                        <c:if test="${empty param.latitude}">
                            <label for="myposition1">LAT</label>
                            <input type="text" class="border border-rounded mx-2" id="myposition1">
                            <label for="myposition2">LNT</label>
                            <input type="text" class="border border-rounded mx-2" id="myposition2">
                        </c:if>
                        <button class="btn btn-primary btn-sm mx-1" id="get-location-btn" onclick="">주변 WiFi 정보 보기
                        </button>
                        <button class="btn btn-primary btn-sm mx-1" onclick="openPopup()">WiFi 정보 불러오기</button>
                        <a class="btn btn-facebook btn-sm mx-1" href="/history">History 보기</a>
                        <a class="btn btn-facebook btn-sm mx-1" href="/bookmark?gr_id=0">북마크 보기</a>


                        <script>

                            function openPopup() {
                                window.open("spinner", "popup", "width=400, height=300, top=300, left=700");
                            }


                            const getLocationBtn = document.getElementById("get-location-btn");
                            const myLAT = document.getElementById("myposition1");
                            const myLNT = document.getElementById("myposition2");


                            getLocationBtn.addEventListener("click", () => {

                                if ("geolocation" in navigator) {

                                    navigator.geolocation.getCurrentPosition(function (position) {
                                        const latitude = position.coords.latitude;
                                        const longitude = position.coords.longitude;

                                        myLAT.value = latitude;
                                        myLNT.value = longitude;


                                        const findWifi = function () {
                                            window.location.href = "/list?latitude=" + latitude + "&longitude=" + longitude;
                                        }

                                        // 와이파이를 찾는 함수
                                        findWifi()

                                    }, function (error) {
                                        console.error("Error Code = " + error.code + " - " + error.message);
                                    });

                                } else {

                                    console.log("Geolocation is not available.");

                                }
                            });


                        </script>

                    </div>

                    <div class="card-body">


                            <table class="table table-bordered table-hover text-sm-center">
                                <thead>
                                <tr>
                                    <th>거리(km)</th>
                                    <th>관리번호</th>
                                    <th>자치구</th>
                                    <th>와이파이명</th>
                                    <th>도로명주소</th>
                                    <th>상세주소</th>
                                    <th>설치 위치 (층)</th>
                                    <th>설치유형</th>
                                    <th>설치<br>기관</th>
                                    <th>서비스<br>구분</th>
                                    <th>망종류</th>
                                    <th>설치년도</th>
                                    <th>실내외구분</th>
                                    <th>WIFI접속 환경</th>
                                    <th>X좌표</th>
                                    <th>Y좌표</th>
                                    <th>작업일자</th>
                                </tr>
                                </thead>
                                <tfoot class="text-sm-center">
                                <tr>
                                    <th>No</th>
                                    <th>관리번호</th>
                                    <th>자치구</th>
                                    <th>와이파이명</th>
                                    <th>도로명주소</th>
                                    <th>상세주소</th>
                                    <th>설치위치(층)</th>
                                    <th>설치유형</th>
                                    <th>설치기관</th>
                                    <th>서비스구분</th>
                                    <th>망종류</th>
                                    <th>설치년도</th>
                                    <th>실내외구분</th>
                                    <th>WIFI접속 환경</th>
                                    <th>X좌표</th>
                                    <th>Y좌표</th>
                                    <th>작업일자</th>
                                </tr>
                                </tfoot>
                                <tbody id="table-data-area">

                                <c:forEach var="wifi" items="${wifiList}">
                                        <tr>
                                            <td>${(wifi.distance * 100) / 100}</td>
                                            <td>${wifi.no}</td>
                                            <td>${wifi.wrdofc}</td>
                                            <td><a href="#" onclick="detail(${wifi.wifi_id})">${wifi.nm}</a></td>
                                            <td>${wifi.adres1}</td>
                                            <td>${wifi.adres2}</td>
                                            <td>${wifi.floor}</td>
                                            <td>${wifi.ty}</td>
                                            <td>${wifi.mby}</td>
                                            <td>${wifi.se}</td>
                                            <td>${wifi.cmcwr}</td>
                                            <td>${wifi.year}</td>
                                            <td>${wifi.door}</td>
                                            <td>${wifi.remars3}</td>
                                            <td>${wifi.lat}</td>
                                            <td>${wifi.lnt}</td>
                                            <td>${wifi.dttm}</td>
                                        </tr>
                                </c:forEach>
                                <script>
                                    function detail(id) {
                                        window.open("detail?wifi_id=" + id, "popup", "width=800, height=1000, top=0, left=1500");
                                    }
                                </script>

                                </tbody>
                            </table>


                    </div>
                </div>

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->


    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->

<!-- Bootstrap core JavaScript-->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/resources/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="/resources/js/demo/datatables-demo.js"></script>

</body>

</html>