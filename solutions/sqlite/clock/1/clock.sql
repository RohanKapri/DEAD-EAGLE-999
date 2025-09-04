ALTER TABLE clock ADD minutes INT;
UPDATE clock
SET minutes = (input ->> 'hour') * 60 + (input ->> 'minute')
WHERE property != 'equal';
UPDATE clock
SET minutes = minutes + (input ->> 'value')
WHERE property = 'add';
UPDATE clock
SET minutes = minutes - (input ->> 'value')
WHERE property = 'subtract';
UPDATE clock
SET result = printf('%02d:%02d', (minutes % 1440 + 1440) % 1440 / 60, (minutes % 60 + 60) % 60)
WHERE property != 'equal';
UPDATE clock
SET result = ((input -> 'clock1' ->> 'hour') * 60 + (input -> 'clock1' ->> 'minute') - ((input -> 'clock2' ->> 'hour') * 60 + (input -> 'clock2' ->> 'minute'))) % 1440 == 0
WHERE property = 'equal';