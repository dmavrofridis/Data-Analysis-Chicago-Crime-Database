{\rtf1\ansi\ansicpg1252\cocoartf2580
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Arial-BoldItalicMT;\f1\fswiss\fcharset0 ArialMT;\f2\froman\fcharset0 Times-Roman;
}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\i\b\fs32 \cf2 \expnd0\expndtw0\kerning0
\ul \ulc2 \outl0\strokewidth0 \strokec2 #How did the allegation numbers change with time?\
\
\pard\pardeftab720\sl441\partightenfactor0

\f1\i0\b0 \cf2 \ulnone select EXTRACT(YEAR FROM incident_date) as incident,\'a0 count(is_extracted_summary) as count from data_allegation\'a0
\f2\fs24 \

\f1\fs32 group by incident\'a0
\f2\fs24 \

\f1\fs32 order by incident
\f2\fs24 \
}