<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Search</title>
    <style>
        /* CSS stilleri buraya gelebilir */
        body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f8f9fa;
}

.container {
    width: 80%;
    margin: 50px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
    margin-top: 0;
}

form {
    margin-top: 20px;
}

label {
    font-weight: bold;
}

input[type="number"],
input[type="text"] {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
}

button {
    padding: 10px 20px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #0056b3;
}

.room-box {
    width: 100px;
    height: 100px;
    border: 2px solid #ccc;
    margin: 10px;
    display: inline-block;
    text-align: center;
    line-height: 100px;
    font-size: 20px;
    font-weight: bold;
    border-radius: 5px;
}

.reserved {
    background-color: red;
    color: white;
}

.available {
    background-color: green;
    color: white;
}

    </style>
</head>
<body>
    <div class="container">
        <h2>Room Search</h2>
        <% 
            // Veritabanı bağlantısı oluştur
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                // Veritabanına bağlan
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Users", "", ""); // Your username and password
                
                // Odaları göster
                for (int roomNumber = 1; roomNumber <= 40; roomNumber++) {
                    // Her oda numarası için bir kutu oluştur ve rezervasyon durumuna göre rengini ayarla
                    boolean isReserved = false; // Varsayılan olarak oda rezerve edilmemiş olsun
                    // Odanın rezervasyon durumunu kontrol et
                    String sql = "SELECT COUNT(*) FROM RoomBookings WHERE room_number = ?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, roomNumber);
                    rs = ps.executeQuery();
                    rs.next();
                    int count = rs.getInt(1);
                    if (count > 0) {
                        isReserved = true; // Oda rezerve edilmiş
                    }
        %>
            <div class="room-box <%= isReserved ? "reserved" : "available" %>"><%= roomNumber %></div>
        <%
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            } finally {
                // Kapat
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
