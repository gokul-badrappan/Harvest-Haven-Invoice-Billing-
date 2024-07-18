<%@ page import="java.sql.*" %>
<%
    // Get the invoiceId parameter from the request
    String invoiceId = request.getParameter("invoiceId");

    if (invoiceId != null) {
        try {
            // Load the MySQL JDBC driver and establish a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "Gokul0880");

            // Prepare the SQL statement to update the invoice status
            PreparedStatement ps = conn.prepareStatement("UPDATE Invoice SET status = TRUE WHERE invoice_id = ?");
            ps.setInt(1, Integer.parseInt(invoiceId));

            // Execute the SQL statement and get the number of rows updated
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                // If rows are updated, display success message
                out.println("<div>Invoice ID " + invoiceId + " marked as paid successfully.</div>");
            } else {
                // If no rows are updated, display error message
                out.println("<div>Error: Invoice ID " + invoiceId + " not found.</div>");
            }
        } catch (Exception e) {
            // Catch any exceptions that occur during the database operation
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    } else {
        // If invoiceId is null, display invalid invoice ID message
        out.println("Invalid invoice ID.");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invoice Marked as Paid</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
        }
    </style>
</head>
<body>
    <a href="listUnpaidInvoices.jsp">Back to Unpaid Invoices</a>
</body>
</html>
