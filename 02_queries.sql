-- CareLoop Clinics SQL analysis. Run after load_data.sql and importing appointments_clean.csv into appointments.
-- 2.2 Clinic no-show rate (exclude clinics with <95 appointments)
SELECT c.clinic_name,c.city,COUNT(*) appointments,SUM(a.no_show) no_shows,ROUND(100*SUM(a.no_show)/COUNT(*),1) no_show_pct
FROM appointments a JOIN clinics c USING(clinic_id) GROUP BY c.clinic_id,c.clinic_name,c.city HAVING COUNT(*)>=95 ORDER BY no_show_pct DESC;
-- 2.3 Appointment lead time bands
SELECT CASE WHEN lead_days BETWEEN 1 AND 7 THEN '1-7' WHEN lead_days BETWEEN 8 AND 14 THEN '8-14' WHEN lead_days BETWEEN 15 AND 30 THEN '15-30' ELSE '31+' END lead_band, COUNT(*) appointments,SUM(no_show) no_shows,ROUND(100*SUM(no_show)/COUNT(*),1) no_show_pct FROM appointments GROUP BY lead_band ORDER BY MIN(lead_days);
-- 2.4 Month trend and percentage-point change
WITH monthly AS (SELECT DATE_FORMAT(appt_date,'%Y-%m') month,COUNT(*) appointments,SUM(no_show) no_shows,ROUND(100*SUM(no_show)/COUNT(*),1) no_show_pct FROM appointments GROUP BY month) SELECT *, no_show_pct-LAG(no_show_pct) OVER(ORDER BY month) change_pp FROM monthly ORDER BY month;
-- 2.5 rank clinics within each city and compare to city average
WITH rates AS (SELECT c.clinic_id,c.clinic_name,c.city,COUNT(*) appointments,ROUND(100*SUM(a.no_show)/COUNT(*),1) no_show_pct FROM appointments a JOIN clinics c USING(clinic_id) GROUP BY c.clinic_id,c.clinic_name,c.city), ranked AS (SELECT *,RANK() OVER(PARTITION BY city ORDER BY no_show_pct DESC) rank_in_city,AVG(no_show_pct) OVER(PARTITION BY city) city_avg FROM rates) SELECT *,CASE WHEN no_show_pct>city_avg THEN 'above' WHEN no_show_pct<city_avg THEN 'below' ELSE 'equal' END vs_city FROM ranked ORDER BY city,rank_in_city;
