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

public class RexlabelUtil
{
    public RexlabelUtil() {
    }
	
	public static RexlabelBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "Select id_exlabel, exlabel From r_exlabel Order by id_exlabel ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();
            RexlabelBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (RexlabelBean[]) beans.toArray(new RexlabelBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("보기유형 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [RexlabelUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static RexlabelBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            RexlabelBean bean = new RexlabelBean();
            bean.setId_exlabel(rst.getInt(1));
            bean.setExlabel(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("보기유형 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [RexlabelUtil.makeBeans]");
        }
    }
}