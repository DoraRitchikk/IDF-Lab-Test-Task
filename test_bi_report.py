import pandas as pd
import matplotlib.pyplot as plt
import mysql.connector

def main():
    host = "localhost"
    user = "root"
    password = "8885Mi7890"
    database = "sales"

    #Connection to MySQL db
    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    sql_query = "SELECT * FROM sales.transactions"

    df = pd.read_sql(sql_query, connection)

    #Calculate new rows
    df['order_date'] = pd.to_datetime(df['order_date'])

    df['sales'] = df['sales_qty'] * df['sales_amount']

    df_2020 = df[df['order_date'].dt.year == 2020]

    sales_trend = df_2020.groupby(['order_date', 'product_code'])['sales'].sum().reset_index()

    sales_trend['growth_rate'] = sales_trend.groupby('product_code')['sales'].pct_change() * 100
    
    sales_trend['month'] = sales_trend['order_date'].dt.month
    
    #report table
    report = sales_trend[["month","product_code","sales","growth_rate"]]
    print(report)

    #Drawing chart using matplot 
    plt.figure(figsize=(12, 6))
    for product, data in sales_trend.groupby('product_code'):
        plt.plot(data['order_date'], data['sales'], label=product)

    #x and y axis
    plt.xlabel('Month')
    plt.ylabel('Sales')

    plt.title('Sales Trend for Each Product in 2020 by month')
    plt.legend()
    plt.grid(True)
    plt.show()


    connection.close()

if __name__ == '__main__':
    main()


