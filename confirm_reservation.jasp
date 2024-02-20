<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Reservation</title>
    <style>
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
        <h2>Confirm Reservation</h2>
        <% 
            // Kullanıcı tarafından post edilen form verilerini al
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String roomNumber = request.getParameter("roomNumber");
            String checkinDate = request.getParameter("checkinDate");
            String checkoutDate = request.getParameter("checkoutDate");
            
            // Veritabanı bağlantısı oluştur
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                // Veritabanına bağlan
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Users", "root", "Ilovethissite123*");
                
                // Kontrol sorgusu hazırla ve çalıştır
                String checkAvailabilitySQL = "SELECT COUNT(*) FROM RoomBookings WHERE room_number = ? AND ((checkinDate BETWEEN ? AND ?) OR (checkoutDate BETWEEN ? AND ?))";
                ps = conn.prepareStatement(checkAvailabilitySQL);
                ps.setString(1, roomNumber);
                ps.setString(2, checkinDate);
                ps.setString(3, checkoutDate);
                ps.setString(4, checkinDate);
                ps.setString(5, checkoutDate);
                rs = ps.executeQuery();
                rs.next();
                int count = rs.getInt(1);
                
                // Eğer başka bir rezervasyon varsa hata mesajı göster
                if (count > 0) {
        %>
            <p>Sorry, the room is already reserved for the selected dates. Please choose different dates or room.</p>
        <%
                } else {
                    // Başka bir rezervasyon yoksa rezervasyonu kaydet
                    String insertReservationSQL = "INSERT INTO RoomBookings (room_number, customer_name, email, checkinDate, checkoutDate) VALUES (?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(insertReservationSQL);
                    ps.setString(1, roomNumber);
                    ps.setString(2, firstName + " " + lastName);
                    ps.setString(3, email);
                    ps.setString(4, checkinDate);
                    ps.setString(5, checkoutDate);
                    int rowsAffected = ps.executeUpdate();
                    
                    // Rezervasyon başarıyla kaydedildiyse kullanıcıya teşekkür mesajı göster
                    if (rowsAffected > 0) {
        %>
            <p>Thank you, your reservation has been confirmed.</p>
        <%
                    } else {
        %>
            <p>Sorry, there was an error processing your reservation. Please try again later.</p>
        <%
                    }
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
                    if (ps != null) {
                        ps.close();
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
