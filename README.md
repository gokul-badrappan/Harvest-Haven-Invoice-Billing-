
# Harvest Haven : A Grocery Billing Application 

Harvest Haven is an application that will fulfill the need of creating, maintaining and managing invoices.


## Authors

- Gokul B - [@gokul-badrappan](https://github.com/gokul-badrappan)

## Tech Stack

**Client:** JSP, HTML, CSS, Bootstrap, Javascript, 

**Server:** Apache Tomcat® Native - v2.0.7

**Database:** MySQL 9.0.0 

## Project Uniqueness
 - The dropdown menus for the item list is dynamically fetched from the database. Any changes in the add/remove stock will reflect throughout the application.
 - The details that change over time (item rate) remain unchanged in the previously generated invoice. This is because we haven't used foreign key reference in the billitem table to get the item rate value. Instead we use a copy field in the billitem table.
 - A feature to add a new item to stock or remove the item from existing stocks or update the rate of the existing items. This makes this application fully functional for the real world.
 - The end-user of this application will be shopowner or billing person. Hence it is designed in such a way that they can give customised discount for each invoice.
 - The MARK-AS-PAID is a feature through which the shopowner/billing person can change the payment status of the invoice.
 - The User Interface of the application has been designed to make it user friendly and icons from FontAwesome and styling from Bootstrap have been incorporated to enhance the user experience.
 - Client Side validations such as a new invoice can't be generated without adding the customer name and number, Item Name is made required to add it to the stocks, etc are included in this application.


## Table Design 
<img width="963" alt="Screenshot 2024-07-18 at 11 35 20 PM" src="https://github.com/user-attachments/assets/1e28ee78-53a2-4bad-9c61-74e789885700">

<img width="737" alt="Screenshot 2024-07-18 at 10 49 40 PM" src="https://github.com/user-attachments/assets/71af81ff-e899-4bb0-bbff-091a7133bc37">



## Screenshots

Homepage
<img width="1470" alt="Screenshot 2024-07-18 at 10 15 39 PM" src="https://github.com/user-attachments/assets/067a9bb8-63e5-4e8f-a9aa-57d1519d2fb5">


Update Item Rate
<img width="1470" alt="Screenshot 2024-07-18 at 10 22 53 PM" src="https://github.com/user-attachments/assets/1784a2fa-afa2-4fe4-9d2e-c3e72ee16577">


Add / Remove Stock
<img width="1470" alt="Screenshot 2024-07-18 at 10 22 30 PM" src="https://github.com/user-attachments/assets/cd1c9017-2ca1-4e90-86d4-d9f855f3e0ed">


View Unpaid Invoices
<img width="1470" alt="Screenshot 2024-07-18 at 10 21 32 PM" src="https://github.com/user-attachments/assets/6792c5a7-824c-422b-9007-3010075ec084">


View Invoices by Status
<img width="1470" alt="Screenshot 2024-07-18 at 10 21 22 PM" src="https://github.com/user-attachments/assets/ac4730dc-97d4-42ee-8369-630c2d3735a2">


View Item Wise Revenue
<img width="1470" alt="Screenshot 2024-07-18 at 10 21 08 PM" src="https://github.com/user-attachments/assets/209ffa09-b56a-48d5-b1f5-62a247a35a5e">


View Invoice By ID
<img width="1460" alt="Screenshot 2024-07-19 at 12 25 14 AM" src="https://github.com/user-attachments/assets/cbf8c294-e504-4ab6-a30f-d8a2a70bf8ae">


View Customer Specific Invoice
<img width="1470" alt="Screenshot 2024-07-18 at 10 20 38 PM" src="https://github.com/user-attachments/assets/6448f79e-1260-4e60-9a40-8a88434b0e24">


View Customer Specific Invoice
<img width="1470" alt="Screenshot 2024-07-18 at 10 20 25 PM" src="https://github.com/user-attachments/assets/29bfa1da-f1e6-45d9-b612-f3a4081ace09">

View All Invoices
<img width="1282" alt="Screenshot 2024-07-18 at 10 20 07 PM" src="https://github.com/user-attachments/assets/6a8c4c15-3d74-4b98-9f1f-1c2e6234775f">

Create an Invoice
<img width="1222" alt="Screenshot 2024-07-18 at 10 18 16 PM" src="https://github.com/user-attachments/assets/acb5ed5a-64c5-416b-b738-f27059bfd08a">
<img width="1309" alt="Screenshot 2024-07-18 at 10 17 35 PM" src="https://github.com/user-attachments/assets/4edf6aeb-6b20-4ceb-97cc-160e7954ba38">

View Prices of Items in the Store
<img width="1436" alt="Screenshot 2024-07-19 at 12 26 36 AM" src="https://github.com/user-attachments/assets/e26cb02e-6054-4e85-afe7-26d72e318052">



## Modules Information

Following are the JSP files that are used in the appliation

- createInvoice.jsp
- index.jsp
- addRemoveStock.jsp
- listUnpaidInvoices.jsp
- markInvoicePaid.jsp
- updateItemRate.jsp
- viewInvoice.jsp
- viewInvoiceById.jsp
- viewAllInvoices.jsp
- viewInvoicesByStatus.jsp
- viewItemWiseRevenue.jsp
- viewCustomerInvoices.jsp
- viewPrices.jsp

1. createInvoice.jsp: 
This JSP allows users to create new invoices. It prompts for customer information(Name and Phone Number) and item details(the list of items is fetched from the databases), calculates totals with discounts and delivery charges, and stores the invoice information in the Invoice Table and BillItem Table in the database.

2. index.jsp: 
This is the main navigation page of the billing system. It presents a menu of various actions the user can perform, such as creating an invoice,viewing all invoices, viewing customer-specific invoice, viewing invoice by ID, viewing Item Wise Revenue, viewing Invoices by status, marking invoices from unpaid to paid, adding/removing stocks and updating the prices of the items.

3. addRemoveStock.jsp: 
This JSP enables the user to add new items to the stock database or remove existing items. It includes forms for inputting item details (name, rate, unit) and handles the update in the database.

4. listUnpaidInvoices.jsp: 
This JSP displays a list of all the unpaid invoices. It shows invoice IDs, customer phone numbers, and total amounts. It also allows users to mark invoices as paid using a form to submit an update to the database using the UPDATE command.

5. markInvoicePaid.jsp:
This JSP handles the logic for marking an invoice as paid. It receives the invoice ID as a parameter and updates the status of the invoice in the database to 'Paid' (Boolean : 1).

6. updateItemRate.jsp: 
This JSP allows users to update the price of existing items in the stock database. It displays a dropdown menu of available items, allows users to enter a new price, and updates the price in the database using the UPDATE command.

7. viewInvoice.jsp: 
This JSP displays the details of a specific invoice. It fetches customer details, items purchased, and total cost of the Invoice.

8. viewInvoiceById.jsp: 
This JSP allows users to view the invoice by entering the invoice ID. It searches the database for the invoice using it's ID as a parameter and displays all its details.

9. viewAllInvoices.jsp: 
This JSP displays a list of all invoices in the database. It includes the invoice ID, customer phone number,date of invoice, quantity, rate and total amount for each invoice, including discount and carry bag charges.

10. viewInvoicesByStatus.jsp: 
This JSP allows users to filter invoices by their status (Paid or Unpaid). Users can select the desired status from a dropdown menu, and the page will display invoices matching that status.

11. viewItemWiseRevenue.jsp: 
This JSP displays a report showing the total revenue generated from each item. It fetches amt_so_far and qty_so_far values from the item table in the database and displays it to the user.

12. viewCustomerInvoices:
This JSP displays the invoices that are created by the specific customer. We can give the phone number of the customer and all the invoices under that phone number will be displayed.

13. viewPrices.jsp
This JSP allows the user to see the items available and their prices in the stores. This feature will be helpful for customers and shopkeepers/workers who wish to see thier item prices.
## Functions and Files Used

1. VIEW ALL INVOICES:
- viewAllInvoices.jsp

2. VIEW CUSTOMER SPECIFIC INVOICES:
- viewCustomerInvoices.jsp
- viewInvoice.jsp

3. VIEW INVOICE BY ID:
- viewInvoicesById.jsp

4. VIEW ITEM WISE REVENUE:
- viewItemWiseRevenue.jsp

5. VIEW INVOICE BY STATUS:
- viewInvoicesByStatus.jsp

6. CREATE AN INVOICE:
- createInvoice.jsp

7. UPDATE ITEM PRICE:
- updateItemRate.jsp

8. CHANGE INVOICE STATUS (PAID/UNPAID)
- listUnpaidInvoices.jsp
- markInvoicePaid.jsp

9. ADD/REMOVE STOCK:
- addRemoveStock.jsp

10. LANDING PAGE:
- index.jsp

11. VIEW ITEM RATES
- showPrices.jsp

## Run Locally 

Windows :
 1. Download Tomcat for macOS (v 10.1.26) from the official Tomcat website.
2.	Extract the downloaded tar.gz file.
3.	Open the extracted apache-tomcat-10.1.26 directory.
4.	Set up Java environment variables in your shell profile.
5. Source the profile file to apply changes.
6. Open Terminal and move to the bin directory of your Tomcat server and run:
    ```
    ./startup.sh 
    ```
7. Check by going to the localhost:8080 in a browser whether the server is on.
8. Move your project folder to the webapps directory within your Tomcat root directory.
9. Access your project in the browser using the URL: http://localhost:8080/supermarket.

##
Mac:
1. Download Tomcat Native  from the official Tomcat website.
2. Extract the downloaded tar.gz file.
3. Open the extracted apache-tomcat-10.1.26 directory.
4. Set up Java environment variables in your shell profile.
5. Source the profile file to apply changes.
6. Navigate to the bin directory of your Tomcat server.
7. Start the server using the startup.sh script.
8. Open a web browser and go to http://localhost:8080 to check if the server is running.
9. Move your project folder to the webapps directory within your Tomcat root directory.
10. Access your project in the browser using the URL: http://localhost:8080/supermarket.

