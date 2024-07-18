<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Invoice by ID - Harvest Haven</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
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
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            position: relative;
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

        .card {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .card-title {
            font-size: 1.5em;
            color: #333;
            margin-bottom: 10px;
        }

        .card-body {
            padding: 10px;
        }

        .invoice {
            border: 1px solid #ccc;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #f9f9f9;
            border-radius: 5px;
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
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .small-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="logo">
        <img src="Logo.png" alt="Harvest Haven">
    </div>
    <div class="container">
        <h1>View Invoice by ID</h1>
        <form method="get" action="viewInvoiceById.jsp">
            <div class="form-group">
                <label for="invoiceId">Invoice ID:</label>
                <input type="text" name="invoiceId" id="invoiceId" class="form-control">
            </div>
            <input type="submit" value="View Invoice" class="btn btn-primary">
        </form>
        <%-- Server-side Java code --%>
        <%
            String invoiceIdStr = request.getParameter("invoiceId");
            if (invoiceIdStr != null && !invoiceIdStr.trim().isEmpty()) {
                try {
                    int invoiceId = Integer.parseInt(invoiceIdStr);
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "Gokul0880");

                    // Query to retrieve invoice details
                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM Invoice WHERE invoice_id=?");
                    ps.setInt(1, invoiceId);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String customerPhone = rs.getString("customer_phone");
                        float total = rs.getFloat("total");

                        // Display invoice details
                        out.println("<div class='invoice'>");
                        out.println("<div class='invoice-header'>Invoice ID: " + invoiceId + "</div>");
                        out.println("<div>Date: " + new java.util.Date() + "</div>");
                        out.println("<div>Customer Phone: " + customerPhone + "</div>");
                        out.println("<div>Total: " + total + "</div>");
                        out.println("<div class='invoice-items'>Items:<br>");

                        // Query to retrieve bill items
                        ps = conn.prepareStatement("SELECT * FROM BillItem WHERE invoice_id=?");
                        ps.setInt(1, invoiceId);
                        ResultSet rsItems = ps.executeQuery();
                        while (rsItems.next()) {
                            out.println("<div class='invoice-item'>Item Name: " + rsItems.getString("item_name") + ", Quantity: " + rsItems.getFloat("qty") + ", Price: " + rsItems.getFloat("price") + "</div>");
                        }
                        out.println("</div></div>");
                    } else {
                        out.println("<div class='notification'>Invoice not found.</div>");
                    }
                } catch (NumberFormatException e) {
                    out.println("<div class='notification'>Invalid Invoice ID format.</div>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='notification'>Error: " + e.getMessage() + "</div>");
                }
            } else {
                out.println("<div class='notification'>Please enter an Invoice ID.</div>");
            }
        %>
        <button onclick="window.location.href = 'index.jsp';" class="small-btn">Home</button>
    </div>
</body>
</html>