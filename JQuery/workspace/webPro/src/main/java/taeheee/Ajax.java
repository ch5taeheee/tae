package taeheee;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/Ajax")
public class Ajax extends HttpServlet {
   private static final long serialVersionUID = 1L;

   public Ajax() {
      super();
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {

      String nm = request.getParameter("userNm");
      System.out.println(">>>>>" + nm);

      response.setCharacterEncoding("UTF-8");
      PrintWriter out = response.getWriter();
//      out.write("<h4 style='color:gold;'>이름 : " + nm + "</h4>");
      out.print("{\"name\" : \""+ nm + " \"}"); // json 형식의 데이터
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      
      String userNm = request.getParameter("name");
      System.out.println("요청정보 >> " + userNm);
      
      BufferedReader rd = request.getReader();
      String jsonData = rd.readLine();
      System.out.println("jsonData>>> " + jsonData);
      
      JsonParser parser = new JsonParser();
      JsonObject parse = (JsonObject)parser.parse(jsonData);
      String param = parse.get("name").getAsString();
      System.out.println(">>>>> " + param);
      
      response.setCharacterEncoding("utf-8");
      PrintWriter out = response.getWriter();
      out.write("<h4 style='color: lime'>" +param + "</h4>");
   }

}