-- For my Shree DR.MDD
UPDATE "rest-api"
SET result = (
  WITH
    user_data(name, info) AS (SELECT value ->> 'name', value FROM json_each(database, '$.users'))
  SELECT CASE url
  WHEN '/users' THEN (
    WITH
      request(user) AS (SELECT value FROM json_each(payload, '$.users'))
    SELECT iif(
      0 == (SELECT count() FROM request),
      database,
      (SELECT json_object('users', json_group_array(info)) FROM user_data, request
        WHERE user_data.name == user
        ORDER BY user)
    )
  )
  WHEN '/add' THEN (
    WITH
      request(name) AS (SELECT value FROM json_each(payload, '$.user'))
    SELECT json_object('name', (SELECT name FROM request), 'owes', json_object(), 'owed_by', json_object(), 'balance', 0)
  )
  WHEN '/iou' THEN (
    WITH
      request(lender, borrower, amount) AS (SELECT payload ->> 'lender', payload ->> 'borrower', payload ->> 'amount')
    SELECT (
      WITH
        lender_info(debit, credit, balance, info) AS (
          SELECT coalesce(info -> 'owed_by' ->> borrower, 0),
                 coalesce(info -> 'owes' ->> borrower, 0),
                 info ->> 'balance',
                 info
          FROM user_data WHERE user_data.name == lender
        ),
        borrower_info(credit, debit, balance, info) AS (
          SELECT coalesce(info -> 'owes' ->> lender, 0),
                 coalesce(info -> 'owed_by' ->> lender, 0),
                 info ->> 'balance',
                 info
          FROM user_data WHERE user_data.name == borrower
        ),
        updated_info(name, info) AS (
          SELECT borrower, (
            WITH
              borrower_update(info) AS (SELECT json_set(info, '$.balance', balance - amount)),
              debit_adjust(amount, debit) AS (SELECT amount - min(amount, debit), debit - min(amount, debit)),
              borrower_final(amount, info) AS (
                SELECT amount, json_patch(info, json_object('owed_by', json_object(lender, iif(debit == 0, null, debit))))
                FROM borrower_update, debit_adjust
              ),
              borrower_complete(info) AS (SELECT json_patch(info, json_object('owes', json_object(lender, iif(credit + amount == 0, null, credit + amount)))) FROM borrower_final)
            SELECT info FROM borrower_complete
          ) FROM borrower_info
          UNION ALL
          SELECT lender, (
            WITH
              lender_update(info) AS (SELECT json_set(info, '$.balance', balance + amount)),
              credit_adjust(amount, credit) AS (SELECT amount - min(amount, credit), credit - min(amount, credit)),
              lender_final(amount, info) AS (
                SELECT amount, json_patch(info, json_object('owes', json_object(borrower, iif(credit == 0, null, credit))))
                FROM lender_update, credit_adjust
              ),
              lender_complete(info) AS (SELECT json_patch(info, json_object('owed_by', json_object(borrower, iif(debit + amount == 0, null, debit + amount)))) FROM lender_final)
            SELECT info FROM lender_complete
          ) FROM lender_info
        ),
        ordered_updates(info) AS (SELECT info FROM updated_info ORDER BY name)
      SELECT json_object('users', json_group_array(json(info))) FROM ordered_updates
    )
    FROM request
  )
  END
);