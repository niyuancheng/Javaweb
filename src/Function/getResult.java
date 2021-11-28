package Function;

import java.sql.*;
import java.util.*;
import java.io.*;

public class getResult {
	public static ResultSet Select(String query) throws SQLException {
		Connection coon = new Connect().buildConnection();
		ResultSet rs = null;
		Statement st = coon.createStatement();
		rs = st.executeQuery(query);
		return rs;
	}
}
