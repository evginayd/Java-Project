<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Make Reservation</title>
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
        <h2>Make Reservation</h2>
        <form action="confirm_reservation.jsp" method="post">
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" required>
            </div>
            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="roomNumber">Room Number:</label>
                <select id="roomNumber" name="roomNumber" required>
                    <% for (int i = 1; i <= 40; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
			    <label for="checkinDate">Check-in Date:</label>
			    <input type="date" id="checkinDate" name="checkinDate" required>
			</div>
			
			<script>
			    // Bugünün tarihini al
			    var today = new Date();
			    var dd = String(today.getDate()).padStart(2, '0');
			    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
			    var yyyy = today.getFullYear();
			
			    today = yyyy + '-' + mm + '-' + dd;
			
			    // Check-in date alanına bugünden önceki tarihleri seçilemez hale getir
			    document.getElementById("checkinDate").setAttribute("min", today);
			</script>

            <div class="form-group">
                <label for="checkoutDate">Check-out Date:</label>
                <input type="date" id="checkoutDate" name="checkoutDate" required>
            </div>
            
            <script>
			    // Bugünün tarihini al
			    var today = new Date();
			    var dd = String(today.getDate()).padStart(2, '0');
			    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
			    var yyyy = today.getFullYear();
			
			    today = yyyy + '-' + mm + '-' + dd;
			
			    // Bugünden 20 gün sonrasını al
			    var checkoutLimit = new Date();
			    checkoutLimit.setDate(checkoutLimit.getDate() + 20);
			    var dd = String(checkoutLimit.getDate()).padStart(2, '0');
			    var mm = String(checkoutLimit.getMonth() + 1).padStart(2, '0'); //January is 0!
			    var yyyy = checkoutLimit.getFullYear();
			
			    checkoutLimit = yyyy + '-' + mm + '-' + dd;
			
			    // Checkout date alanına 20 gün sonrasından öncesi veya bugünden öncesi tarihler seçilemez hale getir
			    document.getElementById("checkoutDate").setAttribute("min", today);
			    document.getElementById("checkoutDate").setAttribute("max", checkoutLimit);
			</script>
            
            <button type="submit" class="btn">Submit</button>
        </form>
    </div>
</body>
</html>
