use aivariant_project;
select * from projects;
-- query for no of backers
select concat(round(sum(backers_count)/1000000,0)," M ") as number_of_backers from projects;

-- % of successful project overall

select concat(round((COUNT(CASE WHEN state = 'Successful' THEN 1 END) * 100.0)/ COUNT(projectid),2)," %") AS successful_projects_Overall
FROM projects;

-- % Total amount raised
select concat(round(sum(usd_pledged)/1000000,2)," M ") as amount_raised_in_usd from projects;
-- successful projects
select concat(round(COUNT(CASE WHEN state = 'Successful' THEN 1 END)/1000,0)," K ") as successful_projects from projects;

-- Total Project by location
select l.country, count(p.projectid) as total_no_of_Projects from projects p inner join location_1 l on p.location_id=l.id 
group by l.country order by count(p.projectid) desc;
-- total project by category
select c. name , count(p.projectid) as total_no_of_Projects_by_Category from projects p inner join crowdfunding_category c  on p.category_id=c.id 
group by c. name  order by count(p.projectid) desc;
-- total project by outcome
select state, count(projectid) from projects
group by state
order by count(projectid) desc;
-- top 6 project by backers
select c.name, sum(p.backers_count) as total_backer_count from projects p join crowdfunding_category c on p.category_id= c.id
-- where p.state= "successful"
group by c.name order by sum(p.backers_count) desc limit 6;

select c.name, sum(p.static_usd_rate) as total_amount_raised_in_USD from projects p join crowdfunding_category c on p.category_id= c.id
where p.state= "successful"
group by c.name order by sum(p.static_usd_rate) desc limit 6;

-- top 6 project by goal amount 
select c.name, sum(p.goal) as top_6_projects_by_goal, (sum(p.goal)/1723226382)*100 as percent_top_6_projects_by_goal from projects p join crowdfunding_category c on p.category_id= c.id
-- where p.state= "successful"
group by c.name order by sum(p.goal) desc limit 6;


select c.name, sum(p.goal) as top_6_projects_by_goal from projects p join crowdfunding_category c on p.category_id= c.id
where p.state= "successful"
group by c.name with rollup order by sum(p.goal) desc;

select Created_at_new
from converted_2;


use aivariant_project;

desc converted_2;

alter table converted_2
modify Created_at_New date;

desc converted_2;

alter table converted_2
modify updated_at_New date;

desc converted_2;
alter table converted_2
modify successful_at_New date;

desc converted_2;

alter table calendar_table
modify Date date;

desc calendar_table;
-- project by goal range
select Goal_Range, count(id) as Total_Projects
from converted_2
group by Goal_Range;
-- avg no of days
select concat(round(avg(Days_to_complete),0)," Days") as Avg_no_of_days
from converted_2;

-- project by static USD
select state, sum(Static_usd) from converted_2 
group by state order by sum(Static_usd) desc;

-- project by Y,Q,M

select year, quarter, Month_Name, count(C.id) as Projects from converted_2 C join calendar_table D on C.Created_at_New=D.date
group by year,quarter,Month_Name order by year;
-- project by Y,Q,M Descending
select year, quarter, Month_Name, count(C.id) as Projects from converted_2 C join calendar_table D on C.Created_at_New=D.date
group by year,quarter,Month_Name order by count(C.id) desc;

-- Successful project by Y,Q,M
select year, quarter, Month_Name, count(C.id) as Projects from converted_2 C join calendar_table D on C.Created_at_New=D.date
where state="successful"
group by year,quarter,Month_Name order by year;









