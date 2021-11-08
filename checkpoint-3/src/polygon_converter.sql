CREATE FUNCTION GetGeoJSON (@geo geography)
	RETURNS varchar(max)
	WITH SCHEMABINDING

AS
BEGIN
	DECLARE @Result varchar(max)
	SELECT  @Result = '{' +
    CASE @geo.STGeometryType()
        WHEN 'POINT' THEN
            '"type": "Point","coordinates":' +
            REPLACE(REPLACE(REPLACE(REPLACE(@geo.ToString(),'POINT ',''),'(','['),')',']'),' ',',')
        WHEN 'POLYGON' THEN
            '"type": "Polygon","coordinates":' +
            '[' + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@geo.ToString(),'POLYGON ',''),'(','['),')',']'),'], ',']],['),', ','],['),' ',',') + ']'
        WHEN 'MULTIPOLYGON' THEN
            '"type": "MultiPolygon","coordinates":' +
            '[' + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@geo.ToString(),'MULTIPOLYGON ',''),'(','['),')',']'),'], ',']],['),', ','],['),' ',',') + ']'
    ELSE NULL
    END
    +'}'

    RETURN @Result

END
GO