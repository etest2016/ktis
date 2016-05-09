package etest.paper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import qmtm.DBPool;
import qmtm.QmTmException;

public class User_PaperList
{
    public User_PaperList() {}

    public static User_PaperListBean[] getBeans(String id_exam, int nr_set) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_q, isnull(b.front_msg,' ') front_msg, isnull(b.back_msg, ' ') back_msg, isnull(b.box_size, '20') box_size ");
        sql.append("FROM exam_paper2 a left outer join q_msg b on a.id_q = b.id_q ");
        sql.append("WHERE a.id_exam = ? and a.nr_set = ? ");
        sql.append("ORDER BY a.nr_q, b.seq "); 

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setInt(2, nr_set);            
            rst = stm.executeQuery();
            User_PaperListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (User_PaperListBean[]) beans.toArray(new User_PaperListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("단답형문항 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_PaperList.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static User_PaperListBean makeBeans (ResultSet rst) throws QmTmException
    {
        try {			
            User_PaperListBean bean = new User_PaperListBean();
            bean.setId_q(rst.getInt(1));
            bean.setFront_msg(rst.getString(2));
            bean.setBack_msg(rst.getString(3));
            bean.setBox_size(rst.getString(4));
			return bean;
        } catch (SQLException ex) {
            throw new QmTmException("단답형문항 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_PaperList.makeBeans]");
        }
    }
}
