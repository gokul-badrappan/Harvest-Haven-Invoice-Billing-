<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Invoices - Harvest Haven</title>
    <style>
        /* CSS styles for the page */
        body {
            font-family: 'Arial', sans-serif;
            margin: 50px;
            background-color: #f0f0f0;
        }

        h1 {
            text-align: center;
            color: #333;
            font-size: 3em; 
            margin-bottom: 20px;
        }

        .container {
            width: 1000px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); 
        }

        .invoice {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
        }

        .invoice-header {
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .invoice-items {
            margin-top: 10px;
        }

        .invoice-item {
            margin: 5px 0;
            font-size: 14px; 
            border-bottom: 1px solid #ccc;
            padding-bottom: 5px;
        }

        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo img {
            max-width: 100%; 
            height: auto; 
            max-height: 200px; 
        }
        
        .notification {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #e1f5fe;
            border-radius: 5px;
        }

        .small-btn {
            width: 100px; 
            padding: 10px;
            margin-top: 20px; 
            background-color: #007bff; 
            color: #fff; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .small-btn:hover {
            background-color: #0056b3; 
        }

        .notification1{
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="Logo.png" alt="Harvest Haven">
        </div>
        <h1>All Invoices</h1>
        
        <%-- Java code to retrieve and display invoices --%>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "Gokul0880");

                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Invoice");

                if (!rs.isBeforeFirst()) {
                    out.println("<div class='notification'>No invoices found.</div>");
                } else {
                    while (rs.next()) {
                        int invoiceId = rs.getInt("invoice_id");
                        String customerPhone = rs.getString("customer_phone");
                        float total = rs.getFloat("total");
                        java.sql.Date creationDate = rs.getDate("creation_date"); // Retrieve creation date

                        out.println("<div class='invoice'>");
                        out.println("<div class='invoice-header'>Invoice ID: " + invoiceId + "</div>");
                        out.println("<div>Date: " + creationDate + "</div>"); // Display creation date
                        out.println("<div>Customer Phone: " + customerPhone + "</div>");
                        out.println("<div>Total: " + total + "</div>");
                        out.println("<div class='invoice-items'>Items:<br>");

                        PreparedStatement ps = conn.prepareStatement("SELECT * FROM BillItem WHERE invoice_id=?");
                        ps.setInt(1, invoiceId);
                        ResultSet rsItems = ps.executeQuery();
                        while (rsItems.next()) {
                            // Fetch item_unit from the BillItem table 
                            String itemUnit = rsItems.getString("unit"); 

                            // Fetch item_rate from the Item table
                            PreparedStatement psItemRate = conn.prepareStatement("SELECT item_rate FROM Item WHERE item_name = ?");
                            psItemRate.setString(1, rsItems.getString("item_name"));
                            ResultSet rsItemRate = psItemRate.executeQuery();
                            float itemRate = 0; // Initialize itemRate
                            if (rsItemRate.next()) {
                                itemRate = rsItemRate.getFloat("item_rate");
                            }

                            // Now you can use itemRate in your output
                            out.println("<div class='invoice-item'>Item Name: " + rsItems.getString("item_name") + 
                                        ", Quantity: " + rsItems.getFloat("qty") + 
                                        ", Unit: " + itemUnit + 
                                        ", Rate: " + itemRate + // Display item_rate
                                        ", Price: " + rsItems.getFloat("price") + "</div>");
                        }
                        out.println("</div></div>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            }
        %>
        
        <div class="notification1">
            <button onclick="window.location.href = 'index.jsp';" class="small-btn">Go to Home</button>
        </div>
       
    </div>
</body>
</html>