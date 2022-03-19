<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!doctype html>

<html>

  <head>

    <title>버스 서비스 스마트 평가 웹 사이트</title>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- 부트스트랩 CSS 추가하기 -->

    <link rel="stylesheet" href="./css/bootstrap.min.css">

    <!-- 커스텀 CSS 추가하기 -->

    <link rel="stylesheet" href="./css/custom.css">

  </head>

  <body>

<%
	request.setCharacterEncoding("UTF-8");
	
	String busDriverName = "전체";
	
	String searchType = "최신순";
	
	String search = "";
	
	int pageNumber = 0;
	
	if(request.getParameter("busDriverName") != null) {
	
		busDriverName = request.getParameter("busDriverName");
	
	}
	
	if(request.getParameter("searchType") != null) {
	
		searchType = request.getParameter("searchType");
	
	}
	
	if(request.getParameter("search") != null) {
	
		search = request.getParameter("search");
	
	}
	
	if(request.getParameter("pageNumber") != null) {
	
		try {
	
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	
		} catch (Exception e) {
	
			System.out.println("검색 페이지 번호 오류");
	
		}
	
	}



	
	String userID = null;

	if(session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");

	}

	if(userID == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('로그인을 해주세요.');");

		script.println("location.href = 'userLogin.jsp'");

		script.println("</script>");

		script.close();	
		return;

	}

	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);

	if(emailChecked == false) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("location.href = 'emailSendConfirm.jsp'");

		script.println("</script>");

		script.close();		

		return;

	}

%>	

    <nav class="navbar navbar-expand-lg navbar-light bg-light">

      <a class="navbar-brand" href="index.jsp">버스 서비스 스마트 평가 웹 사이트</a>

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">

        <span class="navbar-toggler-icon"></span>

      </button>

      <div class="collapse navbar-collapse" id="navbar">

        <ul class="navbar-nav mr-auto">

          <li class="nav-item active">

            <a class="nav-link" href="index.jsp">메인</a>

          </li>

          <li class="nav-item dropdown">

            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">

              회원 관리

            </a>

            <div class="dropdown-menu" aria-labelledby="dropdown">

<%

	if(userID == null) {

%>

              <a class="dropdown-item" href="userLogin.jsp">로그인</a>

              <a class="dropdown-item" href="userRegister.jsp">회원가입</a>

<%

	} else {

%>

              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>

<%

	}

%>

            </div>

          </li>

        </ul>

        <form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
          <input type="text" name="search" class="form-control mr-sm-2" placeholder="내용을 입력하세요.">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
        </form>

      </div>

    </nav>


	<div class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="busDriverName" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="일반버스" <%if(busDriverName.equals("일반버스")) out.println("selected");%>>일반버스</option>
				<option value="마을버스" <%if(busDriverName.equals("마을버스")) out.println("selected");%>>마을버스</option>
				<option value="고속버스" <%if(busDriverName.equals("고속버스")) out.println("selected");%>>고속버스</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="추천수" <% if(searchType.equals("추천순")) out.println("selected");%>>추천순</option>
			</select>
			<input type="text name="search class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
		</form>
		<%
			ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
			evaluationList = new EvaluationDAO().getList(busDriverName,searchType,search,pageNumber);
			if(evaluationList != null)
				for(int i=0;i< evaluationList.size(); i++){
					if(i==5) break;
					EvaluationDTO evaluation = evaluationList.get(i);
		%>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"> (<%=evaluation.getBusNum() %>번)&nbsp;<small><%=evaluation.getBusDriverName()%></small></div>
					<div class="col-4 text-right">
						종합<span style="color:red;"><%=evaluation.getTotalScore() %></span>
					</div>
				</div>
			</div>
			
				<div class="card-body">
					<h5 class="card-title">
						<%=evaluation.getEvaluationTitle()%>&nbsp;<small>(<%=evaluation.getBusBoardingYear()%>년 <%=evaluation.getBusBoardingMonth()%>월 <%=evaluation.getBusBoardingDay()%>일)</small>
					</h5>
					<p class="card-text"><%= evaluation.getEvaluationContent() %></p>
					<div class="row">
						<div class="col-9 text-left">
							친절도 <span style="color: red;"><%= evaluation.getKindnessScore() %></span>
							청결도 <span style="color: red;"><%= evaluation.getCleanlinessScore() %></span>
							운전 <span style="color: red;"><%= evaluation.getDrivingSkillsScore() %></span>
							<span style="color: green;">(추천:<%= evaluation.getLikeCount() %>)</span>
						</div>
						<div class="col-3 text-right">
							<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">추천</a>
							<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">삭제</a>
						</div>
					</div>
				</div>
			</div>
	<%
		}
	%>	
    <ul class="pagination justify-content-center mt-3">

      <li class="page-item">

<%

	if(pageNumber <= 0) {

%>     

        <a class="page-link disabled">이전</a>

<%

	} else {

%>

		<a class="page-link" href="./index.jsp?busDriverName=<%=URLEncoder.encode(busDriverName, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">이전</a>

<%

	}

%>

      </li>

      <li class="page-item">

<%

	if(evaluationList.size() < 6) {

%>     

        <a class="page-link disabled">다음</a>

<%

	} else {

%>

		<a class="page-link" href="./index.jsp?busDriverName=<%=URLEncoder.encode(busDriverName, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">다음</a>

<%

	}

%>

      </li>

    </ul>			
			
			
			
	

		
		
	</div>
	
	
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
 				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>버스 번호</label>
								<input type="text" name="busNum" class="form-control" maxlength="7">
							</div>
							<div class="form-group col-sm-6">
								<label>버스 종류</label>
								<select name="busDriverName" class="form-control">
									<option value="일반버스" selected>일반버스</option>
									<option value="마을버스">마을버스</option>
									<option value="고속버스">고속버스</option>
								</select>
							</div>
							
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>년</label>
								<select name="busBoardingYear" class="form-control">
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022" selected>2022</option>
									<option value="2023">2023</option>
									<option value="2024">2024</option>
									<option value="2025">2025</option>
									<option value="2026">2026</option>
									<option value="2027">2027</option>
									<option value="2028">2028</option>
									<option value="2029">2029</option>
									<option value="2030">2030</option>
									<option value="2031">2031</option>
									<option value="2032">2032</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>월</label>
								<select name="busBoardingMonth" class="form-control">
									<option value="01" selected>01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>일</label>
								<select name="busBoardingDay" class="form-control">
									<option value="01" selected>01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									<option value="25">25</option>
									<option value="26">26</option>
									<option value="27">27</option>
									<option value="28">28</option>
									<option value="29">29</option>
									<option value="30">30</option>
									<option value="31">31</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>종합</label>
								<select name="totalScore" class="form-control">
									<option value="A" >A</option>
									<option value="B" >B</option>
									<option value="C" selected>C</option>
									<option value="D" >D</option>
									<option value="E" >E</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>고객 응대</label>
								<select name="kindnessScore" class="form-control">
									<option value="A" >A</option>
									<option value="B" >B</option>
									<option value="C" selected>C</option>
									<option value="D" >D</option>
									<option value="E" >E</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>청결도</label>
								<select name="cleanlinessScore" class="form-control">
									<option value="A" >A</option>
									<option value="B" >B</option>
									<option value="C" selected>C</option>
									<option value="D" >D</option>
									<option value="E" >E</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>운전 실력</label>
								<select name="drivingSkillsScore" class="form-control">
									<option value="A" >A</option>
									<option value="B" >B</option>
									<option value="C" selected>C</option>
									<option value="D" >D</option>
									<option value="E" >E</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" date-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
 				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-group">
							<label>신고 제목</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" date-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">신고하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright ⓒ 2022  IoT 사물인터넷 캡스톤 디자인 All Rights Reserved
	</footer>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>