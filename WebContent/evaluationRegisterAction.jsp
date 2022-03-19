<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="evaluation.EvaluationDTO"%>

<%@ page import="evaluation.EvaluationDAO"%>


<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");

	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String busNum = null;
	String busDriverName = null;
	String busBoardingYear = null;
	String busBoardingMonth = null;
	String busBoardingDay = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	String totalScore = null;
	String kindnessScore = null;
	String cleanlinessScore = null;
	String drivingSkillsScore = null;
	
	
	
	if(request.getParameter("busNum") != null) {

		busNum = (String) request.getParameter("busNum");

	}

	if(request.getParameter("busDriverName") != null) {

		busDriverName = (String) request.getParameter("busDriverName");

	}

	if(request.getParameter("busBoardingYear") != null) {
		busBoardingYear = (String) request.getParameter("busBoardingYear");
		
	}
	if(request.getParameter("busBoardingMonth") != null) {
		busBoardingMonth = (String) request.getParameter("busBoardingMonth");
	}
	if(request.getParameter("busBoardingDay") != null) {
		busBoardingDay = (String) request.getParameter("busBoardingDay");
	}
	if(request.getParameter("evaluationTitle") != null) {

		evaluationTitle = (String) request.getParameter("evaluationTitle");

	}
	if(request.getParameter("evaluationContent") != null) {

		evaluationContent = (String) request.getParameter("evaluationContent");

	}
	if(request.getParameter("totalScore") != null) {

		totalScore = (String) request.getParameter("totalScore");

	}
	if(request.getParameter("kindnessScore") != null) {

		kindnessScore = (String) request.getParameter("kindnessScore");

	}
	if(request.getParameter("cleanlinessScore") != null) {

		cleanlinessScore = (String) request.getParameter("cleanlinessScore");

	}
	if(request.getParameter("drivingSkillsScore") != null) {

		drivingSkillsScore = (String) request.getParameter("drivingSkillsScore");

	}

	if (busNum == null || busDriverName == null || busBoardingYear == null || busBoardingMonth == null || busBoardingDay == null ||
			evaluationTitle == null || evaluationContent == null || totalScore == null || kindnessScore == null ||
			cleanlinessScore == null || drivingSkillsScore == null || evaluationTitle.equals("")||
			evaluationContent.equals("")) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('입력이 안 된 사항이 있습니다.');");

		script.println("history.back();");

		script.println("</script>");

		script.close();
		
		return;
	}else {

		EvaluationDAO evaluationDAO = new EvaluationDAO();
		int result = evaluationDAO.write(new EvaluationDTO(0,userID,busNum,busDriverName,busBoardingYear,busBoardingMonth,busBoardingDay,
				evaluationTitle,evaluationContent,totalScore,kindnessScore,cleanlinessScore,drivingSkillsScore,0));
		if (result == -1) {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("alert('평가 등록에 실패했습니다.');");

			script.println("history.back();");

			script.println("</script>");

			script.close();

			return;

		} else {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("location.href = './index.jsp';");

			script.println("</script>");

			script.close();

			return;

		}
	}
	
%>