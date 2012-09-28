use warnings;
use Scalar::Util qw(looks_like_number);

open (DATA_FILE,"Lines.csv");
open (STATION_DATA,">MyStationsData.plist");
#	if ($line =~ m/^(\d+),([^,]+),(\d+),([\w|\s|_|\-|\.]+),([\w|\s|(|)|\.|\-|\\|\/]+),([\w|\s|\-|\.|(|)]*),[^,]*,([\d|\.]*),([\d|\.]*)/)

print STATION_DATA '<?xml version="1.0" encoding="UTF-8"?>'."\n".'<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">'."\n";
print STATION_DATA '<plist version="1.0">'."\n<dict>\n\t<key>ItemsList</key>\n\t<array>\n";

$count = 1;
while ($line = <DATA_FILE>)
{
	if ($line =~ m/^([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]*),([^,]*),([^,]*),/)
	{
        if (looks_like_number($1))
        {
            $count++;
            $line_id = $1;
            $line_name = $2;
            $station_id = $3;
            $raw_station_name = $4;
            $friendly_station_name = $5;
            $short_station_name = $6;
            $junction_name = $7;
            $latitude = $8;
            $longitude = $9;
            print STATION_DATA "\t\t<dict>\n";
            
            print STATION_DATA "\t\t\t<key>LineID</key>\n";
            print STATION_DATA "\t\t\t<integer>$1</integer>\n";
            
            print STATION_DATA "\t\t\t<key>LineName</key>\n";
            print STATION_DATA "\t\t\t<string>$2</string>\n";
            
            print STATION_DATA "\t\t\t<key>StationID</key>\n";
            print STATION_DATA "\t\t\t<integer>$3</integer>\n";
            
            $rsn = $raw_station_name;
            $rsn =~ s/&/&amp\;/ig;
            print STATION_DATA "\t\t\t<key>RawStationName</key>\n";
            print STATION_DATA "\t\t\t<string>$rsn</string>\n";
            
            $fsn = $friendly_station_name;
            $fsn =~ s/&/&amp\;/ig;
            print STATION_DATA "\t\t\t<key>FriendlyStationName</key>\n";
            print STATION_DATA "\t\t\t<string>$fsn</string>\n";
            
            $ssn = $short_station_name;
            $ssn =~ s/&/&amp\;/ig;
            print STATION_DATA "\t\t\t<key>ShortStationName</key>\n";
            print STATION_DATA "\t\t\t<string>$ssn</string>\n";
            
            $jn = $junction_name;
            $jn =~ s/&/&amp\;/ig;
            #chomp($7);
            
            print STATION_DATA "\t\t\t<key>JunctionStationName</key>\n";
            print STATION_DATA "\t\t\t<string>$jn</string>\n";

            print STATION_DATA "\t\t\t<key>Latitude</key>\n";
            if ($8) {
                print STATION_DATA "\t\t\t<real>$8</real>\n";
            }
            else {
                print STATION_DATA "\t\t\t<real>0</real>\n";
            }
            
            print STATION_DATA "\t\t\t<key>Longitude</key>\n";
            if ($9) {
                print STATION_DATA "\t\t\t<real>$9</real>\n";
            }
            else {
                print STATION_DATA "\t\t\t<real>0</real>\n";
            }
            print STATION_DATA "\t\t</dict>\n";
        }
	}
}
print STATION_DATA "\t</array>\n</dict>\n</plist>\n";

print "Found a total of ".$count." matches.\n";

close (DATA_FILE);
close (STATION_DATA);