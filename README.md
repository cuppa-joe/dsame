dsame
=====
**dsame** is a program to decode [EAS](http://en.wikipedia.org/wiki/Emergency_Alert_System)/[SAME](http://en.wikipedia.org/wiki/Specific_Area_Message_Encoding) (Emergency Alert System/Specific Area Message Encoding) alert messages. These messages are primarily used by the National Weather Service for weather-related warnings. DSame will decode a demodulated message, filter by SAME code ([US](http://www.nws.noaa.gov/nwr/coverage/county_coverage.html)/[CA](http://www.ec.gc.ca/meteo-weather/default.asp?lang=En&n=E5A4F19C-1)) and/or event, provide readable text or run another program.

**DO NOT RELY ON THIS PROGRAM WHEN INJURY OR DEATH MAY OCCUR!**

###Requirements:

* [Python](https://www.python.org/) 2.7+
* A [weather radio](www.nws.noaa.gov/nwr/), [RTL-SDR](http://www.rtl-sdr.com/about-rtl-sdr/) or other receiving/source device
* A demodulator, such as [multimon-ng](https://github.com/EliasOenal/multimon-ng/) ([Windows binaries](https://github.com/cuppa-joe/multimon-ng/releases))

###Command Line Options

```
usage: dsame [-h] [--msg MSG] [--same [SAME [SAME ...]]]
             [--event [EVENT [EVENT ...]]] [--lang LANG]
             [--loglevel {10,20,30,40,50}] [--text] [--no-text] [--version]
             [--call CALL] [--command COMMAND] [--source SOURCE]
```
####Options

Option          | Description                                                           | Example
:---------------|:----------------------------------------------------------------------|:----------------------                     
msg             | Message to decode. Omit to read from standard input                   | --msg "ZCZC-WXR-RWT-020103-020209-020091-020121-029047-029165-029095-029037+0030-1051700-KEAX/NWS"
same            | List of SAME codes to monitor                                         | --same 029165 029095
event           | List of event codes to monitor                                        | --event RWT TOR SVR
loglevel        | Set log level                                                         | --loglevel 10
text, no-text   | Output/Omit readable message text                                     | --text, --no-text
call            | Call an external program                                              | --call alert.sh
command         | External command line. Omit --call to send to standard output         | --command "Event Code: {EEE}" 
source          | Source script/program. See /scripts for examples                      | --source source.bat

#####Command Variable Substitution

Variable        | Description                       | Example           
:---------------|:----------------------------------|:------------------
 {ORG}          | Organization code                 | WXR
 {EEE}          | Event code                        | RWT
 {PSSCCC}       | Geographical area (SAME) codes    | 020103-020209-020091-020121-029047-029165-029095-029037
 {TTTT}         | Purge time code                   | 0030
 {JJJHHMM}      | Date code                         | 1051700
 {LLLLLLLL}     | Originator code                   | KEAX/NWS
 {COUNTRY}      | Country code                      | US
 {organization} | Organization name                 | National Weather Service
 {location}     | Originator location               | Pleasant Hill, Missouri
 {event}        | Event type                        | Required Weekly Test
 {start}        | Start time                        | 12:00 PM
 {end}          | End time                          | 12:30 PM
 {length}       | Length of event                   | 30 minutes
 {date}         | Local date                        | 04/15/15 12:00:38
 
###Sample Usage

Using a RTL-SDR dongle and multimon-ng to decode from standard input:

`rtl_fm -f 162.500M -M fm -s 22050 -E dc -p -14 -g 42  -|  multimon-ng -t raw -a EAS - | dsame.py --same 029165`

Using a source script to decode from standard input:

`dsame.py --same 029165 --source source.sh`

Decoding a message from the command line:

`dsame.py --msg "ZCZC-WXR-RWT-020103-020209-020091-020121-029047-029165-029095-029037+0030-1051700-KEAX/NWS" --text`

###Sample Output

>The National Weather Service in Pleasant Hill, Missouri has issued a Required Weekly Test valid until 12:30 PM for the following counties in Kansas: Leavenworth, Wyandotte, Johnson, Miami, and for the following counties in Missouri: Clay, Platte, Jackson, Cass. (KEAX/NWS)

###Known Issues

* SASMEX/SARMEX, a Mexican system for seismic alerts, is not implemented due to lack of documentation.
* A correct and complete list of ICAO location codes used by the National Weather Service messages is not available.
* Location detection may not be reliable for some locations with duplicate SAME codes.
* Date and time information may not be accurate when decoding old messages or messages from another time zone.
* Multimon-ng will not decode the same alert in succession. This should only be an issue during testing and can be avoided by alternating alerts.

