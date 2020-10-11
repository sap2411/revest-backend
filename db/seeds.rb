# seed categories to base a users budgets off of. Info was informed by research determining the average americans spends on categories. values added to venmo, interes, and misc added for error handling
home = Category.create(name: "Home", min: 400.0, max: 5000.0, percentage: 0.31, tags: "Home Rent House Mortgage Utilities")
food = Category.create(name: "Food", min: 150.0, max: 700.0, percentage: 0.12, tags: "Food and Drink Supermarkets and Groceries")
insurance = Category.create(name: "Health and Insurance", min: 0.0, max: 1000.0, percentage: 0.095, tags: "Insurance Medical Health")
transport = Category.create(name: "Transportation", min: 0.0, max: 1000.0, percentage: 0.10, tags: "Public Transportation Services Airlines and Aviation Services Vehicle Gas Travel Service Taxi")
expenses = Category.create(name: "Subscriptions and Expenses", min: 0.0, max: 2000.0, percentage: 0.07, tags: "Recurring Recreation Subscription Donations Telecommunication Services")
material_goods = Category.create(name: "Material Goods", min: 0.0, max: 800.0, percentage: 0.09, tags: "Shops")
venmo = Category.create(name: "Venmo", min: 0.0, max: 5000.0, percentage: 0.08, tags: "Venmo")
interest = Category.create(name: "Interest", min: 0.0, max: 5000.0, percentage: 0.08, tags: "Interest Earned")
misc = Category.create(name: "Misc", min: 0.0, max: 5000.0, percentage: 0.08, tags: "null")




