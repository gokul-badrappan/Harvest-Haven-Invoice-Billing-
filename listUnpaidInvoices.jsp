<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List Unpaid Invoices - Harvest Haven</title>
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
            text-align: center;
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
            padding: 10px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .invoice-details {
            display: flex;
            flex-direction: column;
        }

        .invoice button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .invoice button:hover {
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
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="Logo.png" alt="Harvest Haven">
        </div>
        <div class="card">
            <h2 class="card-title">Unpaid Invoices</h2>
            <div class="card-body">
                <%-- Java code to retrieve and display unpaid invoices --%>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "Gokul0880");

                        PreparedStatement ps = conn.prepareStatement("SELECT invoice_id, customer_phone, total FROM Invoice WHERE status = FALSE");
                        ResultSet rs = ps.executeQuery();

                        if (!rs.isBeforeFirst()) {
                            out.println("<div class='notification'>No unpaid invoices found.</div>");
                        } else {
                            while (rs.next()) {
                                int invoiceId = rs.getInt("invoice_id");
                                String customerPhone = rs.getString("customer_phone");
                                float total = rs.getFloat("total");

                                out.println("<div class='invoice'>");
                                out.println("<div class='invoice-details'>");
                                out.println("<div>Invoice ID: " + invoiceId + "</div>");
                                out.println("<div>Customer Phone: " + customerPhone + "</div>");
                                out.println("<div>Total: " + total + "</div>");
                                out.println("</div>");
                                out.println("<form action='markInvoicePaid.jsp' method='post'>");
                                out.println("<input type='hidden' name='invoiceId' value='" + invoiceId + "'>");
                                out.println("<button type='submit'>Mark as Paid</button>");
                                out.println("</form>");
                                out.println("</div>");
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='notification'>Error: " + e.getMessage() + "</div>");
                    }
                %>
            </div>
        </div>
        <button onclick="window.location.href = 'index.jsp';" class="btn btn-secondary small-btn">Home</button>
    </div>
</body>
</html>
