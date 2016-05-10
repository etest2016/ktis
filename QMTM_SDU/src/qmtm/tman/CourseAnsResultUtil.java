package qmtm.tman;

// Package Import
import qmtm.*; 

// Java API Import
import java.sql.*;
import java.util.*;

public class CourseAnsResultUtil {

    public CourseAnsResultUtil() {
    }
	
	public static CourseAnsResultBean[] getBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "";
		sql += " SELECT ";
		sql += " 	C.USERID, ";
		sql += " 	C.NAME AS USERNAME, ";
		sql += " 	C.SOSOK1, ";
		sql += " 	C.SOSOK2, ";
		sql += " 	B.SCORE AS TOTAL, ";
		sql += " SUCCESS = ";
		sql += " 	CASE  ";
		sql += " 		WHEN B.SCORE >=  A.SUCCESS_SCORE THEN '합격' ";
		sql += "		ELSE '불합격' ";
		sql += "	END, ";
		sql += " 	A.TITLE	AS EXAM_TITLE ";
		sql += " FROM EXAM_M A  ";
		sql += " 	JOIN EXAM_ANS B "; 
		sql += " 		ON A.ID_EXAM = B.ID_EXAM AND A.ID_COURSE = ? ";
		sql += " 	JOIN QT_USERID C ";
		sql += " 		ON B.USERID = C.USERID ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_course);
            rst = stm.executeQuery();
            CourseAnsResultBean bean = null;
            while (rst.next()) {
                bean = makeBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (CourseAnsResultBean[]) beans.toArray(new CourseAnsResultBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[CourseAnsResultUtil.getBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static CourseAnsResultBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
			CourseAnsResultBean bean = new CourseAnsResultBean();

            bean.setUserid(rst.getString(1));
            bean.setUsername(rst.getString(2));
            bean.setSosok1(rst.getString(3));
            bean.setSosok2(rst.getString(4));
            bean.setTotal(rst.getInt(5));
            bean.setSuccess(rst.getString(6));
            bean.setExam_title(rst.getString(7));
            
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[ChapterUtil.makeBean]" + ex.getMessage());
        }
    }
}
