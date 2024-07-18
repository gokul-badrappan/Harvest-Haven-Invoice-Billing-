<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Billing System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Roboto', sans-serif;
        }

        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin: 50px auto;
            max-width: 800px; 
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 40px;
        }
        ul {
            list-style: none;
            padding: 0;
        }
        li {
            margin-bottom: 20px;
        }
        a {
            display: block;
            text-decoration: none;
            color: #007bff;
            font-size: 18px;
            padding: 12px 20px;
            border-radius: 6px;
            transition: background-color 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        a:hover {
            background-color: #0056b3;
            color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .fa-angle-right {
            margin-left: 10px;
        }

        .logo {
            text-align: center;
            margin-bottom: 5px; 
        }
        .logo img {
            max-width: 100%;
            height: auto;
            max-height: 300px; 
        }
        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px; 
        }

        .card-title {
            color: #333;
            font-size: 1.8em; 
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    
    <div class="logo">
        <img src="Logo_Index.png" alt="Harvest Haven"> 
    </div>
    <!-- Main container -->
    <div class="container">
        
        <div class="card">
           
            <h2 class="card-title"><i class="fas fa-cash-register"></i> Billing System</h2>
            <!-- List of links -->
            <ul>
                <li><a href="createInvoice.jsp"><i class="fas fa-plus-circle"></i> Create a New Invoice <i class="fas fa-angle-right"></i></a></li>
                <li><a href="viewAllInvoices.jsp"><i class="fas fa-eye"></i> View All Invoices <i class="fas fa-angle-right"></i></a></li>
                <li><a href="viewCustomerInvoices.jsp"><i class="fas fa-user"></i> View Customer Specific Invoices <i class="fas fa-angle-right"></i></a></li>
                <li><a href="viewInvoiceById.jsp"><i class="fas fa-id-card"></i> View Invoice by ID <i class="fas fa-angle-right"></i></a></li>
                <li><a href="viewItemWiseRevenue.jsp"><i class="fas fa-chart-bar"></i> View Item Wise Revenue <i class="fas fa-angle-right"></i></a></li>
                <li><a href="viewInvoicesByStatus.jsp"><i class="fas fa-filter"></i> View Invoices by Status <i class="fas fa-angle-right"></i></a></li>
                <li><a href="listUnpaidInvoices.jsp"><i class="fas fa-check"></i> Mark Invoices as Paid <i class="fas fa-angle-right"></i></a></li>
                <li><a href="addRemoveStock.jsp"><i class="fa-solid fa-circle-plus"></i> Add/Remove Stock<i class="fas fa-angle-right"></i></a></li>
                <li><a href="updateItemRate.jsp"><i class="fa-regular fa-pen-to-square"></i> Update Item Price<i class="fas fa-angle-right"></i></a></li>
                <li><a href="showPrices.jsp"><i class="fa-solid fa-indian-rupee-sign"></i>Show Item Rates <i class="fas fa-angle-right"></i></a></li>
               
            </ul>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
</body>
</html>
