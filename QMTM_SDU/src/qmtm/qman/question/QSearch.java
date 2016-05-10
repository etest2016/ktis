package qmtm.qman.question;

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

public class QSearch
{
    public QSearch() {
    }	

	// ���� �˻���� ������ ����
	public static int getCnt(QSearchBean bean, String id_course, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(a.id_q) as cnt ");
		sql.append("From q as a inner join  r_difficulty as b on a.id_difficulty1 = b.id_difficulty ");
		sql.append("     inner join make_q as c on a.id_q = c.id_q ");		
		sql.append("Where a.id_subject in "); 
		sql.append("      (Select id_q_subject From q_subject Where id_course = ?) "); 
		
		// ���� ���� �˻�
		if(!bean.getSubjects().equals("")) {
			sql.append("and a.id_subject = ? ");
        }

		// ��� ���� �˻�
		if(!bean.getCpt1().equals("")) {
			sql.append("and a.id_chapter = ? ");
        }
				
		// �������� ���� �˻�
		if(!bean.getQtypes().equals("")) {
			sql.append("and a.id_qtype = ? ");
        }

		// ���̵� ���� �˻�
		if(!bean.getDifficultys().equals("")) {
			sql.append("and a.id_difficulty1 = ? ");
        }

        // ���� ����Ƚ�� ���� �˻�
		if(!bean.getCnt1().equals("")) {
			sql.append("and c.make_cnt >= ? ");
        }

		// ���� ����Ƚ�� ���� �˻�
		if(!bean.getCnt2().equals("")) {
			sql.append("and c.make_cnt <= ? ");
        }

		// �����ڵ� ���� �˻�
		if(!bean.getId_qs1().equals("")) {
			sql.append("and a.id_q = ? ");
        }

		// �������� ���� �˻�
		if(!bean.getIncorrect1().equals("")) {
			sql.append("and a.id_valid_type = ? ");
        } else {
			sql.append("and a.id_valid_type = 0 ");
		}
		
		// �����ڵ� ���� �˻�
		if(!bean.getSrc_pub_comps().equals("")) {
			sql.append("and a.src_pub_comp = ? ");
        }

		// ����� ���� �˻�
		if(!bean.getCorrect_pcts().equals("")) {
			if(bean.getGubuns().equals("plus")) {
				sql.append("and a.correct_pct >= ? ");
			} else {
				sql.append("and a.correct_pct <= ? ");
			}
        }

		// ������ ���� �˻�
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%'+?+'%' ");
        }

		// �����뵵 ���� �˻�
		if(!bean.getQuse1().equals("")) {
			sql.append("and a.id_q_use = ? ");
        }

		// �����ؼ� ���� �˻�
		if(!bean.getExplain1().equals("")) {
			sql.append("and a.explain '%'+?+'%' ");
        }
		
		// �˻�Ű���� ���� �˻�
		if(!bean.getFind_kwd1().equals("")) {
			sql.append("and a.find_kwd '%'+?+'%' ");
        }

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			int i = 0;
			i = i + 1;
			stm.setString(i, id_course);
			// ���� ���� �˻�
			if(!bean.getSubjects().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getId_subject());
			}

			// ��� ���� �˻�
			if(!bean.getCpt1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getChapter1());
			}
						
			// �������� ���� �˻�
			if(!bean.getQtypes().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getQtypes());
			}

			// ���̵� ���� �˻�
			if(!bean.getDifficultys().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getDifficultys());
			}

			// ���� ����Ƚ�� ���� �˻�
			if(!bean.getCnt1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getCnt1());
			}

			// ���� ����Ƚ�� ���� �˻�
			if(!bean.getCnt2().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getCnt2());
			}

			// �����ڵ� ���� �˻�
			if(!bean.getId_qs1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getId_qs1());
			}

			// �������� ���� �˻�
			if(!bean.getIncorrect1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getIncorrect1());
			}
			
			// �����ڵ� ���� �˻�
			if(!bean.getSrc_pub_comps().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getSrc_pub_comp1());
			}

			// ����� ���� �˻�
			if(!bean.getCorrect_pcts().equals("")) {
				if(bean.getGubuns().equals("plus")) {
					i = i + 1;
					stm.setString(i, bean.getCorrect_pct1());
				} else {
					i = i + 1;
					stm.setString(i, bean.getCorrect_pct1());
				}
			}

			// ������ ���� �˻�
			if(bean.getQs().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getQs1());
			} 

			// �����뵵 ���� �˻�
			if(bean.getQuses().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getQuse1());
			} 

			// �����ؼ� ���� �˻�
			if(bean.getExplains().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getExplain1());
			} 

			// �˻�Ű���� ���� �˻�
			if(bean.getFind_kwds().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getFind_kwd1());
			} 

			rst = stm.executeQuery();

			if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        }
        catch (SQLException ex) {
            throw new QmTmException(ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static QSearchGridBean[] getSearchBeans(QSearchBean bean, String id_course, String userid, int posStart, int count) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();

		sql.append("Select RowNum, id_q, ca, id_qtype, case when id_qtype = 1 then 'OX��' when id_qtype = 2 then '������' when id_qtype = 3 then '���������' ");
		sql.append("       when id_qtype = 4 then '�ܴ���' when id_qtype = 5 then '�����' end qtype, excount, cacount, difficulty, ");
		sql.append("       convert(varchar(10), regdate, 120) regdate, correct_pct, make_cnt, id_subject, id_chapter, q ");
		sql.append("From ( ");
		sql.append("Select a.id_q, a.ca, a.id_qtype, case when a.id_qtype = 1 then 'OX��' when a.id_qtype = 2 then '������' when a.id_qtype = 3 then '���������' ");
		sql.append("       when a.id_qtype = 4 then '�ܴ���'  when a.id_qtype = 5 then '�����' end qtype, a.excount, a.cacount, b.difficulty, ");
		sql.append("       convert(varchar(10), a.regdate, 120) regdate, a.correct_pct, c.make_cnt, a.id_subject, a.id_chapter, a.q, ");
		sql.append("	   ROW_NUMBER() OVER (ORDER BY a.id_q) AS RowNum ");
		sql.append("From q as a inner join  r_difficulty as b on a.id_difficulty1 = b.id_difficulty ");
		sql.append("     inner join make_q as c on a.id_q = c.id_q ");		
		sql.append("Where a.id_subject in "); 
		sql.append("      (Select id_q_subject From q_subject Where id_course = ?) "); 
		
		// ���� ���� �˻�
		if(!bean.getSubjects().equals("")) {
			sql.append("and a.id_subject = ? ");
        }

		// ��� ���� �˻�
		if(!bean.getCpt1().equals("")) {
			sql.append("and a.id_chapter = ? ");
        }
				
		// �������� ���� �˻�
		if(!bean.getQtypes().equals("")) {
			sql.append("and a.id_qtype = ? ");
        }

		// ���̵� ���� �˻�
		if(!bean.getDifficultys().equals("")) {
			sql.append("and a.id_difficulty1 = ? ");
        }

        // ���� ����Ƚ�� ���� �˻�
		if(!bean.getCnt1().equals("")) {
			sql.append("and c.make_cnt >= ? ");
        }

		// ���� ����Ƚ�� ���� �˻�
		if(!bean.getCnt2().equals("")) {
			sql.append("and c.make_cnt <= ? ");
        }

		// �����ڵ� ���� �˻�
		if(!bean.getId_qs1().equals("")) {
			sql.append("and a.id_q = ? ");
        }

		// �������� ���� �˻�
		if(!bean.getIncorrect1().equals("")) {
			sql.append("and a.id_valid_type = ? ");
        } else {
			sql.append("and a.id_valid_type = 0 ");
		}
		
		// �����ڵ� ���� �˻�
		if(!bean.getSrc_pub_comps().equals("")) {
			sql.append("and a.src_pub_comp = ? ");
        }			

		// ����� ���� �˻�
		if(!bean.getCorrect_pcts().equals("")) {
			if(bean.getGubuns().equals("plus")) {
				sql.append("and a.correct_pct >= ? ");
			} else {
				sql.append("and a.correct_pct <= ? ");
			}
        }

		// ������ ���� �˻�
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%'+?+'%' ");
        } 

		// �����뵵 ���� �˻�
		if(!bean.getQuse1().equals("")) {
			sql.append("and a.id_q_use = ? ");
        }

		// �����ؼ� ���� �˻�
		if(!bean.getExplain1().equals("")) {
			sql.append("and a.explain '%'+?+'%' ");
        }
		
		// �˻�Ű���� ���� �˻�
		if(!bean.getFind_kwd1().equals("")) {
			sql.append("and a.find_kwd '%'+?+'%' ");
        }

		sql.append("     ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");

		sql.append("Order by id_q desc ");

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			int i = 0;
			i = i + 1;
			stm.setString(i, id_course);
			// ���� ���� �˻�
			if(!bean.getSubjects().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getId_subject());
			}

			// ��� ���� �˻�
			if(!bean.getCpt1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getChapter1());
			}
						
			// �������� ���� �˻�
			if(!bean.getQtypes().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getQtypes());
			}

			// ���̵� ���� �˻�
			if(!bean.getDifficultys().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getDifficultys());
			}

			// ���� ����Ƚ�� ���� �˻�
			if(!bean.getCnt1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getCnt1());
			}

			// ���� ����Ƚ�� ���� �˻�
			if(!bean.getCnt2().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getCnt2());
			}

			// �����ڵ� ���� �˻�
			if(!bean.getId_qs1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getId_qs1());
			}

			// �������� ���� �˻�
			if(!bean.getIncorrect1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getIncorrect1());
			}
			
			// �����ڵ� ���� �˻�
			if(!bean.getSrc_pub_comps().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getSrc_pub_comp1());
			}

			// ����� ���� �˻�
			if(!bean.getCorrect_pcts().equals("")) {
				if(bean.getGubuns().equals("plus")) {
					i = i + 1;
					stm.setString(i, bean.getCorrect_pct1());
				} else {
					i = i + 1;
					stm.setString(i, bean.getCorrect_pct1());
				}
			}

			// ������ ���� �˻�
			if(bean.getQs().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getQs1());
			} 

			// �����뵵 ���� �˻�
			if(bean.getQuses().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getQuse1());
			} 

			// �����ؼ� ���� �˻�
			if(bean.getExplains().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getExplain1());
			} 

			// �˻�Ű���� ���� �˻�
			if(bean.getFind_kwds().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getFind_kwd1());
			} 

			i = i + 1;
			stm.setInt(i, posStart);

			i = i + 1;
			stm.setInt(i, posStart);

			i = i + 1;
			stm.setInt(i, count);

			rst = stm.executeQuery();

			QSearchGridBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (QSearchGridBean[]) beans.toArray(new QSearchGridBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException(ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
		
	// �ܿ��� ���� �˻���� ������ ����
	public static int getCnt(QSearchBean bean, String id_subject, String id_chapter, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select count(a.id_q) as cnt ");
		sql.append("From q as a inner join  r_difficulty as b on a.id_difficulty1 = b.id_difficulty ");
		sql.append("     inner join make_q as c on a.id_q = c.id_q ");		
		sql.append("Where a.id_subject = ? and a.id_chapter = ? and a.id_difficulty1 = b.id_difficulty and a.id_q = c.id_q "); 
		
		// �������� ���� �˻�
		if(!bean.getQtypes().equals("")) {
			sql.append("and a.id_qtype = ? ");
        }

		// ���̵� ���� �˻�
		if(!bean.getDifficultys().equals("")) {
			sql.append("and a.id_difficulty1 = ? ");
        }

        // ���� ����Ƚ�� ���� �˻�
		if(!bean.getCnt1().equals("")) {
			sql.append("and c.make_cnt >= ? ");
        }

		// ���� ����Ƚ�� ���� �˻�
		if(!bean.getCnt2().equals("")) {
			sql.append("and c.make_cnt <= ? ");
        }

		// �����ڵ� ���� �˻�
		if(!bean.getId_qs1().equals("")) {
			sql.append("and a.id_q = ? ");
        }

		// �������� ���� �˻�
		if(!bean.getIncorrect1().equals("")) {
			sql.append("and a.id_valid_type = ? ");
        } else {
			sql.append("and a.id_valid_type = 0 ");
		}
		
		// �����ڵ� ���� �˻�
		if(!bean.getSrc_pub_comps().equals("")) {
			sql.append("and a.src_pub_comp = ? ");
        }

		// ����� ���� �˻�
		if(!bean.getCorrect_pcts().equals("")) {
			if(bean.getGubuns().equals("plus")) {
				sql.append("and a.correct_pct >= ? ");
			} else {
				sql.append("and a.correct_pct <= ? ");
			}
        }

		// ������ ���� �˻�
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%'+?+'%' ");
        } 

		// �����뵵 ���� �˻�
		if(!bean.getQuse1().equals("")) {
			sql.append("and a.id_q_use = ? ");
        }

		// �����ؼ� ���� �˻�
		if(!bean.getExplain1().equals("")) {
			sql.append("and a.explain '%'+?+'%' ");
        }
		
		// �˻�Ű���� ���� �˻�
		if(!bean.getFind_kwd1().equals("")) {
			sql.append("and a.find_kwd '%'+?+'%' ");
        }

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);
			stm.setString(2, id_chapter);
			int i = 2;
						
			// �������� ���� �˻�
			if(!bean.getQtypes().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getQtypes());
			}

			// ���̵� ���� �˻�
			if(!bean.getDifficultys().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getDifficultys());
			}

			// ���� ����Ƚ�� ���� �˻�
			if(!bean.getCnt1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getCnt1());
			}

			// ���� ����Ƚ�� ���� �˻�
			if(!bean.getCnt2().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getCnt2());
			}

			// �����ڵ� ���� �˻�
			if(!bean.getId_qs1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getId_qs1());
			}

			// �������� ���� �˻�
			if(!bean.getIncorrect1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getIncorrect1());
			} 

			// �����ڵ� ���� �˻�
			if(!bean.getSrc_pub_comps().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getSrc_pub_comp1());
			}

			// ����� ���� �˻�
			if(!bean.getCorrect_pcts().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getCorrect_pct1());
			}

			// ������ ���� �˻�
			if(bean.getQs().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getQs1());
			} 

			// �����뵵 ���� �˻�
			if(bean.getQuses().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getQuse1());
			} 

			// �����ؼ� ���� �˻�
			if(bean.getExplains().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getExplain1());
			} 

			// �˻�Ű���� ���� �˻�
			if(bean.getFind_kwds().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getFind_kwd1());
			} 

			rst = stm.executeQuery();

			if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        }
        catch (SQLException ex) {
            throw new QmTmException(ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static QSearchGridBean[] getSearchBeans(QSearchBean bean, String id_subject, String id_chapter, String userid, int posStart, int count) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select RowNum, id_q, ca, id_qtype, case when id_qtype = 1 then 'OX��' when id_qtype = 2 then '������' when id_qtype = 3 then '���������' ");
		sql.append("       when id_qtype = 4 then '�ܴ���' when id_qtype = 5 then '�����' end qtype, excount, cacount, difficulty, ");
		sql.append("       convert(varchar(10), regdate, 120) regdate, correct_pct, make_cnt, id_subject, id_chapter, q ");
		sql.append("From ( ");
		sql.append("Select a.id_q, a.ca, a.id_qtype, case when a.id_qtype = 1 then 'OX��' when a.id_qtype = 2 then '������' when a.id_qtype = 3 then '���������' ");
		sql.append("       when a.id_qtype = 4 then '�ܴ���'  when a.id_qtype = 5 then '�����' end qtype, a.excount, a.cacount, b.difficulty, ");
		sql.append("       convert(varchar(10), a.regdate, 120) regdate, a.correct_pct, c.make_cnt, a.id_subject, a.id_chapter, a.q, ");
		sql.append("	   ROW_NUMBER() OVER (ORDER BY a.id_q) AS RowNum ");
		sql.append("From q as a inner join  r_difficulty as b on a.id_difficulty1 = b.id_difficulty ");
		sql.append("     inner join make_q as c on a.id_q = c.id_q ");
		sql.append("Where a.id_subject = ? and a.id_chapter = ? and a.id_difficulty1 = b.id_difficulty and a.id_q = c.id_q "); 
						
		// �������� ���� �˻�
		if(!bean.getQtypes().equals("")) {
			sql.append("and a.id_qtype = ? ");
        }

		// ���̵� ���� �˻�
		if(!bean.getDifficultys().equals("")) {
			sql.append("and a.id_difficulty1 = ? ");
        }

        // ���� ����Ƚ�� ���� �˻�
		if(!bean.getCnt1().equals("")) {
			sql.append("and c.make_cnt >= ? ");
        }

		// ���� ����Ƚ�� ���� �˻�
		if(!bean.getCnt2().equals("")) {
			sql.append("and c.make_cnt <= ? ");
        }

		// �����ڵ� ���� �˻�
		if(!bean.getId_qs1().equals("")) {
			sql.append("and a.id_q = ? ");
        }

		// �������� ���� �˻�
		if(!bean.getIncorrect1().equals("")) {
			sql.append("and a.id_valid_type = ? ");
        } else {
			sql.append("and a.id_valid_type = 0 ");
		}
		
		// �����ڵ� ���� �˻�
		if(!bean.getSrc_pub_comps().equals("")) {
			sql.append("and a.src_pub_comp = ? ");
        }

		// ����� ���� �˻�
		if(!bean.getCorrect_pcts().equals("")) {
			if(bean.getGubuns().equals("plus")) {
				sql.append("and a.correct_pct >= ? ");
			} else {
				sql.append("and a.correct_pct <= ? ");
			}
        }

		// ������ ���� �˻�
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%'+?+'%' ");
        }
		
		// �����뵵 ���� �˻�
		if(!bean.getQuse1().equals("")) {
			sql.append("and a.id_q_use = ? ");
        }

		// �����ؼ� ���� �˻�
		if(!bean.getExplain1().equals("")) {
			sql.append("and a.explain '%'+?+'%' ");
        }
		
		// �˻�Ű���� ���� �˻�
		if(!bean.getFind_kwd1().equals("")) {
			sql.append("and a.find_kwd '%'+?+'%' ");
        }

		sql.append("     ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");

		sql.append("Order by id_q desc ");

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);
			stm.setString(2, id_chapter);
			int i = 2;
						
			// �������� ���� �˻�
			if(!bean.getQtypes().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getQtypes());
			}

			// ���̵� ���� �˻�
			if(!bean.getDifficultys().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getDifficultys());
			}

			// ���� ����Ƚ�� ���� �˻�
			if(!bean.getCnt1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getCnt1());
			}

			// ���� ����Ƚ�� ���� �˻�
			if(!bean.getCnt2().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getCnt2());
			}

			// �����ڵ� ���� �˻�
			if(!bean.getId_qs1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getId_qs1());
			}

			// �������� ���� �˻�
			if(!bean.getIncorrect1().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getIncorrect1());
			} 
			
			// �����ڵ� ���� �˻�
			if(!bean.getSrc_pub_comps().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getSrc_pub_comp1());
			}

			// ����� ���� �˻�
			if(!bean.getCorrect_pcts().equals("")) {
				i = i + 1;
				stm.setString(i, bean.getCorrect_pct1());
			}

			// ������ ���� �˻�
			if(bean.getQs().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getQs1());
			} 

			// �����뵵 ���� �˻�
			if(bean.getQuses().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getQuse1());
			} 

			// �����ؼ� ���� �˻�
			if(bean.getExplains().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getExplain1());
			} 

			// �˻�Ű���� ���� �˻�
			if(bean.getFind_kwds().equals("Y")) {
				i = i + 1;
				stm.setString(i, bean.getFind_kwd1());
			} 

			i = i + 1;
			stm.setInt(i, posStart);

			i = i + 1;
			stm.setInt(i, posStart);

			i = i + 1;
			stm.setInt(i, count);

			rst = stm.executeQuery();

			QSearchGridBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (QSearchGridBean[]) beans.toArray(new QSearchGridBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException(ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QSearchGridBean makeSearchBeans (ResultSet rst) throws QmTmException
    {
		try {
            QSearchGridBean bean = new QSearchGridBean();

            bean.setRownum(rst.getString(1));
			bean.setId_q(rst.getString(2));
            bean.setCa(rst.getString(3));
			bean.setId_qtype(rst.getString(4));
			bean.setQtype(rst.getString(5));
			bean.setExcount(rst.getString(6));
			bean.setCacount(rst.getString(7));
			bean.setDifficulty(rst.getString(8));
			bean.setRegdate(rst.getString(9));			
			bean.setCorrect_pct(rst.getString(10));			
			bean.setCnt(rst.getString(11));
			bean.setId_subject(rst.getString(12));
			bean.setId_chapter(rst.getString(13));
			bean.setQ(rst.getString(14));
            return bean;

        } catch (SQLException ex) {
            throw new QmTmException("�����˻� �۾� �� ������ �߻��Ǿ����ϴ�. [QSearch.makeSearchBeans()] " + ex.getMessage());
        }
    }
}