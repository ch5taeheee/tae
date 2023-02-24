package kr.or.ddit.comm.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.util.MyBatisUtil;

public class MybatisDAO {
	
	public <T> T selectOne(String statement) {
		SqlSession sqlSession = MyBatisUtil.getInstance();
		
	}
	public <T> T selectOne(String statement, Object parameter) {
		
	}
	public <T> List <T> selectList (String statement) {
		
	}
	public List <T> selectList (String statement, Object parameter) {
		
	}
	

}
