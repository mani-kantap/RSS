<%-- 
    Document   : newtrain
    Created on : Oct 11, 2018, 9:22:02 PM
    Author     : RGUKT
--%>

<%@page import="java.lang.NumberFormatException"%>
<%@page import="com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException"%>
<%@page import="com.StationNotFound"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%-- 
    Document   : index
    Created on : Oct 11, 2018, 6:14:40 PM
    Author     : RGUKT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Railways</title>
<style type="text/css">
    /* Add some padding on document's body to prevent the content
    to go underneath the header and footer */
    body{        
        padding-top: 60px;
        padding-bottom: 40px;
    }
    .container{
        width: 80%;
        margin: 0 auto; /* Center the DIV horizontally */
    }
    .fixed-header, .fixed-footer{
        width: 100%;
        position: fixed;        
        background: #333;
        padding: 10px 0;
        color: #fff;
    }
    .fixed-header{
        top: 0;
    }
    .fixed-footer{
        bottom: 0;
    }    
    /* Some more styles to beutify this example */
    nav a{
        color: #fff;
        text-decoration: none;
        padding: 7px 25px;
        display: inline-block;
    }
    .container p{
        line-height: 200px; /* Create scrollbar to test positioning */
    }
    #mine{
        background: #349;
    }
    .button {
  background-color: #ddd;
  border: none;
  color: black;
  padding: 10px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 16px;
}
</style>
</head>
<body>
    <%
        String email=(String)session.getAttribute("email");
        
        //redirect user to login page if not logged in
        if(email==null){
            response.sendRedirect("Login.jsp");
        }
        %>
    <div class="fixed-header">
        <div class="container">
            <nav>
                <a href="ahome.jsp">Home</a>
                <a href="atrain.jsp">Add Train</a>
                <a href="nshed.jsp">Add Schedule</a>
                <a href="#">Add Station</a>
                <a href="#">Add Route</a>
                <a href="#">Add Admin</a>
                <a href="#">Update Fairs</a>
                <a href="Logout.jsp">Logout</a>
            </nav>
        </div>
    </div>
    <div class="container">
        
        
        <%
            String result="",result2="",result3="",s2="";
        try{
            response.setContentType("text/html");
            String station=request.getParameter("station");
            String tstation=request.getParameter("tstation");
             String code=request.getParameter("code");
              String dist=request.getParameter("dist");
                  
            Class.forName("com.mysql.jdbc.Driver");
           
           Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/mani","root","");
           String query="";
           PreparedStatement ps;
           PreparedStatement ps2;
           PreparedStatement ps3;
                  
                 // String sour= request.getParameter("source");
                 // String de=request.getParameter("destination");
                  query="select id,dist from stations where name= ?";
                  String query2="select count(*) from stations";
                   
                  ps=con.prepareStatement(query);
                  ps.setString(1,station);
                  ResultSet rs=ps.executeQuery();
                  rs.next();
                   int re=rs.getInt(1);
                   int dis=rs.getInt(2) ;
                  ps=con.prepareStatement(query2);
                  rs=ps.executeQuery();
                  rs.next();
                  int a=rs.getInt(1),i;
                  int b=re;%>
                  <%
                  //Previous staion id
                  //count a
                  for(i=a+1;i>b;i--){
                      query="UPDATE  stations SET id = ? WHERE id =?" ;
                      %><%
                      ps=con.prepareStatement(query);
                      ps.setInt(1,i+1);
                      ps.setInt(2, i);
                      ps.executeUpdate();
                  }
                  query="insert into stations values(?,?,?,?)";
                  ps=con.prepareStatement(query);
                  ps.setInt(1,b+1);
                  ps.setString(2,tstation);
                  ps.setString(3,code);
                  ps.setInt(4,Integer.parseInt(dist)+dis);
                  ps.executeUpdate();
                 //result is id of  previous station
                 
               %>
               <h2 align="center">New station added successfully </h2>
        <form >
            <table cellpadding="5" align="center">
                <tr>
                    <td><b>StationNO</b></td>
                    <td><b> <%= b+1 %> </b></td>
                </tr>
 
                <tr>
                    <td><b>StationName:</b></td>
                    <td><b><%= station %></b></td>
                </tr>
                <tr>
                    <td><b>Code</b></td>
                    <td><b><%= code%></b></td>
                </tr>
                <tr>
                    <td><b>Dist</b></td>
                    <td><b><%= dist %></b></td>
                </tr>
                
            </table>
        </form>
               
                  <%
                      
           
    }
   
          


        catch(Exception e) {
%>
      <h2 align="center"> Station failed to add to the database </h2>
      <li>Reasons might be</li>
      <li>1.Station already got registered</li>
      <li>2.Software failure</li>
      <li>3.Stations might not be there in the list</li>
      <li>Contact your system admin</li>
               <%
                   out.println(e);
            e.printStackTrace();
        }
        %>
    	</div>    
    <div class="fixed-footer">
        <div class="container">Copyright &copy; 2018 </div>        
    </div>
</body>
</html>                            