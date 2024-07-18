<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Prices - Harvest Haven</title>
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

        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo img {
            max-width: 100%;
            height: auto;
            max-height: 200px;
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
        <h1>Item Prices</h1>

        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "Gokul0880");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT item_name, unit, item_rate FROM Item");

                if (!rs.isBeforeFirst()) {
                    out.println("<div class='notification'>No items found in the database.</div>");
                } else {
                    out.println("<table class='table'>");
                    out.println("<thead><tr><th>Item Name</th><th>Unit</th><th>Rate</th></tr></thead>");
                    out.println("<tbody>");
                    while (rs.next()) {
                        String itemName = rs.getString("item_name");
                        String unit = rs.getString("unit");
                        float itemRate = rs.getFloat("item_rate");

                        out.println("<tr>");
                        out.println("<td>" + itemName + "</td>");
                        out.println("<td>" + unit + "</td>");
                        out.println("<td>" + itemRate + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</tbody></table>");
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='notification'>Error: " + e.getMessage() + "</div>");
            }
        %>

        <!-- Go to Home button -->
        <button onclick="window.location.href = 'index.jsp';" class="small-btn">Home</button>
    </div>
</body>
</html>