<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

<body id="page-top">

<!-- Page Wrapper -->
<div class="card">
    <div class="card-header">
        <div class="row">
            <div class="col-sm-3 d-flex align-items-center">
                <span class="text-center text-primary text-lg font-weight-bold">WiFi정보 상세보기</span>
            </div>
            <div class="col-sm-3">
                <select class="custom-select-sm d-block w-100 d-inline" id="select_gr_id" required>
                    <c:forEach var="bookmark" items="${bookmarkList}">
                        <option value="${bookmark.gr_id}">${bookmark.gr_name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-sm-3">
                <a href="#" class="btn btn-primary btn-icon-split btn-sm" onclick="addBookmark()">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-flag"></i>
                                        </span>
                    <span class="text">북마크에 추가</span>
                </a>
            </div>
        </div>

        <script>
            function addBookmark() {
                let wifi_id = ${param.wifi_id};
                let gr_id = document.getElementById('select_gr_id').value;

                console.log(wifi_id + " " + gr_id);

                const url = "/bookmark/insert?wifi_id=" + wifi_id + "&gr_id=" + gr_id;
                console.log(url)
                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'text/plain;charset=UTF-8'
                    }
                }).then(response => {
                    if (response.ok) alert('등록이 되었습니다.');
                }).catch(error => alert(error))
            }
        </script>

    </div>
    <div class="card-body">
        <form class="needs-validation" novalidate>

            <div class="mb-3">
                <label for="wifi_id">No</label>
                <input type="text" class="form-control" id="wifi_id" value="${wifi.wifi_id}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_no">관리번호</label>
                <input type="text" class="form-control" id="wifi_no" value="${wifi.no}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_wrdofc">자치구</label>
                <input type="text" class="form-control" id="wifi_wrdofc" value="${wifi.wrdofc}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_nm">와이파이명</label>
                <input type="text" class="form-control" id="wifi_nm" value="${wifi.nm}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_adres1">도로명주소</label>
                <input type="text" class="form-control" id="wifi_adres1" value="${wifi.adres1}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_adres2">상세주소</label>
                <input type="text" class="form-control" id="wifi_adres2" value="${wifi.adres2}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_floor">설치위치(층)</label>
                <input type="text" class="form-control" id="wifi_floor" value="${wifi.floor}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_ty">설치유형</label>
                <input type="text" class="form-control" id="wifi_ty" value="${wifi.ty}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_mby">설치기관</label>
                <input type="text" class="form-control" id="wifi_mby" value="${wifi.mby}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_se">서비스구분</label>
                <input type="text" class="form-control" id="wifi_se" value="${wifi.se}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_cmcwr">망종류</label>
                <input type="text" class="form-control" id="wifi_cmcwr" value="${wifi.cmcwr}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_year">설치년도</label>
                <input type="text" class="form-control" id="wifi_year" value="${wifi.year}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_door">실내외구분</label>
                <input type="text" class="form-control" id="wifi_door" value="${wifi.door}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_remars3">WIFI접속 환경</label>
                <input type="text" class="form-control" id="wifi_remars3" value="${wifi.remars3}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_lat">X좌표</label>
                <input type="text" class="form-control" id="wifi_lat" value="${wifi.lat}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_lnt">Y좌표</label>
                <input type="text" class="form-control" id="wifi_lnt" value="${wifi.lnt}" disabled>
            </div>
            <div class="mb-3">
                <label for="wifi_dttm">작업일자</label>
                <input type="text" class="form-control" id="wifi_dttm" value="${wifi.dttm}" disabled>
            </div>
            <hr class="mb-4">
        </form>

    </div>
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