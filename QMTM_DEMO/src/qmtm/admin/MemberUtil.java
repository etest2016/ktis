package qmtm.admin;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class MemberUtil
{
    public MemberUtil() {
    }

	public static MemberBean[] getBeans(int list_cnt, int lists, String field, String str) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		//sql.append("Select top "+list_cnt+" userid, password, name, sosok1, jikwi, jikmu, company, ");
		sql.append("Select userid, password, name, sosok1, jikwi, jikmu, company, ");
		sql.append("       convert(varchar(10), regdate, 120) regdate ");
		sql.append("From qt_userid "); 
		sql.append("Where userid not in ");
		sql.append("     (Select top "+lists+" userid ");
		sql.append("      From qt_userid ");
		sql.append("      Where user_gubun = '2' ");
		if(!str.equals("")) {
			sql.append("      and "+field+" like '%"+str+"%' ");			
		}
		sql.append("      Order by sosok1, name) ");
		sql.append("      and user_gubun = '2' ");
		if(!str.equals("")) {
			sql.append("  and "+field+" like '%"+str+"%' ");			
		}
		sql.append("Order by sosok1, name ");
		sql.append("limit "+list_cnt);

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            MemberBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (MemberBean[]) beans.toArray(new MemberBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("접수 인원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [MemberUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static MemberBean[] getAllBeans(String field, String str) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select userid, password, name, sosok1, jikwi, jikmu, company, ");
		//sql.append("       convert(varchar(10), regdate, 120) regdate ");
		sql.append("       to_char(regdate, 'YYYY-MM-DD') regdate ");
		sql.append("From qt_userid "); 
		sql.append("Where user_gubun = '2' ");
		if(!str.equals("")) {
			sql.append("  and "+field+" like '%"+str+"%' ");			
		}
		sql.append("Order by sosok1, name ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            MemberBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (MemberBean[]) beans.toArray(new MemberBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("접수 인원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [MemberUtil.getAllBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static MemberBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            MemberBean bean = new MemberBean();
			bean.setUserid(rst.getString(1));
            bean.setPassword(rst.getString(2));
			bean.setName(rst.getString(3));
			bean.setSosok1(rst.getString(4));
			bean.setJikwi(rst.getString(5));
			bean.setJikmu(rst.getString(6));
			bean.setCompany(rst.getString(7));
            bean.setRegdate(rst.getString(8));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("접수 인원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [MemberUtil.makeBeans]");
        }
    }
	
	public static void deleteMember(String id_exam, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From exam_receipt Where id_exam = ? and userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("대상자정보 삭제 중 인터넷 연결상태가 좋지 않습니다. [MemberUtil.deleteMember]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void getMCnt(String userid, MemberBean rb) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		int results = 0;

		sql = "Select count(userid) as cnt from qt_userid Where userid = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, userid);

            rst = stm.executeQuery();
            if (rst.next()) { results = rst.getInt("cnt"); }

			if(results > 0) {
				updateMember(userid, rb);
			} else {
				insertMember(userid, rb);
			}

        } catch (SQLException ex) {
            throw new QmTmException("회원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [MemberUtil.getMCnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void insertMember(String userid, MemberBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO qt_userid(userid, password, name, email, home_postcode, home_addr1, home_phone, mobile_phone, ");
		sql.append("                      sosok1, sosok2, sosok3, sosok4, jikwi, jikmu, company, regdate, user_gubun) ");
        //sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, getdate(), '2') ");
		sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), '2') ");

		try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
			stm.setString(2, bean.getPassword());
			stm.setString(3, bean.getName());
			stm.setString(4, bean.getEmail());
			stm.setString(5, bean.getHome_postcode());
			stm.setString(6, bean.getHome_addr1());
			stm.setString(7, bean.getHome_phone());
			stm.setString(8, bean.getMobile_phone());
			stm.setString(9, bean.getSosok1());
			stm.setString(10, bean.getSosok2());
			stm.setString(11, bean.getSosok3());
			stm.setString(12, bean.getSosok4());
			stm.setString(13, bean.getJikwi());
			stm.setString(14, bean.getJikmu());
			stm.setString(15, bean.getCompany());

			stm.execute();
        }
        catch (SQLException ex) {
            //throw new QmTmException("회원정보 등록 중 인터넷 연결상태가 좋지 않습니다. [MemberUtil.insertMember]");
			throw new QmTmException(ex.getMessage() + "[MemberUtil.insertMember]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateMember(String userid, MemberBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("UPDATE qt_userid SET password = ?, name = ?, email = ?, home_postcode = ?, home_addr1 = ?, home_phone = ?, ");
		//sql.append("       mobile_phone = ?, sosok1 = ?, sosok2 = ?, sosok3 = ?, sosok4 = ?, jikwi = ?, jikmu = ?, company = ?, regdate = getdate() ");
		sql.append("       mobile_phone = ?, sosok1 = ?, sosok2 = ?, sosok3 = ?, sosok4 = ?, jikwi = ?, jikmu = ?, company = ?, regdate = now() ");
		sql.append("Where userid = ? and user_gubun = '2' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getPassword());
			stm.setString(2, bean.getName());
			stm.setString(3, bean.getEmail());
			stm.setString(4, bean.getHome_postcode());
			stm.setString(5, bean.getHome_addr1());
			stm.setString(6, bean.getHome_phone());
			stm.setString(7, bean.getMobile_phone());
			stm.setString(8, bean.getSosok1());
			stm.setString(9, bean.getSosok2());
			stm.setString(10, bean.getSosok3());
			stm.setString(11, bean.getSosok4());
			stm.setString(12, bean.getJikwi());
			stm.setString(13, bean.getJikmu());
			stm.setString(14, bean.getCompany());
			stm.setString(15, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("회원정보 수정 중 인터넷 연결상태가 좋지 않습니다. [MemberUtil.updateMember]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	
	public static int getCounts(String field, String str) throws QmTmException {
		
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Select count(*) as cnts From qt_userid ");
		sql.append("Where user_gubun = '2' ");
		if(!str.equals("")) {
			sql.append("      and "+field+" like '%"+str+"%' ");			
		}

		try {
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			rst = stm.executeQuery();

			if (rst.next()) {
				return rst.getInt("cnts");
			} else {
				return 0;
			}

		} catch (SQLException ex) {
			throw new QmTmException("대상자 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [MemberUtil.getCounts]");
		} finally {
			if (rst != null)    try {   rst.close();    } catch (SQLException ex) {}
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

}