-- ===== Section: Data Cleaning =====
-- LC_Amount to correct data type
ALTER TABLE yr_download_clean 
ALTER COLUMN "LC_Amount" TYPE NUMERIC(12, 2)
USING "LC_Amount"::NUMERIC;
-- VC_Date to correct data type
ALTER TABLE yr_download_clean
ALTER COLUMN "VC_Date" TYPE DATE
USING TO_DATE("VC_Date", 'MM/DD/YYYY');
-- Making account column
ALTER TABLE yr_download_clean
ADD COLUMN Accounts VARCHAR;

UPDATE yr_download_clean
SET Accounts = SPLIT_PART("GL_Account", '-', 1);

select "accounts", sum("LC_Amount")
from yr_download_clean
group by "accounts"

select
	sum(y."LC_Amount"),
	"accounts",
	c."Description"
from yr_download_clean as y
left join chart_of_accounts as c on c."Account" = y.accounts
group by y."accounts", c."Description";

select "Centre", Count(distinct "accounts") as uniqueaccount, accounts, c."Description", "LC_Amount" 
from yr_download_clean as y
left join chart_of_accounts c on y.accounts = c."Account"
group by "Centre", accounts, c."Description", "LC_Amount"

-- first apperance of centers
select "Centre", MIN("VC_Date") as first_appearance
from yr_download_clean
group by "Centre" 
order by first_appearance 

-- Count of Transactions per date
SELECT "VC_Date", COUNT(distinct "VC_Number"), sum("LC_Amount")
FROM yr_download_clean
GROUP BY "VC_Date";

-- Transaction complexity
SELECT "VC_Number", COUNT(*) AS lines_per_transaction, SUM("LC_Amount" ) 
FROM yr_download_clean
GROUP BY "VC_Number";

SELECT "Centre" , accounts, SUM("LC_Amount" ) AS total_lc
FROM yr_download_clean
WHERE "Centre"  = 'D110'
GROUP BY "Centre" , accounts ;

alter table yr_download_clean 
add column account_group VARCHAR;

update yr_download_clean
set account_group = left(accounts, 2);

delete from yr_download_clean
where "account_group" in ('41', '42');

delete from yr_download_clean
where "account_group" is null

select
	account_group,
	sum("LC_Amount")
from yr_download_clean
group by account_group 

alter table yr_download_clean 
add column account_type VARCHAR(20)

update yr_download_clean
set account_type = case
	when left(account_group, 1) in ('4', '5') then 'Expense'
	when left(account_group, 1) = '3' then 'Revenue'
	else 'Other'
end;

select
	account_type,
	sum("LC_Amount" )
from yr_download_clean
group by account_type 

select
	sum(case when account_type = 'Revenue' then "LC_Amount" else 0 end) +
	sum(case when account_type = 'Expense' then "LC_Amount" else 0 end) as total_revenue
from yr_download_clean

alter table yr_download_clean
add column LC_Amount_Transformed numeric

update yr_download_clean
set LC_Amount_Transformed = "LC_Amount" * -1

select
	sum(case when account_type = 'Revenue' then lc_amount_transformed else 0 end) +
	sum(case when account_type = 'Expense' then lc_amount_transformed else 0 end) as total_revenue
from yr_download_clean

select
	account_type,
	sum(lc_amount_transformed)
from yr_download_clean
group by account_type 




