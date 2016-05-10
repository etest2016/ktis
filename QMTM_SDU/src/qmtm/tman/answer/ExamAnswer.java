package qmtm.tman.answer;

// Package Import
import qmtm.QmTm;
import qmtm.DBPool;
import qmtm.QmTmException;
import qmtm.common.ExamInfo;
import qmtm.common.ExamInfoBean;

// Java API Import
import java.sql.Timestamp;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class ExamAnswer {
	public ExamAnswer() {
	}

	private static ExamAnswerBean makeBean(ResultSet rst) throws QmTmException {
		try {
			ExamAnswerBean bean = new ExamAnswerBean();
			bean.setAnswers(rst.getString("answers"));
			bean.setEnd_time(rst.getTimestamp("end_time"));
			bean.setId_exam(rst.getString("id_exam"));
			bean.setNr_set(rst.getInt("nr_set"));
			bean.setOxs(rst.getString("oxs"));
			bean.setPoints(rst.getString("points"));
			bean.setRemain_time(rst.getLong("remain_time"));
			bean.setScore(rst.getDouble("score"));
			bean.setScore_bak(rst.getDouble("score_bak"));
			bean.setScore_log(rst.getString("score_log"));
			bean.setStart_time(rst.getTimestamp("start_time"));
			bean.setUserid(rst.getString("userid"));
			bean.setYn_end(rst.getString("yn_end"));
			bean.setYn_mark(rst.getString("yn_mark"));
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("������ ����� ������ �о���� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.makeBean] " + ex.getMessage());
		}
	}

	public static ExamAnswerBean getBean(String userid, String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "SELECT * FROM exam_ans WHERE userid = ? AND id_exam = ? ";
		
		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("������ ����� ������ �о���� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.getBean] " + ex.getMessage());
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) { }
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static ExamAnswerBean[] getBeans(String id_exam, String yn_end) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "SELECT * FROM exam_ans WHERE id_exam = ? and yn_end = ? ";
		try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_exam);
			stm.setString(2, yn_end);
			rst = stm.executeQuery();
			
			ExamAnswerBean bean = null;
			
			while (rst.next()) {
				bean = makeBean(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (ExamAnswerBean[]) beans.toArray(new ExamAnswerBean[0]);
			}
		} catch (SQLException ex) {
			throw new QmTmException("������ ����� ������ �о���� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.getBeans] " + ex.getMessage());
		} finally {
			if (rst != null) 	try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) 	try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) 	try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	public static void insert(ExamAnswerBean bean) throws QmTmException {
		Connection cnn = null;
		PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_ans (userid, id_exam, ");
		sql.append("       nr_set, start_time, end_time, ");
		sql.append("       remain_time, yn_end, answers, yn_mark) ");
		sql.append("VALUES (?, ?, ?, getdate(), getdate(), 0, ?, ?, 'N') ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getUserid());
			stm.setString(2, bean.getId_exam());
			stm.setInt(3, bean.getNr_set());
			stm.setString(4, bean.getYn_end());
			stm.setString(5, bean.getAnswers());
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� ����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.insert] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void bakcopy2(String userid, String id_exam) throws QmTmException {
		Connection cnn = null;
		PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Delete From bak_exam_ans ");
		sql.append("Where userid = ? and id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.execute();
			// ����� ����� ��� ����
			ExamAnswerNon.bakcopy2(userid, id_exam);
						
			bakcopy(userid, id_exam);
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� ������̺�� �̵��ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.bakcopy2] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
	 
	public static void bakcopy(String userid, String id_exam) throws QmTmException {
		Connection cnn = null;
		PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO bak_exam_ans ");
		sql.append("Select * From exam_ans Where userid = ? and id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.execute();
			// ����� ����� ���
			ExamAnswerNon.bakcopy(userid, id_exam);
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� ������̺�� �̵��ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.bakcopy] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void bakrestore(String userid, String id_exam) throws QmTmException {
		Connection cnn = null;
		PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_ans ");
		sql.append("Select * From bak_exam_ans Where userid = ? and id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.execute();
			// ����� ����� ����
			ExamAnswerNon.bakrestore(userid, id_exam);
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.bakrestore] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void update(String id_exam, String userid, ExamAnswerBean bean) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("UPDATE EXAM_ANS SET ");
		sql.append("       ANSWERS = ? ");
		sql.append("WHERE (USERID = ?) AND (ID_EXAM = ?) ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());

			stm.setString(1, bean.getAnswers());
			stm.setString(2, userid);
			stm.setString(3, id_exam);

			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.update] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void updateProc(String id_exam, String userid, double scores, String proc_res) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("UPDATE EXAM_ANS SET ");
		sql.append("       SCORE = ?, SCORE_BAK = SCORE, SCORE_LOG = ? ");
		sql.append(" WHERE (USERID = ?) AND (ID_EXAM = ?) ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());

			stm.setDouble(1, scores);
			stm.setString(2, proc_res);
			stm.setString(3, userid);
			stm.setString(4, id_exam);

			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.updateProc] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void ansY(String userid, String id_exam) throws QmTmException {
		Connection cnn = null;
		PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("UPDATE EXAM_ANS ");
		sql.append("       SET yn_end = 'Y' ");
		sql.append("Where userid = ? and id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� �̿Ϸῡ�� �Ϸ� ó���ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.ansY] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void ansN(String userid, String id_exam) throws QmTmException {
		Connection cnn = null;
		PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("UPDATE EXAM_ANS ");
		sql.append("       SET yn_end = 'N' ");
		sql.append("Where userid = ? and id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� �Ϸῡ�� �̿Ϸ� ó���ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.ansN] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void delete(String userid, String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("DELETE FROM EXAM_ANS ");
		sql.append("WHERE (USERID = ?) AND (ID_EXAM = ?) ");

		try {
			// ����� ����
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.executeUpdate();
			// ����� ����� ���� 
			ExamAnswerNon.deleteForBlanks(userid, id_exam);
			// ������ ���� ä�� ��� ����
			deleteNonReport(userid, id_exam);			
			// ���νð� ������ ����
			deletePersonalTime(userid, id_exam);	
			// �����ð� ������ ����
			deleteExtendTime(userid, id_exam);			
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.delete] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void deletePersonalTime(String userid, String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Delete From personal_time ");
		sql.append("Where (userid = ?) and (id_exam = ?) ");

		try {
			// ��� ����� ����
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.executeUpdate();

		} catch (SQLException ex) {
			throw new QmTmException("���νð����� ���̺��� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.deletePersonalTime] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void deleteExtendTime(String userid, String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Delete From extend_time ");
		sql.append("Where (userid = ?) and (id_exam = ?) ");

		try {
			// ��� ����� ����
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.executeUpdate();

		} catch (SQLException ex) {
			throw new QmTmException("�����ð����� ���̺��� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.deleteExtendTime] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}	
	
	public static void deleteNonReport(String userid, String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Delete From imsi_exam_ans_result ");
		sql.append("Where (userid = ?) and (id_exam = ?) ");

		try {
			// ��� ����� ����
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.executeUpdate();
			// ����� �������� ����
			//ExamAnswerNon.bakdelete(userid, id_exam);
		} catch (SQLException ex) {
			throw new QmTmException("�ܴ���/������ ä������� ���̺��� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.bakdelete] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
	
	public static void bakdelete(String userid, String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("DELETE FROM BAK_EXAM_ANS ");
		sql.append("WHERE (USERID = ?) AND (ID_EXAM = ?) ");

		try {
			// ��� ����� ����
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.executeUpdate();
			// ����� �������� ����
			ExamAnswerNon.bakdelete(userid, id_exam);
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� ��� ���̺��� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.bakdelete] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void insertBlank(String userid, String id_exam, int setcount,
			Timestamp system_now, long limittime, String std_grade,
			String std_level) throws QmTmException {
		try {
			ExamAnswerBean bean = new ExamAnswerBean();
			bean.setUserid(userid);
			bean.setId_exam(id_exam);
			int nr_set = (int) (Math.random() * setcount) + 1;
			bean.setNr_set(nr_set);
			bean.setStart_time(system_now);
			bean.setEnd_time(system_now);
			bean.setRemain_time(limittime);
			bean.setAnswers("");
			bean.setOxs("");
			bean.setPoints("");
			insert(bean);
			ExamAnswerNon.deleteForBlanks(userid, id_exam);
			ExamAnswerNon.insertBlanks(userid, id_exam, nr_set);
		} catch (Exception ex) {
			throw new QmTmException("������ ������� ����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.insertBlank] " + ex.getMessage());
		}
	}

	public static void update_res(ExamAnswerBean bean) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("UPDATE EXAM_ANS SET ");
		sql.append("       NR_SET = ?, START_TIME = ?, END_TIME = ?, REMAIN_TIME = ?, ");
		sql.append("       YN_END = ?, ANSWERS = ?, OXS = ?, POINTS = ?, ");
		sql.append("       SCORE = ?, SCORE_BAK = -1, SCORE_LOG = '-1', YN_MARK = ? ");
		sql.append(" WHERE (USERID = ?) AND (ID_EXAM = ?) ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());

			stm.setInt(1, bean.getNr_set());
			stm.setTimestamp(2, bean.getStart_time());
			stm.setTimestamp(3, bean.getEnd_time());
			stm.setLong(4, bean.getRemain_time());
			stm.setString(5, bean.getYn_end());
			stm.setString(6, bean.getAnswers());
			stm.setString(7, bean.getOxs());
			stm.setString(8, bean.getPoints());
			stm.setDouble(9, bean.getScore());
			stm.setString(10, bean.getYn_mark());
			stm.setString(11, bean.getUserid());
			stm.setString(12, bean.getId_exam());

			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("������ ������� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.update_res] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void setScoreOxs(ExamAnswerBean bean) throws QmTmException {
		if (bean.getAnswers() == null || bean.getAnswers().length() == 0) { // ��繮���� ������� ��츦 ����Ѵ�
			ExamInfoBean info = ExamInfo.getBean(bean.getId_exam());
			String[] arrAnswer = new String[info.getQcount()]; // ������ ��������ŭ �迭����
			for (int i = 0; i < arrAnswer.length; i++) {
				arrAnswer[i] = "";
			}
			String answers = QmTm.join(arrAnswer, QmTm.Q_GUBUN); // �� ���� ��� �����ϱ� ���ؼ� ������Ȼ��̿� ������ �߰�
			bean.setAnswers(answers);
		}

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT p.nr_q, p.allotting, ");
		sql.append("       q.id_qtype, q.ca, q.yn_caorder, q.yn_case, q.yn_blank, q.id_valid_type ");
		sql.append("  FROM exam_paper2 p, q ");
		sql.append("WHERE p.id_exam = ? AND p.nr_set = ? AND p.id_q = q.id_q ");

		try {
			// �������

			String[] arrAnswer = bean.getAnswers().split(QmTm.Q_GUBUN_re, -1);
			int qcount = arrAnswer.length;
			String[] arrOX = new String[qcount];
			String[] arrPoint = new String[qcount];

			if (bean.getOxs().length() > 0) {
                arrOX = bean.getOxs().split(QmTm.Q_GUBUN_re, -1);
            } else {
                for (int i = 0; i < qcount; i++) {
                    arrOX[i] = "";
                }
            }

			if (bean.getPoints().length() > 0) {                
                arrPoint = bean.getPoints().split(QmTm.Q_GUBUN_re, -1);
            } else {
                for (int i = 0; i < qcount; i++) {
                    arrPoint[i] = "";
                }
            }

			double score = 0; //�ش� ���迡 ���ؼ� ȹ���� ����

			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getId_exam());
			stm.setInt(2, bean.getNr_set());
			rst = stm.executeQuery();

			while (rst.next()) // ������
			{
				// �ʱ�ȭ
				double pointRate = -1; // 0 = Ʋ������, 1 = ��������, 0.01~0.99 = �κ������� �������� (ynPart = Y, Qtype = 3)
				double point = 0; // ����
				String OX = ""; // X = Ʋ������, O = ��������, P = �κ������� ��������

				// from DB

				int nr_q = rst.getInt("nr_q");
				int ndx = nr_q - 1;
				double allot = rst.getDouble("allotting");
				int id_qtype = rst.getInt("id_qtype");
				int id_valid_type = rst.getInt("id_valid_type");
				String yn_caorder = rst.getString("yn_caorder");
				String yn_case = rst.getString("yn_case");
				String yn_blank = rst.getString("yn_blank");

				String ca = rst.getString("ca");
				if (ca == null) {
					ca = "";
				} else {
					ca = ca.trim();
				}

				// ä��

				String userAnswer = arrAnswer[ndx].trim(); // ������

				if (id_valid_type == 2) // 2 : ��� ���� ó��
				{
					pointRate = 1;
				} else // 0 : ������, 1 : �ٸ����⵵ ���� (�Ѵ� ����ó��)
				{
					if (arrAnswer[ndx].length() > 0) // ���� ������
					{
						if (id_qtype == 1) // OX��
						{
							if (userAnswer.equals(ca)) {
								pointRate = 1;
							} else {
								pointRate = 0;
							}
						} else if (id_qtype == 2) // ������
						{
							if (id_valid_type == 0) // ������
							{
								if (userAnswer.equals(ca)) {
									pointRate = 1;
								} else {
									pointRate = 0;
								}
							} else // 1 : �Ѵ� ����
							{
								if (ca.indexOf(userAnswer) >= 0) {
									pointRate = 1;
								} else {
									pointRate = 0;
								}
							}
						} else if (id_qtype == 3) // ��������
						{
							pointRate = scoringType3(ca, userAnswer);

							if (DBPool.PART_POINT == false) // �κ����� ���� ����
							{
								if (pointRate < 1) {
									pointRate = 0;
								}
							}
						} else if (id_qtype == 4) // �ܴ���
						{
							/*
							 ����� �κ����� ������� ����.(����ä������ �κ������� �� �� ����)
							 ����ä���� ��ä���ϸ� ����ä���� ���õǹǷ� ��Ȳ�� ����
							 ��ä���� ��󿡼� ����(��ü or Ư������) �� �� �ִ� ���� ���鵵�� ...
							*/
                            if(arrPoint[ndx].length() > 0) {
							   pointRate = -1;
						    } else {					   
	                           if (scoringAns2(ca, userAnswer, yn_caorder, yn_blank, yn_case)) {
		                           pointRate = 1;
			                   } else {
				                   pointRate = 0;
					           }
						    }

						} else // 5 : �����
						{
							pointRate = -1;
						}

					} else // ���� ������ (����� or Ǯ�� ���� ���)
					{
						if (id_qtype == 5) { // �����
							pointRate = -1;
						} else { // ������� �ƴϸ�
							pointRate = 0;
						}
					}

				} // end of id_valid_type = 0 and 1

				if (pointRate < 0) // ä����󿡼� ���ܵǴ� ���� : �����, ����ä������� �����ϴ� Ư���� ������ ���� ��
				{
					if (arrPoint[ndx].length() > 0) {
						point = Double.parseDouble(arrPoint[ndx]);
					} // ��������
					else {
						point = 0;
					}
					if (arrOX[ndx].length() > 0) {
						OX = arrOX[ndx];
					} // ���� OX
					else {
						OX = "X";
					}
				} else // pointRate : 0 ~ 1
				{
					point = Math.round(allot * pointRate * 10) / 10.0D; // �Ҽ��� �Ʒ� ���ڸ���					
					
					if (pointRate == 1) {
						OX = "O";
					} else if (pointRate == 0) {
						OX = "X";
					} else {
						OX = "P";
					}
					arrOX[ndx] = OX;
					
				}
						
				score += point; // ��������
				
			} // end of while rst.next()

			bean.setOxs(QmTm.join(arrOX, QmTm.Q_GUBUN));
			bean.setPoints(QmTm.join(arrPoint, QmTm.Q_GUBUN));
			bean.setScore(score);			
			update_res(bean);
			
		} catch (SQLException ex) {
			throw new QmTmException("������ ����� ä���� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.setScoreOxs] " + ex.getMessage());
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) { }
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	private static double scoringType3(String correctAnswer, String userAnswer) {
		/*
		 �κ������� ����� ������������ ä�� (id_qtype == 3)
		 ���ϰ� : 0 = Ʋ��(O), 1 = ����(X), 0.0001 ~ 0.9999 = �κ������� ����(P)
		 */

		if (correctAnswer.trim().length() == 0) // ������ �־����� ����
		{
			return 1.0;
		}
		if (userAnswer.trim().length() == 0) // ����� �������� ����
		{
			return 0.0;
		}
		String[] arrCA = correctAnswer.split(QmTm.OR_GUBUN_re, -1);
		String[] arrUA = userAnswer.split(QmTm.OR_GUBUN_re, -1);

		if (arrCA.length < arrUA.length) // ������� �ʰ��Ͽ� ���� ������ ��� 0 �� ó��
		{
			return 0.0;
		}

		int cnt = 0; // ���������

		for (int i = 0; i < arrCA.length; i++) {
			String ca = arrCA[i];

			for (int j = 0; j < arrUA.length; j++) {
				String ua = arrUA[j];
				if (ca.equals(ua)) {
					cnt++;
					break;
				}
			}
		}

		int caCnt = arrCA.length; // �����
		double pointRate = 1.0D * cnt / caCnt;
		return pointRate;
	}

	private static boolean scoringAns2(String correctAnswer, String userAnswer,
			String yn_caorder, String yn_blank, String yn_case) {
		// �ܴ����� ä�� (id_qtype == 4) : �κ����� ��� ����

		if (correctAnswer.trim().length() == 0) // ������ �־����� ����
		{
			return true;
		}
		if (userAnswer.trim().length() == 0) // ����� �������� ����
		{
			return false;
		}

		if (yn_blank.equalsIgnoreCase("N")) { // ���鹫�� --> ��������
			correctAnswer = correctAnswer.replaceAll(" ", "");
			userAnswer = userAnswer.replaceAll(" ", "");
		}
		if (yn_case.equalsIgnoreCase("N")) { // ��ҹ��� �������� --> �ҹ��ڷ�
			correctAnswer = correctAnswer.toLowerCase();
			userAnswer = userAnswer.toLowerCase();
		}

		String[] arrCA = correctAnswer.split(QmTm.OR_GUBUN_re, -1);
		String[] arrUA = userAnswer.split(QmTm.OR_GUBUN_re, -1);
		boolean[] arrCheck = new boolean[arrCA.length];

		if (arrCA.length != arrUA.length) { // ������� �������� Ʋ����
			return false;
		}

		if (yn_caorder.equalsIgnoreCase("Y")) // ���� ������ ��ġ�ؾ� �ϴ� ���
		{
			for (int i = 0; i < arrCA.length; i++) {
				arrCheck[i] = false;
				String[] arrSubCA = arrCA[i].split(QmTm.LIKE_GUBUN_re, -1);

				for (int j = 0; j < arrSubCA.length; j++) {
					if (arrUA[i].equals(arrSubCA[j])) {
						arrCheck[i] = true;
						break;
					}
				}
			}

			boolean retval = true;
			for (int i = 0; i < arrCheck.length; i++) {
				if (arrCheck[i] == false) {
					retval = false;
					break;
				}
			}
			return retval;
		} else { // ���� ������ �����ϴ� ���
			return compareAns2(arrCA, arrUA);
		}
	}

	private static boolean compareAns2(String[] arrCorrectAnswer,
			String[] arrUserAnswer) {
		/*
		 Dim m, n, t
		 Dim iSize
		 Dim iResult
		 Dim sTempCA
		 Dim iSum1, iSum2
		 */

		int size = arrCorrectAnswer.length;
		int[][] result = new int[size][size];

		// Initialize values with -1
		for (int i = 0; i < size; i++) {
			for (int j = 0; j < size; j++) {
				result[i][j] = -1;
			}
		}

		for (int i = 0; i < size; i++) {
			for (int j = 0; j < size; j++) {
				String[] arrTempCA = arrCorrectAnswer[j]
						.split(QmTm.LIKE_GUBUN_re);
				for (int k = 0; k < arrTempCA.length; k++) {
					if (arrUserAnswer[i].equals(arrTempCA[k])) {
						result[i][j] = j; // ����� �߰ߵ� ��ġ�� ����
						break;
					}
				}
			}
		}

		/*
		 A^B A^B C^D
		 -------------------
		 A  0   1  -1   (01)
		 C -1  -1   2   (2)
		 D -1  -1   2   (2)
		 -------------------
		 */

		for (int i = 0; i < size; i++) {
			int sum1 = 0;
			int sum2 = 0;

			for (int j = 0; j < size; j++) {
				sum1 += result[i][j];
				sum2 += result[j][i];
			}

			if (sum1 == -(size + 1) || sum2 == -(size + 1)) {
				return false;
			}
		}

		/*
		 A^B A^B C^D
		 -------------------
		 A  0   1  -1   (01)
		 C -1  -1   2   (2)
		 D -1  -1   2   (2)
		 -------------------
		 */

		String[] arrPosUA = new String[size];

		for (int i = 0; i < size; i++) {
			String tmp = "";

			for (int j = 0; j < size; j++) {
				if (result[i][j] != -1) {
					tmp += result[i][j]; // (01), (2), (2)�� ����
				}
			}
			arrPosUA[i] = tmp;
		}

		for (int i = 0; i < size; i++) {
			for (int j = 0; j < size; j++) {
				if (arrPosUA[j].length() == 1) {
					for (int k = 0; k < size; k++) {
						if (k != j) {
							arrPosUA[k] = arrPosUA[k].replaceAll(arrPosUA[j],"");
							if (arrPosUA[k].equals("")) {
								return false;
							}
						}
					}
				} else if (arrPosUA[j].length() == 0) {
					return false;
				}
			}
		}
		return true;
	}
}
