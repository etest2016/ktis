package qmtm;

import java.sql.*;
import java.util.*;

public class ExcelExport
{
    public ExcelExport() {
    }

	public static ExcelExportBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select c.lecture_kor_name, a.q, replace(b.ex1,'-','') as ex1, replace(b.ex2,'-','') as ex2, replace(b.ex3,'-','') as ex3, "); 
		sql.append("       replace(b.ex4,'-','') as ex4,replace(b.ex5,'-','') as ex5, ca ");
		sql.append("from temp_q a, temp_q_ex b, t_lecture c ");
		sql.append("where a.id_q = b.id_q and a.userid = '98026' and a.id_subject = c.lecture_id " );
		sql.append("order by lecture_kor_name ");
		
		try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());

            ExcelExportBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExcelExportBean[]) beans.toArray(new ExcelExportBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[ExcelExport.geBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExcelExportBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExcelExportBean bean = new ExcelExportBean();
            bean.setLecture_name(rst.getString(1));
            bean.setQ(rst.getString(2));
            bean.setEx1(rst.getString(3));
			bean.setEx2(rst.getString(4));
			bean.setEx3(rst.getString(5));
			bean.setEx4(rst.getString(6));
			bean.setEx5(rst.getString(7));
			bean.setCa(rst.getString(8));
			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[ExcelExport.makeBeans]" + ex.getMessage());
        }
    }

	
}