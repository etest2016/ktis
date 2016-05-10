package qmtm.tman.exam;

public class ChapterScoreBean {

	private String id_chapter;
	private String chapter;
	private double score;
		
	public ChapterScoreBean() {
	}
		
	public void setId_chapter(String id_chapter) {
		this.id_chapter = id_chapter;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}	
	public void setScore(double score) {
		this.score = score;
	}
	
	public String getId_chapter() {
		return id_chapter;
	}	
	public String getChapter() {
		return chapter;
	}
	public double getScore() {
		return score;
	}		
}