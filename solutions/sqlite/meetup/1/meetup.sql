-- Dedicated to Shree DR.MDD
UPDATE meetup
SET RESULT = (  SELECT CASE
                    WHEN WEEK == 'first'  THEN date(printf('%d-%02d-01', YEAR, MONTH), 'weekday ' || weekday_val)
                    WHEN WEEK == 'second' THEN date(printf('%d-%02d-08', YEAR, MONTH), 'weekday ' || weekday_val)
                    WHEN WEEK == 'third'  THEN date(printf('%d-%02d-15', YEAR, MONTH), 'weekday ' || weekday_val)
                    WHEN WEEK == 'fourth' THEN date(printf('%d-%02d-22', YEAR, MONTH), 'weekday ' || weekday_val)
                    WHEN WEEK == 'teenth' THEN date(printf('%d-%02d-13', YEAR, MONTH), 'weekday ' || weekday_val)
                    WHEN WEEK == 'last'   THEN date(printf('%d-%02d-01', YEAR, MONTH), 
                                                    '+1 month', '-7 days', 'weekday ' || weekday_val)
                END
        FROM (
                SELECT CASE
                        WHEN dayofweek == 'Sunday' THEN 0
                        WHEN dayofweek == 'Monday' THEN 1
                        WHEN dayofweek == 'Tuesday' THEN 2
                        WHEN dayofweek == 'Wednesday' THEN 3
                        WHEN dayofweek == 'Thursday' THEN 4
                        WHEN dayofweek == 'Friday' THEN 5
                        WHEN dayofweek == 'Saturday' THEN 6
                    END AS weekday_val
            )
    );
