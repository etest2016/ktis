package qmtm.qman.question;

// Package Import
import qmtm.*; 

// Java API Import
import java.sql.*;
import java.util.*;

public class QSearch2
{
    public QSearch2() {
    }
	
	// ���� �˻���� ������ ����
	public static QSearchListBean[] getSearchBeans(QSearchBean bean, String userid, String term_id) throws QmTmException
    {
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_subject, a.id_q, a.q, c.q_subject, d.chapter, e.qtype, f.difficulty, b.make_cnt ");
		sql.append("From q a, make_q b, q_subject c, q_chapter d, r_qtype e, r_difficulty f ");
		sql.append("Where a.id_q = b.id_q and a.id_subject = c.id_q_subject and c.id_q_subject = d.id_q_subject ");
		sql.append("      and a.id_subject = d.id_q_subject and a.id_qtype = e.id_qtype and a.id_difficulty1 = f.id_difficulty ");
		
		// �������� ���� �˻�
		if(bean.getQtes().equals("Y")) {
			sql.append("and a.id_qtype = ? ");
        }

		// ���̵� ���� �˻�
		if(bean.getDiffs().equals("Y")) {
			sql.append("and a.id_difficulty1 = ? ");
        }

        // ���� ����Ƚ�� ���� �˻�
		if(bean.getCnts().equals("Y")) {
			if(!bean.getCnt1().equals("")) {
				sql.append("and b.make_cnt >= ? ");
			}
			if(!bean.getCnt2().equals("")) {
				sql.append("and b.make_cnt <= ? ");
			}
        }
		
		// �����ڵ� ���� �˻�
		if(bean.getId_qs().equals("Y")) {
			sql.append("and a.id_q = ? ");
        }

		// �������� ���� �˻�
		if(bean.getIncorrects().equals("Y")) {
			sql.append("and a.id_valid_type = ? ");
        }
		
		// ������ ���� �˻�
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%'+?+'%' ");
        }

		sql.append("Order by c.q_subject, d.chapter, e.qtype, f.difficulty ");

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());

			int i = 0;

			// �������� ���� �˻�
			if(bean.getQtes().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getQtypes());
			}

			// ���̵� ���� �˻�
			if(bean.getDiffs().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getDifficultys());
			}

			// ���� ����Ƚ�� ���� �˻�
			if(bean.getCnts().equals("Y")) {
				if(!bean.getCnt1().equals("")) {
					i = i + 1;
					stm.setString(i, bean.getCnt1());
				}
				if(!bean.getCnt2().equals("")) {
					i = i + 1;
					stm.setString(i, bean.getCnt2());
				}
			}
			
			// �����ڵ� ���� �˻�
			if(bean.getId_qs().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getId_qs1());
			}

			// �������� ���� �˻�
			if(bean.getIncorrects().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getIncorrect1());
			}
			
			// ������ ���� �˻�
			if(bean.getQs().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getQs1());
			}

			rst = stm.executeQuery();

			QSearchListBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (QSearchListBean[]) beans.toArray(new QSearchListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("�����˻� ������ �������� �� ������ �߻��߽��ϴ�. [QSearch2.getSearchBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QSearchListBean makeSearchBeans (ResultSet rst) throws QmTmException
    {
		try {
            QSearchListBean bean = new QSearchListBean();

            bean.setId_subject(rst.getString(1));
			bean.setId_qs(rst.getString(2));
			bean.setQqs(rst.getString(3));
			bean.setSubject(rst.getString(4));
			bean.setChapter(rst.getString(5));			
			bean.setQtypes(rst.getString(6));
			bean.setDifficulty(rst.getString(7));
			bean.setMake_cnt(rst.getInt(8));			
            return bean;

        } catch (SQLException ex) {
            throw new QmTmException("�����˻� ������ �������� �� ������ �߻��߽��ϴ�. [QSearch2.makeSearchBeans] " + ex.getMessage());
        }
    }
	
}