# Java Hotel Reservation System
This project aims to develop a professional hotel reservation system using Java language. The system is designed to operate locally without the need for any specialized hardware.

Prerequisites

- Eclipse IDE
- Apache Tomcat Server
- MySQL Connector
  
Set up a server and create a web project connected to Apache Tomcat.
Create the necessary JSP files within the webapp folder as listed below:

- cancel_result.jsp
- cancelreservation.jsp
- confirm_reservation.jsp
- EnterOtp.jsp
- forgotPassword.jsp
- index.jsp
- login.jsp
- makereservation.jsp
- newPassword.jsp
- registration.jsp
- room_search.jsp
  
Import the servlets into the Java Resources folder:

- ForgotPassword.java
- Login.java
- Logout.java
- NewPassword.java
- RegistrationServlet.java
- ValidateOtp.java
  
Ensure all files are imported correctly.

# Database Integration
Integrate MySQL database into the project by following these steps:

Download the MySQL Connector and import it into the lib folder of the project.
Create the following tables in the MySQL database:

CREATE TABLE Users(
	id INT AUTO_INCREMENT PRIMARY KEY,

    username VARCHAR(50),
    
    userpassword VARCHAR(50),
    
    usermail VARCHAR(50),
    
    usermobile VARCHAR(20)
);

CREATE TABLE RoomBookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    
    room_number VARCHAR(20),
    
    customer_name VARCHAR(100),
    
    email VARCHAR(100),
    
    checkinDate DATE,
    
    checkoutDate DATE
);

Ensure to replace placeholders with your MySQL username and password in the appropriate places within the code.
