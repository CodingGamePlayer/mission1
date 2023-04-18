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
                        <button class="btn btn-primary btn-sm mx-1" onclick="openPopup()">WiFi정보 불러오기</button>
                        <button class="btn btn-facebook btn-sm mx-1">History 보기</button>
                        <button class="btn btn-facebook btn-sm mx-1">북마크 보기</button>


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


                        <table class="table table-bordered table-hover text-sm-center  " id="dataTable" width="100%"
                               cellspacing="0">
                            <thead>
                            <tr>
                                <th>No</th>
                                <th>X좌표</th>
                                <th>Y좌표</th>
                                <th>검색시간</th>
                            </tr>
                            </thead>
                            <tfoot class="text-sm-center">
                            <tr>
                                <th>No</th>
                                <th>X좌표</th>
                                <th>Y좌표</th>
                                <th>검색시간</th>
                            </tr>
                            </tfoot>
                            <tbody id="table-data-area">
                            <c:forEach var="item" items="${historyList}">
                                <tr>
                                    <td>${item.h_id}</td>
                                    <td>${item.h_x}</td>
                                    <td>${item.h_y}</td>
                                    <td>${item.h_date}</td>
                                </tr>
                            </c:forEach>
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