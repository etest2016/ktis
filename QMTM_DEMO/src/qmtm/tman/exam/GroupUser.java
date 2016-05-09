package qmtm.tman.exam;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

//Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

public class GroupUser {
	
	public GroupUser() {
		
	}

	public static GroupUserBean[] getBeans(String pvalue, String ptype) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select sabun, user_name, dept_id, dept_name ");
		sql.append("From tif_user ");
		
		if (ptype == "name") {
			sql.append("Where dept_name like ?% ");
		} else {
			sql.append("Where dept_id = ? ");
		}
		
		sql.append("Order by user_name ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, pvalue);
            rst = stm.executeQuery();
            GroupUserBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (GroupUserBean[]) beans.toArray(new GroupUserBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("조직 회원 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupUserBean.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
		
	}

    private static GroupUserBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
			GroupUserBean bean = new GroupUserBean();
			bean.setSabun(rst.getString(1));
			bean.setUser_name(rst.getString(2));
			bean.setDept_id(rst.getString(3));
			bean.setDept_name(rst.getString(4));
            
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("조직 회원 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupUserBean.makeBeans]");
        }
    }
	
	
}
