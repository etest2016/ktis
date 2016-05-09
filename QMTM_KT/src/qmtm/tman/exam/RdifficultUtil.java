package qmtm.tman.exam;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class RdifficultUtil
{
    public RdifficultUtil() {
    }
	
	public static RdifficultBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "Select id_difficulty, difficulty From r_difficulty Order by id_difficulty ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();
            RdifficultBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (RdifficultBean[]) beans.toArray(new RdifficultBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("난이도 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [RdifficultUtil.getBeans()]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static RdifficultBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            RdifficultBean bean = new RdifficultBean();
            bean.setId_difficulty(rst.getString(1));
            bean.setDifficulty(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("난이도 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [RdifficultUtil.makeBeans()]");
        }
    }
}