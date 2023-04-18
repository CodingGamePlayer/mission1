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
                        <div class="row d-flex align-items-start">
                            <div class="col-sm-3">
                                <select class="custom-select-sm w-100 d-inline mb-3"
                                        id="select_gr_id"
                                        style="border-color: #848695" onchange="reload()">

                                    <c:if test="${param.gr_id == 0}">
                                        <option>Choose</option>
                                        <c:forEach var="bookmark" items="${bookmarkList}">
                                            <option value="${bookmark.gr_id}"
                                            >${bookmark.gr_name}</option>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${param.gr_id != 0}">
                                        <c:forEach var="bookmark" items="${bookmarkList}">
                                            <c:choose>
                                                <c:when test="${bookmark.gr_id == param.gr_id}">
                                                    <option value="${bookmark.gr_id}"
                                                            selected>${bookmark.gr_name}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    ${bookmark.gr_id}
                                                    <option value="${bookmark.gr_id}"
                                                    >${bookmark.gr_name}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </c:if>
                                </select>
                            </div>
                            <button class="btn btn-primary btn-sm mx-1" data-toggle="modal"
                                    data-target="#updateBookmark">북마크명 변경
                            </button>
                            <button class="btn btn-secondary btn-sm mx-1" onclick="deleteBookmark()">북마크 삭제</button>
                            <button class="btn btn-primary btn-sm mx-1" data-toggle="modal"
                                    data-target="#insertBookmark">북마크 추가
                            </button>
                        </div>
                        <script>
                            function deleteBookmark() {
                                if (window.confirm( '북마크를 삭제 하시겠습니까?')) {
                                    fetch('/bookmark-group?gr_id=' + ${param.gr_id}, {
                                        method : "DELETE",
                                        headers : {
                                            'Content-Type' : 'text/plain;char=UTF-8'
                                        }
                                    }).then(response => {
                                        if (response.ok) {
                                            window.location.href = '/';
                                        }
                                    })
                                }
                            }
                        </script>
                        <!-- 북마크명 변경 Modal -->
                        <div class="modal fade" id="updateBookmark" data-backdrop="static" data-keyboard="false"
                             tabindex="-1" aria-labelledby="updateBookmarkTitle" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title font-weight-bold text-primary" id="updateBookmarkTitle">
                                            북마크명 변경</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="">
                                            <c:forEach var="bookmark" items="${bookmarkList}">
                                                <c:if test="${param.gr_id == bookmark.gr_id}">
                                                    <div class="mb-3">
                                                        <label for="new_gr_id">북마크명</label>
                                                        <input type="text" class="form-control" id="new_gr_name" value="${bookmark.gr_name}">
                                                    </div>
                                                    <input type="hidden" value="${bookmark.gr_id}" id="new_gr_id"/>
                                                </c:if>
                                            </c:forEach>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기
                                        </button>
                                        <a href="#" class="btn btn-primary" onclick="updateBookmark()">변경하기</a>
                                    </div>

                                    <script>
                                        function updateBookmark() {
                                            const new_gr_name = document.getElementById('new_gr_name').value;
                                            const new_gr_id = document.getElementById('new_gr_id').value;

                                            const bookmark = {
                                                gr_id : new_gr_id,
                                                gr_name : new_gr_name
                                            }

                                            fetch('/bookmark-group', {
                                                method : 'PUT',
                                                body : JSON.stringify(bookmark),
                                                headers : {
                                                    'Content-Type' : 'application/json;char=UTF-8'
                                                }
                                            }).then(response => {
                                                if (response.ok){
                                                    alert('업데이트 되었습니다.')
                                                    window.location.reload();
                                                }
                                            })
                                        }
                                    </script>
                                </div>
                            </div>
                        </div>

                        <!-- 북마크명 추가 Modal -->
                        <div class="modal fade" id="insertBookmark" data-backdrop="static" data-keyboard="false"
                             tabindex="-1" aria-labelledby="insertBookmarkLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title font-weight-bold text-primary" >
                                            북마크 추가</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="new_gr_id">북마크명</label>
                                            <input type="text" class="form-control" id="create_gr_name" >
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기
                                        </button>
                                        <button type="button" class="btn btn-primary" onclick="insetBookmark()">추가하기</button>
                                    </div>
                                </div>
                                <script>
                                    function insetBookmark() {
                                        const new_gr_name = document.getElementById('create_gr_name').value;

                                        fetch('/bookmark-group?gr_name=' + new_gr_name, {
                                            method : 'POST',
                                            headers : {
                                                'Content-Type' : 'application/json;char=UTF-8'
                                            }
                                        }).then(response => {
                                            if (response.ok){
                                                alert('추가 되었습니다.')
                                                window.location.reload();
                                            }
                                        })
                                    }
                                </script>
                            </div>
                        </div>

                        <table class="table table-bordered table-hover text-sm-center">
                            <thead>
                            <tr>
                                <th>삭제</th>
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
                            </thead>
                            <tfoot class="text-sm-center">
                            <tr>
                                <th>삭제</th>
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

                            <c:if test="${wifiList != null}">
                                <c:forEach var="wifi" items="${wifiList}">
                                    <tr>
                                        <td><a href="/bookmark/delete?gr_id=${param.gr_id}&bm_id=${wifi.bm_id}"
                                               class="text-danger">삭제</a></td>
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
                            </c:if>
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
<script>
    function reload() {
        let gr_id = document.querySelector('#select_gr_id');
        console.log(gr_id);
        window.location.href = "/bookmark?gr_id=" + gr_id.value;
    }
</script>
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