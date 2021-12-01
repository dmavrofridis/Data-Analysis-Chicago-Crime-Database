WITH filtered_trrs AS (
    SELECT officer_id, event_id, action_category FROM trr_trr
        JOIN trr_actionresponse ta on trr_trr.id = ta.trr_id
        WHERE cast(action_category as float) >= %(action_response)s
)
,
events AS(
SELECT count(officer_id) AS count, event_id FROM filtered_trrs
    GROUP BY  event_id)

,
linked_officer_ids AS (
    SELECT events.event_id, officer_id, count FROM events
        LEFT JOIN trr_trr ON events.event_id = trr_trr.event_id
        WHERE count > 1
)
,
linked_officers AS (
    SELECT first_name, middle_initial, last_name, gender, race, trr_count,
           trr_percentile, id FROM data_officer
            JOIN linked_officer_ids ON data_officer.id = linked_officer_ids.officer_id
    )

SELECT * FROM linked_officers