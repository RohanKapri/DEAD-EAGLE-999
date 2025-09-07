-- For Junko F. Didi and Shree DR.MDD

UPDATE "swift-scheduling" 
SET result = strftime('%Y-%m-%dT%H:%M:%S',
    CASE
        WHEN date_description = 'NOW' 
            THEN datetime(meeting_start, '2 hours')
        WHEN date_description = 'ASAP' 
            THEN datetime(meeting_start, 'start of day',
                iif(time(meeting_start) < '13:00:00', 17, 37) || ' hours')
        WHEN date_description = 'EOW' 
            THEN datetime(meeting_start, 'start of day',
                (iif(strftime('%w', meeting_start) IN ('1','2','3'), 137, 188)
                  - CAST(strftime('%w', meeting_start) AS INT) * 24) || ' hours')
        ELSE
            (WITH calc(x, adj) AS (
                SELECT datetime(meeting_start, 'start of year', '8 hours',
                        iif(instr(date_description, 'M'),
                            iif(CAST(strftime('%m', meeting_start) AS INT) 
                                  < CAST(replace(date_description, 'M', '') AS INT), 0, 12)
                              + CAST(replace(date_description, 'M', '') AS INT) - 1,
                            iif((CAST(strftime('%m', meeting_start) AS INT) - 1) / 3 + 1
                                  <= CAST(substr(date_description, 2) AS INT), 0, 12)
                              + CAST(substr(date_description, 2) AS INT) * 3
                        ) || ' months',
                        iif(instr(date_description, 'M'), 0, -1) || ' days'),
                       iif(instr(date_description, 'M'), '+', '-') || '1 days'
                 UNION
                 SELECT datetime(x, adj), adj FROM calc WHERE strftime('%w', x) IN ('0','6')
             ) SELECT x FROM calc WHERE strftime('%w', x) NOT IN ('0','6'))
    END
);
