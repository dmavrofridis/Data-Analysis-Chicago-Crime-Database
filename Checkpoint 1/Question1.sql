{\rtf1\ansi\ansicpg1252\cocoartf2580
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 ArialMT;\f1\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sl441\partightenfactor0

\f0\fs32 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 select EXTRACT(YEAR FROM incident_date) as incident,\'a0 count(is_extracted_summary) as count from data_allegation\'a0
\f1\fs24 \

\f0\fs32 group by incident\'a0
\f1\fs24 \

\f0\fs32 order by incident
\f1\fs24 \
}