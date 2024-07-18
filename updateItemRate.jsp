<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Item Rate - Harvest Haven</title>
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

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input[type="number"],
        .form-group select {
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
        <h1>Update Item Rate</h1>
        <form method="post" action="updateItemRate.jsp">
            <div class="form-group">
                <label for="item_name">Item Name:</label>
                <select name="item_name" id="item_name" class="form-control" required>
                    <option value="">Select Item</option>
                    <% 
                        try {
                            // Establish database connection
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "Gokul0880");
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT item_name FROM item");
                            while (rs.next()) {
                                String itemName = rs.getString("item_name");
                                out.println("<option value='" + itemName + "'>" + itemName + "</option>");
                            }
                            rs.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="new_rate">New Rate:</label>
                <input type="number" step="1" name="new_rate" id="new_rate" class="form-control" required>
            </div>
            <input type="submit" value="Update Rate" class="btn btn-primary">
        </form>
        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String itemName = request.getParameter("item_name");
                String newRateStr = request.getParameter("new_rate");

                if (itemName != null && !itemName.trim().isEmpty() &&
                    newRateStr != null && !newRateStr.trim().isEmpty()) {

                    try {
                        float newRate = Float.parseFloat(newRateStr);
                        // Establish database connection
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "Gokul0880");

                        // Prepare and execute SQL update statement
                        PreparedStatement ps = conn.prepareStatement("UPDATE item SET item_rate = ? WHERE item_name = ?");
                        ps.setFloat(1, newRate);
                        ps.setString(2, itemName);

                        int result = ps.executeUpdate();
                        if (result > 0) {
                            out.println("<div class='notification'>Item rate updated successfully.</div>");
                        } else {
                            out.println("<div class='notification'>Failed to update item rate.</div>");
                        }
                        ps.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='notification'>Error: " + e.getMessage() + "</div>");
                    }
                } else {
                    out.println("<div class='notification'>Please select an item and enter a new rate.</div>");
                }
            }
        %>
        <button onclick="window.location.href = 'index.jsp';" class="small-btn">Home</button>
    </div>
</body>
</html>