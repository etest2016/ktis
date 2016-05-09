package etest;

import qmtm.DBPool;
import qmtm.QmTmException;

import java.sql.Timestamp;
import java.io.*;
import java.util.Collection;
import java.util.ArrayList;

public class User_Log {
	public User_Log() {
	}

	public static void saveLogText(String log_type, String id_exam,
			String userid, String id_activity_type, String user_ip,
			String browser, String nr_q, String id_q, String answers,
			String remain_time) throws QmTmException {
		try {
			String dirName = DBPool.LOG_PATH + id_exam;

			if (log_type.length() == 0) log_type = "2";
			
			String fileName = userid;
			
			if (log_type.equals("1")) fileName += "_evt.txt";
			else fileName += "_ans.txt";
			
			String strText; // 저장할 XML 파일 내용
			strText = id_exam + DBPool.FLD_KB;
			strText += userid + DBPool.FLD_KB;

			if (log_type.equals("1")) {
				strText += id_activity_type + DBPool.FLD_KB;
				strText += user_ip + DBPool.FLD_KB;
				strText += browser + DBPool.FLD_KB;
			} else {
				strText += nr_q + DBPool.FLD_KB;
				strText += id_q + DBPool.FLD_KB;
				strText += answers + DBPool.FLD_KB;
				strText += remain_time + DBPool.FLD_KB;
			}
			String now = new Timestamp(System.currentTimeMillis()).toString().substring(0, 19);
			strText += now + DBPool.NL;
			// Save file
			if (!(log_type.equals("2") && answers.length() == 0)) DBPool.saveFile(strText, dirName, fileName, true);  // 답안로그시 답이 없으면 제외 : refresh 의 경우
			
		} catch (Exception ex) {
			throw new QmTmException("응시자 로그 저장하는 중 인터넷 연결상태가 좋지 않습니다. [User_Log.saveLogText]" + ex.getMessage());
		}
	}

	private static String readFile(String fullPathFileName) throws QmTmException {

		try {
			FileReader input = new FileReader(fullPathFileName);
			BufferedReader bufInput = new BufferedReader(input);
			StringWriter output = new StringWriter();
			BufferedWriter bufOutput = new BufferedWriter(output);
			String line = bufInput.readLine(); // read the first line
			
			while (line != null) {
				// write the line out to the output
				bufOutput.write(line, 0, line.length());
				bufOutput.newLine();
				// read the next line
				line = bufInput.readLine();
			}
			bufInput.close();
			// bufOutput.flush(); 필요한건지...
			bufOutput.close();
			return output.toString();
		} catch (Exception ex) {
			throw new QmTmException("응시자 로그 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_Log.readFile]");
		}
	}

	public static boolean deleteFile(String fileName) throws QmTmException {
		boolean isDeletd = false;
		File file = new File(fileName);
		try {
			isDeletd = file.delete();
			return isDeletd;
		} catch (Exception ex) {
			throw new QmTmException("응시자 로그파일 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [User_Log.deleteFile]");
		}
	}

	public static User_LogAnswerBean[] getLogAnswers(String id_exam, String userid) throws QmTmException {
		try {
			String fullPathFileName = DBPool.LOG_PATH + id_exam + "/" + userid + "_ans.txt";
			String logs = readFile(fullPathFileName);
			
			if (logs == null) return null;
			
			String[] arrRecord = logs.split(DBPool.NL);

			Collection beans = new ArrayList();
			User_LogAnswerBean bean = null;

			for (int i = 0; i < arrRecord.length; i++) {
				bean = makeLogAnswerBean(arrRecord[i]);
				
				if (bean != null) beans.add(bean);
				else continue;
				
			}
			
			if (beans.isEmpty()) return null;
			else return (User_LogAnswerBean[]) beans.toArray(new User_LogAnswerBean[0]);
			
		} catch (Exception ex) {
			throw new QmTmException("응시자 로그 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_Log.getLogAnswers]");
		}
	}

	private static User_LogAnswerBean makeLogAnswerBean(String logAnswer) throws QmTmException {

		try {
			String[] arr = logAnswer.split(DBPool.FLD_KB, -1);
			
			if (arr.length != 7) return null;
			
			User_LogAnswerBean bean = new User_LogAnswerBean();
			bean.setId_exam(arr[0]);
			bean.setUserid(arr[1]);
			bean.setNr_q(arr[2]);
			bean.setId_q(arr[3]);
			bean.setAnswers(arr[4]);
			bean.setRemain_time(arr[5]);
			bean.setDate_time(arr[6]);
			return bean;
		} catch (Exception ex) {
			throw new QmTmException("응시자 로그 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_Log.makeLogAnswerBean]");
		}
	}

	public static User_LogEventBean[] getLogEvents(String id_exam, String userid) throws QmTmException {

		try {
			String fullPathFileName = DBPool.LOG_PATH + id_exam + "/" + userid + "_evt.txt";
			String logs = readFile(fullPathFileName);
			
			if (logs == null) return null;
			
			String[] arrRecord = logs.split(DBPool.NL);
			Collection beans = new ArrayList();
			User_LogEventBean bean = null;

			for (int i = 0; i < arrRecord.length; i++) {
				bean = makeLogEventBean(arrRecord[i]);
				
				if (bean != null) beans.add(bean);
				else continue;
				
			}
			
			if (beans.isEmpty()) return null;
			else return (User_LogEventBean[]) beans.toArray(new User_LogEventBean[0]);
			
		} catch (Exception ex) {
			throw new QmTmException("응시자 로그 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_Log.getLogEvents]");
		}
	}

	private static User_LogEventBean makeLogEventBean(String logEvent) throws QmTmException {
		
		try {
			String[] arr = logEvent.split(DBPool.FLD_KB, -1);
			
			if (arr.length != 6) return null;
			
			User_LogEventBean bean = new User_LogEventBean();
			bean.setId_exam(arr[0]);
			bean.setUserid(arr[1]);
			bean.setId_activity_type(arr[2]);
			bean.setUser_ip(arr[3]);
			bean.setBrowser(arr[4]);
			bean.setDate_time(arr[5]);
			return bean;
		} catch (Exception ex) {
			throw new QmTmException("응시자 로그 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_Log.makeLogEventBean]");
		}
	}

	public static String getEvent(String id) {
		int i = Integer.parseInt(id, 10);

		// 정상 : blue (0~9)
		if (i == 0) return "입실/답안지생성";
		else if (i == 1) return "시험시작";
		else if (i == 2) return "새로고침";
		else if (i == 3) return "이어풀기";
		else if (i == 4) return "?예비항목?";
		else if (i == 5) return "답안지제출";
		else if (i == 6) return "답안지재제출";
		else if (i == 7) return "답안지제출성공";
		else if (i == 8) return "자동채점/성적공개";
		else if (i == 9) return "퇴실";

		// 경고 : red (10~49) -> 창 관련 (10~19)
		else if (i == 11) return "창크기변경";
		else if (i == 12) return "창위치변경";
		else if (i == 13) return "포커스이동";
		// -> Alt 관련 (20~29)
		else if (i == 20) return "강제종료[X]";
		else if (i == 21) return "강제종료[Alt+F4]";
		else if (i == 22) return "화면전환[Alt+Tab]";
		else if (i == 23) return "화면전환[Alt+Esc]";
		// -> Ctrl 관련 (30~39)
		// -> 기타 조작 (40~49)
		else if (i == 41) return "타이머조작";

		// 주의 : gray (50~89)
		else if (i == 51) return "[Window]";
		else if (i == 52) return "[Context]";
		else if (i == 53) return "도움말[F1]";
		else if (i == 54) return "검색창[F3]";
		else if (i == 55) return "새로고침[F5]";

		// ??? : gray
		else if (i == 99) return "기타";
		else return "????";
	}
}
