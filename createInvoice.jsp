<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Invoice - Harvest Haven</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <!--- Styles --->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 50px;
            background-color: #ffffff;
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
            border: 1px solid #ddd;
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
            font-weight: bold;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group input::placeholder {
            color: #999;
        }

        .btn-primary, .btn-success {
            background-color: #007bff;
            color: #fff; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer;
            transition: background-color 0.3s ease; 
        }

        .btn-primary:hover, .btn-success:hover {
            background-color: #0056b3; 
        }

        .item-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .item-container input, .item-container select {
            width: 45%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .notification {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #e1f5fe;
            border-radius: 5px;
            text-align: center;
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
        <h1>Create Invoice</h1>
        <form id="invoiceForm" method="post" action="createInvoice.jsp">
            <div class="form-group">
                <label for="customerPhone">Customer Phone:</label>
                <input type="text" name="customerPhone" id="customerPhone" placeholder="Enter Customer Phone">
            </div>
            <div class="form-group">
                <label for="customerName">Customer Name:</label>
                <input type="text" name="customerName" id="customerName" placeholder="Enter Customer Name">
            </div>
            <div id="items">
                <div class="item-container">
                    <select name="itemName" class="item-name-dropdown">
                        <option value="">Select Item</option>
                        <% 
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "Gokul0880");
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT item_name FROM Item");
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
                    <input type="text" name="quantity" placeholder="Quantity">
                </div>
            </div>
            <button type="button" onclick="addItem()" class="btn btn-success">Add Another Item</button>
            <div class="form-group">
                <label for="discount">Discount (%):</label>
                <input type="text" name="discount" id="discount" placeholder="Enter Discount Percentage">
            </div>
            <input type="checkbox" name="deliveryCharge" id="deliveryCharge">
            <div class="form-group">
                <label for="deliveryCharge">Add a carry bag of Rs. 5</label>
            </div>
            <button type="submit" class="btn btn-primary" onclick="return validateForm()">Create Invoice</button>
            <%
                String customerPhone = request.getParameter("customerPhone");
                String customerName = request.getParameter("customerName");
                String[] itemNames = request.getParameterValues("itemName");
                String[] quantities = request.getParameterValues("quantity");
                String discountStr = request.getParameter("discount");
                boolean addDeliveryCharge = "on".equals(request.getParameter("deliveryCharge"));

                Connection conn = null;

                if (customerPhone != null && customerName != null && itemNames != null && quantities != null) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "Gokul0880");
                        conn.setAutoCommit(false);

                        // Insert customer
                        PreparedStatement psCustomer = conn.prepareStatement("INSERT INTO Customer (customer_phone, customer_name) VALUES (?, ?) ON DUPLICATE KEY UPDATE customer_name=?");
                        psCustomer.setString(1, customerPhone);
                        psCustomer.setString(2, customerName);
                        psCustomer.setString(3, customerName);
                        psCustomer.executeUpdate();

                        // Insert invoice
                        PreparedStatement psInvoice = conn.prepareStatement("INSERT INTO Invoice (customer_phone, status, subtotal, discount, total) VALUES (?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
                        psInvoice.setString(1, customerPhone);
                        psInvoice.setBoolean(2, false);
                        float subtotal = 0;
                        
                        // Fetch item_rate and calculate subtotal
                        for (int i = 0; i < itemNames.length; i++) {
                            PreparedStatement psItem = conn.prepareStatement("SELECT item_rate, unit FROM Item WHERE item_name = ?");
                            psItem.setString(1, itemNames[i]);
                            ResultSet rsItem = psItem.executeQuery();
                            if (rsItem.next()) {
                                float rate = rsItem.getFloat("item_rate");
                                String itemUnit = rsItem.getString("unit"); 
                                subtotal += Float.parseFloat(quantities[i]) * rate;
                            }
                        }

                        float discount = (discountStr != null && !discountStr.isEmpty()) ? Float.parseFloat(discountStr) : 0;
                        float discountAmount = subtotal * (discount / 100);
                        float total = subtotal - discountAmount;

                        if (addDeliveryCharge) {
                            total += 50;
                        }

                        psInvoice.setFloat(3, subtotal);
                        psInvoice.setFloat(4, discountAmount);
                        psInvoice.setFloat(5, total);
                        psInvoice.executeUpdate();

                        ResultSet rs = psInvoice.getGeneratedKeys();
                        rs.next();
                        int invoiceId = rs.getInt(1); 

                        // Insert bill items and update item quantities
                        for (int i = 0; i < itemNames.length; i++) {
                            PreparedStatement psItem = conn.prepareStatement("SELECT item_rate, unit FROM Item WHERE item_name = ?");
                            psItem.setString(1, itemNames[i]);
                            ResultSet rsItem = psItem.executeQuery();
                            if (rsItem.next()) {
                                float rate = rsItem.getFloat("item_rate");
                                String itemUnit = rsItem.getString("unit");
                                PreparedStatement psBillItem = conn.prepareStatement("INSERT INTO BillItem (invoice_id, item_name, rate, qty, unit, price) VALUES (?, ?, ?, ?, ?, ?)");
                                psBillItem.setInt(1, invoiceId);
                                psBillItem.setString(2, itemNames[i]);
                                psBillItem.setFloat(3, rate);
                                psBillItem.setFloat(4, Float.parseFloat(quantities[i]));
                                psBillItem.setString(5, itemUnit);
                                psBillItem.setFloat(6, Float.parseFloat(quantities[i]) * rate);
                                psBillItem.executeUpdate();
                                PreparedStatement psUpdateItem = conn.prepareStatement("UPDATE Item SET qty_so_far = qty_so_far + ?, amount_so_far = amount_so_far + ? WHERE item_name = ?");
                                psUpdateItem.setFloat(1, Float.parseFloat(quantities[i]));
                                psUpdateItem.setFloat(2, Float.parseFloat(quantities[i]) * rate);
                                psUpdateItem.setString(3, itemNames[i]);
                                psUpdateItem.executeUpdate();
                            }
                        }
    
                        conn.commit();
                        out.println("<div class='notification'>Invoice created successfully. Total: Rs." + total + "</div>");
    
                    } catch (Exception e) {
                        try {
                            if (conn != null) {
                                conn.rollback();
                            }
                        } catch (SQLException rollbackException) {
                            rollbackException.printStackTrace();
                        }
                        e.printStackTrace();
                        out.println("<div class='notification'>Error: " + e.getMessage() + "</div>");
                    } finally {
                        try {
                            if (conn != null) {
                                conn.close();
                            }
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }
                }
            %>
        </form>
        <button onclick="window.location.href = 'index.jsp';" class="btn btn-secondary small-btn">Home</button>
    </div>
    <script>
        function addItem() {
            var itemDiv = document.getElementById('items');
            var newItem = document.createElement('div');
            newItem.className = 'item-container';
            newItem.innerHTML = '<select name="itemName" class="item-name-dropdown">' +
                                document.querySelector('.item-name-dropdown').innerHTML +
                                '</select>' +
                                '<input type="text" name="quantity" placeholder="Quantity">';
            itemDiv.appendChild(newItem);
        }
    
        function validateForm() {
            var customerPhone = document.getElementById('customerPhone').value;
            var customerName = document.getElementById('customerName').value;
    
            if (customerPhone === "" || customerName === "") {
                alert("Please enter both customer phone and customer name.");
                return false; 
            }
            return true; 
        }
    </script>
</body>
</html>