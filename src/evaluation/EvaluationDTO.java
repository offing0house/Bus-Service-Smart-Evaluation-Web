package evaluation;

public class EvaluationDTO {
	int evaluationID;
	String userID;
	String busNum;
	String busDriverName;
	String busBoardingYear;
	String busBoardingMonth;
	String busBoardingDay;
	String evaluationTitle;
	String evaluationContent;
	String totalScore;
	String kindnessScore;
	String cleanlinessScore;
	String drivingSkillsScore;
	int likeCount;
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBusNum() {
		return busNum;
	}
	public void setBusNum(String busNum) {
		this.busNum = busNum;
	}
	public String getBusDriverName() {
		return busDriverName;
	}
	public void setBusDriverName(String busDriverName) {
		this.busDriverName = busDriverName;
	}
	public String getBusBoardingYear() {
		return busBoardingYear;
	}
	public void setBusBoardingYear(String busBoardingYear) {
		this.busBoardingYear = busBoardingYear;
	}
	public String getBusBoardingMonth() {
		return busBoardingMonth;
	}
	public void setBusBoardingMonth(String busBoardingMonth) {
		this.busBoardingMonth = busBoardingMonth;
	}
	public String getBusBoardingDay() {
		return busBoardingDay;
	}
	public void setBusBoardingDay(String busBoardingDay) {
		this.busBoardingDay = busBoardingDay;
	}
	public String getEvaluationTitle() {
		return evaluationTitle;
	}
	public void setEvaluationTitle(String evaluationTitle) {
		this.evaluationTitle = evaluationTitle;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getKindnessScore() {
		return kindnessScore;
	}
	public void setKindnessScore(String kindnessScore) {
		this.kindnessScore = kindnessScore;
	}
	public String getCleanlinessScore() {
		return cleanlinessScore;
	}
	public void setCleanlinessScore(String cleanlinessScore) {
		this.cleanlinessScore = cleanlinessScore;
	}
	public String getDrivingSkillsScore() {
		return drivingSkillsScore;
	}
	public void setDrivingSkillsScore(String drivingSkillsScore) {
		this.drivingSkillsScore = drivingSkillsScore;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public EvaluationDTO() {
		
	}
	
	public EvaluationDTO(int evaluationID, String userID, String busNum, String busDriverName, String busBoardingYear,
			String busBoardingMonth, String busBoardingDay, String evaluationTitle, String evaluationContent,
			String totalScore, String kindnessScore, String cleanlinessScore, String drivingSkillsScore,
			int likeCount) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.busNum = busNum;
		this.busDriverName = busDriverName;
		this.busBoardingYear = busBoardingYear;
		this.busBoardingMonth = busBoardingMonth;
		this.busBoardingDay = busBoardingDay;
		this.evaluationTitle = evaluationTitle;
		this.evaluationContent = evaluationContent;
		this.totalScore = totalScore;
		this.kindnessScore = kindnessScore;
		this.cleanlinessScore = cleanlinessScore;
		this.drivingSkillsScore = drivingSkillsScore;
		this.likeCount = likeCount;
	}
	
}
