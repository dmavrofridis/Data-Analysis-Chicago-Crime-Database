DROP TABLE IF EXISTS partners;
CREATE TEMP TABLE partners AS (
    SELECT a.officer_id AS officer_id_a, b.officer_id AS officer_id_b
        FROM data_officerassignmentattendance a, data_officerassignmentattendance b
        WHERE a.start_timestamp = b.start_timestamp AND a.beat_id = b.beat_id
        AND a.present_for_duty AND b.present_for_duty AND a.officer_id <> b.officer_id
            GROUP BY a.officer_id, b.officer_id
            HAVING count(*) > 100

);
DROP TABLE IF EXISTS connected;
CREATE TEMP TABLE connected AS (
WITH filtered_trrs AS (
    SELECT officer_id, event_id, trr_datetime, action_category FROM trr_trr
        JOIN trr_actionresponse ta on trr_trr.id = ta.trr_id
        WHERE cast(action_category as float) >= %(action_response)s
)
,
events AS(
SELECT count(officer_id) AS count, event_id, trr_datetime FROM filtered_trrs
    GROUP BY  event_id, trr_datetime)

,
linked_officer_ids AS (
    SELECT events.event_id, officer_id, count FROM events
        LEFT JOIN trr_trr ON events.event_id = trr_trr.event_id
        WHERE count > 1
)
,
officer_connections AS (
    SELECT A.officer_id AS officer_id1, B.officer_id AS officer_id2, A.event_id AS event_id
        FROM linked_officer_ids A, linked_officer_ids B
        WHERE A.event_id = B.event_id
            AND A.officer_id <> B.officer_id

        ORDER BY officer_id1
)

SELECT officer_id1 as src, officer_id2 as dst,  event_id FROM officer_connections );
SELECT * FROM connected WHERE (src, dst) NOT IN (SELECT * FROM partners)