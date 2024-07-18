<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Customer Invoices - Harvest Haven</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <style>
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
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); 
            position: relative; 
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .table th, .table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table thead th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .notification {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #e1f5fe;
            border-radius: 5px;
        }
        
        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo img {
            max-width: 100%; /* Ensures the image doesn't exceed its container's width */
            height: auto; /* Maintains aspect ratio */
            max-height: 200px; /* Optional: Set maximum height if needed */
        }

        .small-btn {
            width: 100px;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            position: absolute;
            right: 20px; 
            top: 20px; 
        }

        .small-btn:hover {
            background-color: #0056b3; 
        }

        .show-invoice-button {
            background-color: #007bff; 
            color: #fff; 
            border: none;
            border-radius: 4px; 
            cursor: pointer;
            padding: 5px 10px;
            margin-left: 10px; 
        }

        .show-invoice-button:hover {
            background-color: #0056b3; 
        }
    </style>
</head>
<body>
    <div class="logo">
        <img src="Logo.png" alt="Harvest Haven">
    </div>
    <div class="container">
        
        <h1>View Customer Invoices</h1>
        <form method="get" action="viewCustomerInvoices.jsp">
            <div class="form-group">
                <label for="customerPhone">Customer Phone:</label>
                <input type="text" name="customerPhone" id="customerPhone">
            </div>
            <input type="submit" value="View Invoices">
        </form>
        <%
            String customerPhone = request.getParameter("customerPhone");
            if (customerPhone != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "Gokul0880");

                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM Invoice WHERE customer_phone=?");
                    ps.setString(1, customerPhone);
                    ResultSet rs = ps.executeQuery();

                    if (!rs.isBeforeFirst()) {
                        out.println("<div class='notification'>No invoices found for this customer.</div>");
                    } else {
                        out.println("<table class='table'>");
                        out.println("<thead><tr><th>Invoice ID</th><th>Total</th><th>Show Invoice</th></tr></thead>");
                        out.println("<tbody>");
                        while (rs.next()) {
                            int invoiceId = rs.getInt("invoice_id");
                            float total = rs.getFloat("total");

                            out.println("<tr>");
                            out.println("<td>" + invoiceId + "</td>");
                            out.println("<td>" + total + "</td>");
                            out.println("<td><button class='show-invoice-button' onclick=\"window.location.href='viewInvoice.jsp?invoiceId=" + invoiceId + "';\">Show Invoice</button></td>");
                            out.println("</tr>");
                        }
                        out.println("</tbody></table>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='notification'>Error: " + e.getMessage() + "</div>");
                }
            }
        %>

        <button onclick="window.location.href = 'index.jsp';" class="small-btn">Home</button>
    </div>
</body>
</html>