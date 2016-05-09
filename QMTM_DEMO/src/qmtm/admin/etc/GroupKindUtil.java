package qmtm.admin.etc;

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

public class GroupKindUtil
{
    public GroupKindUtil() {
    }
	
	public static void insert(GroupKindBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO c_category (id_category, category, regdate) ");
        sql.append("VALUES (?, ?, now()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_category());
            stm.setString(2, bean.getCategory());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 등록하는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(GroupKindBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE c_category SET category = ? ");
        sql.append("Where id_category = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getCategory());
			stm.setString(2, bean.getId_category());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 수정하는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM c_category Where id_category = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_category);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static GroupKindBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		//sql = "SELECT id_category, category, Convert(varchar(10),regdate,120) FROM c_category order by regdate desc ";
		sql = "SELECT id_category, category, to_char(regdate,'YYYY-MM-DD') FROM c_category order by regdate desc ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();
            GroupKindBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (GroupKindBean[]) beans.toArray(new GroupKindBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static GroupKindBean[] getBeans2() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		//sql = "SELECT id_category, category, Convert(varchar(10),regdate,120) FROM c_category order by regdate ";
        sql = "SELECT id_category, category, to_char(regdate,'YYYY-MM-DD') FROM c_category order by regdate ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();
            GroupKindBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (GroupKindBean[]) beans.toArray(new GroupKindBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.getBeans2]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static GroupKindBean[] getBeans2(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		//sql.append("SELECT a.id_category, a.category, Convert(varchar(10),a.regdate,120) ");
		sql.append("SELECT a.id_category, a.category, to_char(a.regdate, 'YYYY-MM-DD') ");
		sql.append("FROM c_category a, q_worker_subj b, q_subject c ");
		sql.append("Where b.userid = ? and a.id_category = c.id_category and b.id_subject = c.id_q_subject ");
		sql.append("Order by a.regdate ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
            rst = stm.executeQuery();
            GroupKindBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (GroupKindBean[]) beans.toArray(new GroupKindBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.getBeans2]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static GroupKindBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            GroupKindBean bean = new GroupKindBean();
            bean.setId_category(rst.getString(1));
            bean.setCategory(rst.getString(2));
            bean.setRegdate(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.makeBeans]");
        }
    }

	public static GroupKindBean getBean(String id_category) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "SELECT category, regdate FROM c_category WHERE id_category = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_category);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("카테고리구분 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static GroupKindBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            GroupKindBean bean = new GroupKindBean();
            bean.setCategory(rst.getString(1));
            bean.setRegdate(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.makeBean]");
        }
    }

	public static GroupKindBean getBean2(String id_course) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_category, a.category, b.course ");
		sql.append("FROM c_category a, c_course b ");
		sql.append("WHERE b.id_course = ? and a.id_category = b.id_category ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean2(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("카테고리구분 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static GroupKindBean makeBean2 (ResultSet rst) throws QmTmException
    {
		
		try {
            GroupKindBean bean = new GroupKindBean();
			bean.setId_category(rst.getString(1));
            bean.setCategory(rst.getString(2));
            bean.setCourse(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.makeBean]");
        }
    }


	public static String getId_category(String id_course) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select id_category From c_course Where id_course = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_course);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("id_category"); }
            else { return ""; }
        } catch (SQLException ex) {
            throw new QmTmException("분류코드 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [GroupKindUtil.getId_category]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
}