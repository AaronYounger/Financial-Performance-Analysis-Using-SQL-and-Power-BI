# Financial-Performance-Analysis-and-Forecasting-with-SQL-and-Power-BI

## README
In this project I analyzed ledger data from Kuehne + Nagel to uncover and describe financial performance. This was done using SQL for data preparation and Power BI for visualization and forecasting.

**Note:** Due to confidentiality, the original Excel data files are not included in this repository. Certain column names have also been anonymized within Power BI to protect sensitive information.

### Data Cleaning and Transformation (SQL)
To prepare and structure the excel ledger data given from Kuehne + Nagel I used SQL to clean and transform the dataset to be appropriate for visualization in Power BI.

- **Fixed data types** for financial and date fields so columns acted predictably during analysis. 
- **Parsed the GL_Account field:** The first two numbers of a GL_account determines the account category, so I extracted the first two numbers into a new column called account group.
- **Joined the chart of accounts table** to attach descriptive labels so each account would be easier to interpret.
- **Classified accounts** into either revenue or expense based on their account group.
- **Transformed Values** in the original dataset, revenue was recorded as a negative and expense as a positive. I reveresed this so that positive numbers reflected gains and negative numbers reflected costs, hoping to make the results easier to understand.

[View SQL Code for Data Preparation](SQL%20code.sql)

### Data Visualization in PowerBI 
Two business questions needed to be answered by the report:
1. How is LC Amount (LC = Local Currency) affected by accounts?
2. How has LC Amount changed over time, and what will it look like in the next five years?

### General Overview Page
To answer the first business question I used a general overview page and a drillthrough page. The **Overview Page** focused on broad financial metrics.
- **Grand Total LC Amount:** Displayed using a card visual to show LC Amount across the entire dataset.
- **Revenue and Expense:** A column chart compared total LC Amount by revenue and expense, which when added equaled the Grand Total LC Amount.
- **Year over Year change:** A column chart which displayed yearly changes in LC Amount. 
- **LC Amount by Center Group:** A bar chart showed total LC Amount by center group.
    - When a user selected a center group, accompanying cards updated dynamically above to show:
        - Proportional contribution to total revenue.
        - Proportional contribution to total expense.
        - Whether the center had a Net Profit or loss.
This page aims to give a snapshot of overall financial performance.

### Drillthrough Page
Since there a natural hierarchy was made, center groups to centers to account groups to individual accounts a drillthrough page was added to provide deeper insights.

- **Activation:** Selecting a center group enables a drillthrough button on the overview page. Once clicked on the user would go through the drill through page where he would look at details relating to the overview's selected center group.
- **Visuals**:
    - A card showing Total LC Amount for the chosen group.
    - A table showing individual centers, accounts, = LC Amount by account, and a desciption of each account. 
    - A bar chart showing how individual accounts contributed to LC Amount.
        - A slicer is available to filter and show only accounts above a user selected LC Amount. Default is set to any LC Amount.
    - A tree map visualizing the account groups that make up the selected center group
        - Revenue account groups are represented by green
        - Expense account groups are represented by red.
    - A filter that allows users to toggle between expense only and revenue only accounts.
- **Navigation:** A button is included for users to return back to the overview page and select a different cetner group.
This page aims to give users the ability to drill down from high-level metrics to account level details. 

### Time Series Analysis Page
For the second business question I created three different bookmark views of the same page, all including different visuals.

#### Total Bookmark View
The first bookmark view labled "Total" shows how LC Amount varied over time.

- **LC Amount over time:** Displayed as a line chart, using a drill down feature this graph shows how total LC amount changed over Years, Quarters, Months and Days. 
- **Key Influencers:** Using a key influencers visual this shows the key influencers to any increase or decrease in LC Amount.
- **Date filter:** A slicer is used to control what dates to look at for analysis.
- **LC Amount by Account Group:** Displayed as a bar chart, this graph shows LC Amount by each account Group and how it might vary due to changes in time.

#### Center Bookmark View
The next bookmark view labeled "Center" shows how LC Amount within Center groups varies over time.

- **LC Amount by Center Group Over Time:** Displayed using a line chart with Center Groups as small multiples, this chart allows users to track how each group is doing based on year, month, quarter, and day. 
- **Play Axis Scatter Plot:** This scatter plot has the center groups all as data points. The play axis allows users to see the progression of center groups throughout each quarter. This also allows users to see when each Center Group was created.
- **Center Group contribtuion by Year** Displayed using a matrix chart, the upper level shows the LC Amount each Center Group made per year. When a Center Group is selected a second level is shown showing how each individual center contributed to LC Amount per year. This helps to see when Centers started and which are still around.
- **Date Filter:** A slicer is used to control what dates to look at for analysis.

#### Forecast Bookmark View
The last bookmark labeled "Forecast" shows the projected total LC Amount for the next five years. Due to the data not having predictor variables forecasting relied on Power BI's built in forecasting model. This model uses an Exponential Smoothing model, which means each forecasted point is based on a weighted average of past values, where recent data points get more weight. It also adjusts for trend and seasonality.

- **Forecasted LC Amount:** Displayed using a line graph shows the current LC Amount along with the projected five years. 

[View report Images](Report%20Images)
[Download Power BI Report](Report.pbix)


### About Me
Hello, my name is **Aaron Younger**. I am an aspiring Data Analyst who is passionate about both descriptive and predictive analytics. I am driven to transform raw data into insights that answer key business questions. I also enjoy building models to help direct deeper analysis to further support decision making through anticipating future trends and uncovering areas for improvement. I enjoy presenting data in a clear way that is easy for any audience level to understand. I also design interactive reports and dashboards with the intent to communicate my findings while also enabling others to explore their own questions and discover insights for themselves.
