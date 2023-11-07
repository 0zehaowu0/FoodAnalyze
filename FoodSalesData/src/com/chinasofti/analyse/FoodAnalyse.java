package com.chinasofti.analyse;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class FoodAnalyse {
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://192.168.40.128:3306/food?useSSL=false&serverTimezone=UTC";
	static final String USERNAME = "root";
	static final String PASSWORD = "root";
	private static Connection connection = null;
	private static Statement statement = null;
	private static ResultSet resultSet = null;

	/**
	 * ��ʼ�������ݿ�
	 */
	public static void startConn() {
		try {
			// �������ݿ��һ������������
			Class.forName(JDBC_DRIVER);
			// �������ݿ�ڶ������������ݿ⣬��ȡconnection����
			connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * �ر��������ݿⷽ��
	 */
	public static void closeConn() {
		try {
			if (resultSet != null) {
				resultSet.close();
				resultSet = null;
			}
			if (statement != null) {
				statement.close();
				statement = null;
			}
			if (connection != null) {
				connection.close();
				connection = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static ArrayList<String[]> outletLType() {
		ArrayList<String[]> list = new ArrayList<>();
		try {
			startConn();
			// ������������statement��������ִ��SQL���
			statement = connection.createStatement();
			String sql = "select Outlet_Location_Type,count(*) num from fd_log group by Outlet_Location_Type desc";
			// ���Ĳ���ִ��SQL���
			resultSet = statement.executeQuery(sql);
			// ���岽��ѭ���������������󣬽�������󱣴浽list������
			while (resultSet.next()) {
				String action = resultSet.getString("Outlet_Location_Type");
				String num = resultSet.getString("num");
				String[] arr = { action, num };
				list.add(arr);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// ���������ر���
			closeConn();
		}
		return list;
	}
	public static ArrayList<String[]> ItemTypeSalesComparison() {
		ArrayList<String[]> list = new ArrayList<>();
		try {
			startConn();
			// ������������statement��������ִ��SQL���
			statement = connection.createStatement();
			String sql = "select Item_Type,avg(Item_Outlet_Sales) as Avg_Sales from fd_log group by Item_Type order by Avg_Sales";
			// ���Ĳ���ִ��SQL���
			resultSet = statement.executeQuery(sql);
			// ���岽��ѭ���������������󣬽�������󱣴浽list������
			while (resultSet.next()) {
				String Item_Type = resultSet.getString("Item_Type");
				String Avg_Sales = resultSet.getString("Avg_Sales");
				String[] arr = { Item_Type, Avg_Sales };
				list.add(arr);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// ���������ر���
			closeConn();
		}
		return list;
	}
	public static ArrayList<String[]> ageRank(){
		ArrayList<String[]> list=new ArrayList<>();
		try {
			startConn();
			statement=connection.createStatement();
			resultSet=statement.executeQuery(
					"select Outlet_Establishment_Year,count(*) num from fd_log group by Outlet_Establishment_Year order by count(*) desc limit 10");
			while (resultSet.next()) {
				String[] arr={resultSet.getString("Outlet_Establishment_Year"),resultSet.getString("num")};
				list.add(arr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConn();
		}
		return list;
	}

	public static ArrayList<String[]> numcount(){
		ArrayList<String[]> list=new ArrayList<>();
		try {
			startConn();
			statement=connection.createStatement();
			resultSet=statement.executeQuery(
"select Item_Type,count(*) num from fd_log group by Item_Type desc limit 17");
			while (resultSet.next()) {
				String[] arr={resultSet.getString("Item_Type")
						
						,resultSet.getString("num")};
				list.add(arr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConn();
		}
		return list;
	}

	public static ArrayList<String[]> maxminvalue(){
		ArrayList<String[]> list=new ArrayList<>();
		try {
			startConn();
			
			statement=connection.createStatement();
			String sql="SELECT Item_Type, MAX(CAST(Item_MRP AS DECIMAL(6, 2))) AS Max_Value,MIN(CAST(Item_MRP AS DECIMAL(6, 2))) AS MIN_Value FROM fd_log GROUP BY Item_Type;";
				resultSet=statement.executeQuery(sql);
			while (resultSet.next()) {
				String[] arr={resultSet.getString("Item_Type"),resultSet.getString("Max_Value"),resultSet.getString("MIN_Value")};
				list.add(arr);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
		
			closeConn();
		}
		return list;
	}
	
	public static ArrayList<String[]> OutletLocationTypePreference() {
	    ArrayList<String[]> list = new ArrayList<>();
	    try {
	        startConn();
	      //������������statement��������ִ��SQL���
	        statement = connection.createStatement();
	        // ��ȡÿ��Outlet_Location_Type��Item_Outlet_Sales��Item_MRP��ƽ��ֵ
	        String sql1 = "select Outlet_Location_Type, avg(Item_Outlet_Sales) as Avg_Sales,"
	        		+ " avg(Item_MRP) as Avg_MRP from fd_log group by Outlet_Location_Type";
	      //���Ĳ���ִ��SQL���
	        resultSet = statement.executeQuery(sql1);
	        while (resultSet.next()) {
	            String locationType = resultSet.getString("Outlet_Location_Type");
	            String avgSales = resultSet.getString("Avg_Sales");
	            String avgMRP = resultSet.getString("Avg_MRP");
	            list.add(new String[] {locationType + "_Avg_Sales", avgSales});
	            list.add(new String[] {locationType + "_Avg_MRP", avgMRP});
	        }

	        // ��ȡÿ��Outlet_Location_Type�ĵ�֬�ͳ���֬������
	        String sql2 = "select Outlet_Location_Type, Item_Fat_Content, count(*) as Count from fd_log group by Outlet_Location_Type, Item_Fat_Content";
	        resultSet = statement.executeQuery(sql2);
	      //���岽��ѭ���������������󣬽�������󱣴浽list������
	        while (resultSet.next()) {
	            String locationType = resultSet.getString("Outlet_Location_Type");
	            String fatContent = resultSet.getString("Item_Fat_Content").equals("0") ? "Low Fat" : "Regular Fat";
	            String count = resultSet.getString("Count");
	            list.add(new String[] {locationType + "_" + fatContent, count});
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeConn();
	    }
	    return list;
	}
	public static void main(String[] args) {
		
	}
}


